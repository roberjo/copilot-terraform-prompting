variable "project_name" {
  type        = string
  description = "Short name for the project."
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, staging, prod)."
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy into."
  default     = "us-east-1"
}

variable "lambda_zip_path" {
  type        = string
  description = "Path to the Lambda deployment zip file."
  default     = "lambda.zip"
}
