# Security Groups Example

This example creates a basic security group allowing inbound HTTPS and all outbound traffic.

## Files
- `main.tf`: Security group
- `variables.tf`: project_name, environment, vpc_id
- `outputs.tf`: security group ID

## How to use
1) Provide `vpc_id` for your VPC.
2) Run `terraform init` and `terraform apply`.
