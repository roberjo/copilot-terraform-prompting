variable "project_name" {
  type        = string
  description = "Short name for the project."
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, staging, prod)."
}

variable "bucket_arn" {
  type        = string
  description = "ARN of the S3 bucket the Lambda can access."
}
