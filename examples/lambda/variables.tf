variable "project_name" {
  type        = string
  description = "Short name for the project."
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, staging, prod)."
}

variable "role_arn" {
  type        = string
  description = "ARN of the IAM role the Lambda will assume."
}

variable "lambda_zip_path" {
  type        = string
  description = "Path to the Lambda deployment zip file."
  default     = "lambda.zip"
}
