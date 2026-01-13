output "lambda_function_name" {
  description = "Name of the Lambda function."
  value       = aws_lambda_function.hello.function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function."
  value       = aws_lambda_function.hello.arn
}
