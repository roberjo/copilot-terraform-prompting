output "api_endpoint" {
  description = "Base URL of the REST API stage."
  value       = aws_api_gateway_deployment.api.invoke_url
}
