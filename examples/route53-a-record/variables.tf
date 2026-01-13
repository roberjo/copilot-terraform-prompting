variable "hosted_zone_id" {
  type        = string
  description = "Route 53 hosted zone ID."
}

variable "record_name" {
  type        = string
  description = "DNS name to create (e.g., api.example.com)."
}

variable "record_value" {
  type        = string
  description = "A record target (IPv4 address)."
  default     = ""
}

variable "use_alias" {
  type        = bool
  description = "When true, create an alias record instead of a standard A record."
  default     = false
}

variable "alias_name" {
  type        = string
  description = "Alias target DNS name (for API Gateway custom domain, CloudFront, etc.)."
  default     = ""
}

variable "alias_zone_id" {
  type        = string
  description = "Hosted zone ID for the alias target."
  default     = ""
}
