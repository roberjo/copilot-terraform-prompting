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
  # Region is required so the provider knows where to create resources.
  region = "us-east-1"
}

resource "aws_s3_bucket" "assets" {
  # The bucket is the storage container used by the app.
  # Naming uses project + environment to avoid collisions.
  bucket = "${var.project_name}-${var.environment}-assets"

  # Tags help track cost and ownership in AWS.
  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "assets" {
  # Versioning is configured separately from the bucket resource.
  # It protects against accidental deletes or overwrites.
  bucket = aws_s3_bucket.assets.id

  versioning_configuration {
    status = "Enabled"
  }
}
