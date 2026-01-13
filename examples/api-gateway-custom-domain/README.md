# API Gateway Custom Domain + Base Path Mapping

This example shows how to attach a custom domain to a REST API, map a base path to a stage, and create a Route 53 alias record.

## Assumptions
- You already have an ACM certificate for the domain (in the same region as API Gateway).
- You already have a REST API and a deployed stage.
- You have access to the Route 53 hosted zone.

## Files
- `main.tf`: Custom domain, base path mapping, and Route 53 alias record
- `variables.tf`: Domain, certificate, API, stage, and hosted zone inputs
- `outputs.tf`: Custom domain and alias details

## How to use
1) Provide the REST API ID and stage name.
2) Provide the ACM certificate ARN.
3) Provide the hosted zone ID for your domain.
4) Run `terraform init` and `terraform apply`.

## Notes
- Base path mapping with an empty base path maps the root of the domain to the API stage.
- If you want `api.example.com/v1`, set `base_path = "v1"`.
