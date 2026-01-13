# API Gateway Example

This example creates a REST API and integrates it with an existing Lambda function.

## Files
- `main.tf`: REST API + resource + method + integration + deployment + permission
- `variables.tf`: project_name, environment, lambda_arn, stage_name
- `outputs.tf`: API endpoint

## What each resource does (and why it exists)

### `aws_api_gateway_rest_api`
- **What it does:** Creates an API Gateway REST API container.
- **Why it is needed:** It is the top-level API object that holds resources, methods, and integrations.

### `aws_api_gateway_resource`
- **What it does:** Defines a path under the API root (for example, `/hello`).
- **Why it is needed:** REST APIs require explicit resources for each path.

### `aws_api_gateway_method`
- **What it does:** Attaches an HTTP method (GET) to the `/hello` resource.
- **Why it is needed:** Methods are the entry points that clients call.

### `aws_api_gateway_integration`
- **What it does:** Connects the method to Lambda using a proxy integration.
- **Why it is needed:** This is the link that tells API Gateway which backend to invoke.

### `aws_api_gateway_deployment`
- **What it does:** Packages the API configuration and publishes it to a stage.
- **Why it is needed:** REST APIs must be deployed before they are callable.

### `aws_lambda_permission`
- **What it does:** Grants API Gateway permission to invoke the Lambda function.
- **Why it is needed:** Lambda is locked down by default; this permission is required for API Gateway to call it.

## API Gateway stages (quick overview)
- **What it is:** A named snapshot of your REST API deployment (e.g., `dev`, `prod`).
- **How it works:** The stage is created when you deploy the API and becomes part of the invoke URL.
- **Why it matters:** Stages let you separate environments and safely test changes before prod.
For a blue/green example, see `docs/api-gateway-blue-green.md`.

## Blue/green stages (example + steps)

### Terraform snippet
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

resource "aws_api_gateway_base_path_mapping" "api" {
  domain_name = aws_api_gateway_domain_name.custom.domain_name
  rest_api_id = aws_api_gateway_rest_api.api.id

  # Switch this value from "blue" to "green" to move traffic.
  stage_name = var.active_stage
}
```

### Steps
1) Deploy to `blue` and `green` stages.
2) Test the `green` stage using its invoke URL.
3) Update `active_stage` from `blue` to `green` and apply.
4) Roll back by switching `active_stage` back to `blue` if needed.

## How to use
1) Provide `lambda_arn` from the Lambda example.
2) Optionally set `stage_name` (default is `prod`).
3) Run `terraform init` and `terraform apply`.
