# Modules Example

This example shows how to modularize a simple S3 bucket so it can be reused across environments.

## Structure
- `root/`: root configuration calling the module
- `modules/s3-bucket/`: reusable module

## How to use
1) Go to `examples/modules/root/`
2) Set `project_name` and `environment`
3) Run `terraform init` and `terraform apply`
