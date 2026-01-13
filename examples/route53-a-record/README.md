# Route 53 A Record Example

This example creates a simple A record in an existing hosted zone. Use this to point a domain at an API or other endpoint.

## Files
- `main.tf`: Route 53 record
- `variables.tf`: hosted_zone_id, record_name, record_value

## How to use
1) Provide an existing hosted zone ID.
2) Provide the record name and value.
3) Run `terraform init` and `terraform apply`.
