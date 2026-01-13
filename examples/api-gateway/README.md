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

## How to use
1) Provide `lambda_arn` from the Lambda example.
2) Optionally set `stage_name` (default is `prod`).
3) Run `terraform init` and `terraform apply`.
