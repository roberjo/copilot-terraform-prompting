# API Gateway Blue/Green with Stages

This example shows how to run two stages (blue/green) for a REST API and switch traffic by changing a base path mapping.

## Concept
- **Blue** = current stable stage
- **Green** = new stage being validated
- Switch traffic by updating the base path mapping to point at the new stage

## Terraform example

```hcl
resource "aws_api_gateway_deployment" "blue" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "blue"

  depends_on = [aws_api_gateway_integration.lambda]
}

resource "aws_api_gateway_deployment" "green" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "green"

  depends_on = [aws_api_gateway_integration.lambda]
}

resource "aws_api_gateway_domain_name" "custom" {
  domain_name             = var.domain_name
  regional_certificate_arn = var.certificate_arn

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_base_path_mapping" "api" {
  domain_name = aws_api_gateway_domain_name.custom.domain_name
  rest_api_id = aws_api_gateway_rest_api.api.id

  # Switch this value from "blue" to "green" to move traffic.
  stage_name = var.active_stage
}
```

## How to use it
1) Deploy the API to both stages.
2) Test the green stage using its invoke URL.
3) When ready, update `active_stage` from `blue` to `green` and apply.

## Why this works
- Stages are isolated snapshots of your API.
- The base path mapping decides which stage the custom domain routes to.
- Switching the mapping is fast and reversible.
