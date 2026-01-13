terraform {
  # Module-level version constraint for consistent behavior.
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

resource "aws_s3_bucket" "assets" {
  # The bucket is the storage container used by the app.
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
