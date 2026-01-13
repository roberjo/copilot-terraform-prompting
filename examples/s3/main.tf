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

resource "aws_s3_bucket" "assets" {
  # The bucket name uses project + environment for clarity.
  bucket = "${var.project_name}-${var.environment}-assets"

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "assets" {
  # Versioning protects against accidental deletes or overwrites.
  bucket = aws_s3_bucket.assets.id

  versioning_configuration {
    status = "Enabled"
  }
}
