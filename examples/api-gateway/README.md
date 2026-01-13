# API Gateway Example

This example creates an HTTP API and integrates it with an existing Lambda function.

## Files
- `main.tf`: API Gateway + integration + route + stage + permission
- `variables.tf`: project_name, environment, lambda_arn
- `outputs.tf`: API endpoint

## What each resource does (and why it exists)

### `aws_apigatewayv2_api`
- **What it does:** Creates an API Gateway HTTP API container.
- **Why it is needed:** It is the top-level API object that holds routes, integrations, and stages.

### `aws_apigatewayv2_integration`
- **What it does:** Connects the HTTP API to the Lambda function using an AWS proxy integration.
- **Why it is needed:** This is the link that tells API Gateway which backend to invoke.

### `aws_apigatewayv2_route`
- **What it does:** Defines an HTTP method + path (e.g., `GET /hello`) that maps to the integration.
- **Why it is needed:** Without a route, the API has no endpoints to call.

### `aws_apigatewayv2_stage`
- **What it does:** Creates the `$default` stage and enables auto-deploy.
- **Why it is needed:** Stages are how API Gateway publishes your routes so they can be called.

### `aws_lambda_permission`
- **What it does:** Grants API Gateway permission to invoke the Lambda function.
- **Why it is needed:** Lambda is locked down by default; this permission is required for API Gateway to call it.

## How to use
1) Provide `lambda_arn` from the Lambda example.
2) Run `terraform init` and `terraform apply`.
