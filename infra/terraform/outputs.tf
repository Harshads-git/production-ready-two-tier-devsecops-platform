output "instance_id" {
  description = "EC2 instance ID."
  value       = aws_instance.app_host.id
}

output "public_ip" {
  description = "Public IP address for the EC2 Docker host."
  value       = aws_instance.app_host.public_ip
}

output "app_url" {
  description = "HTTP URL for the Flask app on port 5000."
  value       = "http://${aws_instance.app_host.public_ip}:5000"
}

output "security_group_id" {
  description = "Security group ID attached to the EC2 Docker host."
  value       = aws_security_group.app_host.id
}

