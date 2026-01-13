output "bucket_name" {
  description = "Name of the S3 bucket."
  value       = aws_s3_bucket.assets.bucket
}

output "lambda_function_name" {
  description = "Name of the Lambda function."
  value       = aws_lambda_function.hello.function_name
}

output "api_endpoint" {
  description = "Base URL of the HTTP API."
  value       = aws_apigatewayv2_api.http_api.api_endpoint
}
