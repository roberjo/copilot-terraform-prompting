# Lambda Example

This example creates a Lambda function using a local zip file and an existing IAM role.

## Files
- `main.tf`: Lambda function
- `variables.tf`: project_name, environment, role_arn, lambda_zip_path
- `outputs.tf`: function name and ARN

## How to use
1) Create a zip file named `lambda.zip` with an `index.js` and handler.
2) Provide `role_arn` from the IAM example.
3) Run `terraform init` and `terraform apply`.
