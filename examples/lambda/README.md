# Lambda Example

This example creates a Lambda function using a local zip file and an existing IAM role.

## Files
- `main.tf`: Lambda function
- `variables.tf`: project_name, environment, role_arn, lambda_zip_path
- `outputs.tf`: function name and ARN
- `index.js`: sample handler for a quick zip

## How to use
1) Use `index.js` or create your own handler file.
2) Zip it: `zip lambda.zip index.js`.
3) Provide `role_arn` from the IAM example.
4) Run `terraform init` and `terraform apply`.
