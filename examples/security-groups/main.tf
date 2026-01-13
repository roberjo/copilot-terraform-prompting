terraform {
  # Require a recent Terraform version for consistent behavior.
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

provider "aws" {
  # Pick a default region so beginners can run quickly.
  region = "us-east-1"
}

resource "aws_security_group" "app" {
  # Security groups act as firewalls for VPC resources.
  name        = "${var.project_name}-${var.environment}-sg"
  description = "Basic security group for app resources."
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    # Allow outbound traffic so resources can reach the internet.
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}
