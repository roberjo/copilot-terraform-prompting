# S3 Example

This example creates a versioned S3 bucket with tags. It is intentionally minimal to keep the focus on core concepts.

## Files
- `main.tf`: S3 bucket and versioning
- `variables.tf`: project_name and environment
- `outputs.tf`: bucket name

## How to use
1) Set `project_name` and `environment`.
2) Run `terraform init` and `terraform apply`.
