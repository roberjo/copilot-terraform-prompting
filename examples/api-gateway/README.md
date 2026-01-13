# API Gateway Example

This example creates an HTTP API and integrates it with an existing Lambda function.

## Files
- `main.tf`: API Gateway + integration + route + permission
- `variables.tf`: project_name, environment, lambda_arn
- `outputs.tf`: API endpoint

## How to use
1) Provide `lambda_arn` from the Lambda example.
2) Run `terraform init` and `terraform apply`.
