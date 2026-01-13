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

resource "aws_lambda_function" "hello" {
  # The function name uses project + environment for clarity.
  function_name = "${var.project_name}-${var.environment}-hello"
  role          = var.role_arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"

  # Zip-based deployment is the simplest way to start.
  filename         = var.lambda_zip_path
  source_code_hash = filebase64sha256(var.lambda_zip_path)
}
