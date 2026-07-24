provider "aws" {
  region = var.aws_region
}

locals {
  common_tags = {
    Project = var.project_name
    Managed = "terraform"
  }
}

resource "aws_security_group" "app_host" {
  name        = "${var.project_name}-app-host"
  description = "Access rules for the two-tier DevSecOps Docker host"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from admin CIDR only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  ingress {
    description = "HTTP app access"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = [var.allowed_http_cidr]
  }

  egress {
    description = "Outbound internet access for package and image downloads"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-app-host-sg"
  })
}

resource "aws_instance" "app_host" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [aws_security_group.app_host.id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  user_data                   = file("${path.module}/user_data.sh")

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-app-host"
  })
}

