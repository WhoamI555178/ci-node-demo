variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID for Ubuntu EC2 instance"
  type        = string
  default     = "ami-021bf0bba3a411792"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the AWS EC2 Key Pair"
  type        = string
  default     = "devops-key"
}

variable "private_key_path" {
  description = "Path to local SSH private key (.pem)"
  type        = string
  default     = "./devops-key.pem"
}
