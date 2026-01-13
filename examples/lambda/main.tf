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

resource "aws_lambda_function" "hello" {
  # The Lambda function runs code in response to events.
  # Name includes project + environment for clarity.
  function_name = "${var.project_name}-${var.environment}-hello"

  # Execution role defines what the function is allowed to do.
  role = var.role_arn

  # Handler is the file + function name inside the zip.
  handler = "index.handler"

  # Runtime tells Lambda how to execute the code.
  runtime = "nodejs18.x"

  # Zip-based deployment is the simplest approach for beginners.
  filename         = var.lambda_zip_path
  source_code_hash = filebase64sha256(var.lambda_zip_path)
}
