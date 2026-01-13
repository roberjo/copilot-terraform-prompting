terraform {
  # Root config pins Terraform and providers for repeatable demos.
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "s3_bucket" {
  # Local module path for the example.
  source = "../modules/s3-bucket"

  project_name = var.project_name
  environment  = var.environment
}
