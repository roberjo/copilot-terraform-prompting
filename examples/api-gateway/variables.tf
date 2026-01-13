variable "project_name" {
  type        = string
  description = "Short name for the project."
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, staging, prod)."
}

variable "lambda_arn" {
  type        = string
  description = "ARN of the Lambda function to integrate."
}

variable "stage_name" {
  type        = string
  description = "Stage name for the REST API deployment."
  default     = "prod"
}
