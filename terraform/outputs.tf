output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.nodeapp_server.id
}

output "instance_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.nodeapp_server.public_ip
}
