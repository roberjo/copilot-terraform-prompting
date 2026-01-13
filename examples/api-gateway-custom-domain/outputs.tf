output "custom_domain_name" {
  description = "Custom domain name for the API."
  value       = aws_api_gateway_domain_name.custom.domain_name
}

output "regional_domain_name" {
  description = "API Gateway regional domain name used by the alias record."
  value       = aws_api_gateway_domain_name.custom.regional_domain_name
}

output "regional_zone_id" {
  description = "Hosted zone ID for the API Gateway regional domain."
  value       = aws_api_gateway_domain_name.custom.regional_zone_id
}
