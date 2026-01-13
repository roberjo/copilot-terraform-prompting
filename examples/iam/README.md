# IAM Example

This example creates a basic IAM role for Lambda with a least-privilege policy for CloudWatch Logs and S3 access.

## Files
- `main.tf`: IAM role + policy
- `variables.tf`: project_name, environment, bucket_arn
- `outputs.tf`: role ARN

## How to use
1) Provide `bucket_arn` from the S3 example.
2) Run `terraform init` and `terraform apply`.
