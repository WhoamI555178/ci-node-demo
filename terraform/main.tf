terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "nodeapp_sg" {
  name        = "nodeapp-terraform-sg"
  description = "Allow SSH (22) and Node.js app (3000) inbound traffic"

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Node.js app port"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nodeapp-terraform-sg"
  }
}

resource "aws_instance" "nodeapp_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.nodeapp_sg.id]

  user_data = <<-USERDATA
              #!/bin/bash
              apt-get update -y
              apt-get install -y docker.io
              systemctl enable --now docker
              usermod -aG docker ubuntu
              USERDATA

  tags = {
    Name = "nodeapp-terraform-ec2"
  }
}
