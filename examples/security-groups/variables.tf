variable "project_name" {
  type        = string
  description = "Short name for the project."
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, staging, prod)."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the security group will be created."
}
