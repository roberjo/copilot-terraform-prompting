variable "aws_region" {
  type        = string
  description = "AWS region for API Gateway and ACM certificate."
  default     = "us-east-1"
}

variable "domain_name" {
  type        = string
  description = "Custom domain name (e.g., api.example.com)."
}

variable "certificate_arn" {
  type        = string
  description = "ACM certificate ARN for the domain."
}

variable "rest_api_id" {
  type        = string
  description = "REST API ID to map to the custom domain."
}

variable "stage_name" {
  type        = string
  description = "Stage name to map (e.g., prod)."
}

variable "base_path" {
  type        = string
  description = "Base path to map (empty string maps the root)."
  default     = ""
}

variable "hosted_zone_id" {
  type        = string
  description = "Route 53 hosted zone ID for the domain."
}
