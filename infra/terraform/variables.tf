variable "aws_region" {
  description = "AWS region for the EC2 deployment."
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Name prefix for project resources."
  type        = string
  default     = "two-tier-devsecops"
}

variable "vpc_id" {
  description = "Existing VPC ID where the EC2 instance will run."
  type        = string
}

variable "public_subnet_id" {
  description = "Existing public subnet ID for the EC2 instance."
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the Docker host."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the Docker host."
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Existing EC2 key pair name for SSH access."
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed to SSH into the host. Use your own IP with /32."
  type        = string
}

variable "allowed_http_cidr" {
  description = "CIDR allowed to access HTTP during testing."
  type        = string
  default     = "0.0.0.0/0"
}

