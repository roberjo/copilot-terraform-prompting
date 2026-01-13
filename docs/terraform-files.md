# Terraform Files: How They Work (Beginner Guide)

This guide explains the common Terraform file pieces you will see in this project, what they do, and why they are required.

## Core file types

### `main.tf`
- **What it is:** The primary file where resources are declared.
- **Why it matters:** Terraform reads all `.tf` files in a folder and builds a dependency graph. Most resources live here.

### `variables.tf`
- **What it is:** Definitions for input variables (e.g., `project_name`, `environment`).
- **Why it matters:** Variables make your configuration reusable and keep hard-coded values out of resources. They also centralize inputs so beginners can change settings in one place.

### `outputs.tf`
- **What it is:** Named values exposed after `apply` (e.g., API endpoint, bucket name).
- **Why it matters:** Outputs make it easy to pass values between steps or modules.

## Other common Terraform blocks

### `locals`
- **What it is:** A way to define calculated values inside a configuration.
- **Why it matters:** Locals reduce repetition and keep complex expressions readable (for example, building a standardized resource name).

### `data` sources
- **What it is:** Read-only lookups of existing infrastructure (for example, a VPC ID or an AMI).
- **Why it matters:** Data sources let you reference resources that were not created in the current configuration.

## Required blocks (what you see in each example)

### `terraform` block
- **What it does:** Sets Terraform version constraints and provider requirements.
- **Why it is needed:** Ensures consistent behavior and locks to a compatible provider version.

### `provider` block
- **What it does:** Configures the AWS provider (region, credentials).
- **Why it is needed:** Resources are tied to a provider; without it, Terraform cannot talk to AWS. It also defines defaults like region and tags.

### Provider version locking
- **What it is:** Pinning providers to a known version range (e.g., `>= 5.0.0`).
- **Why it matters:** Providers change behavior over time. Locking prevents unexpected breaking changes during demos or training.

### `backend` (Terraform Cloud)
- **What it does:** Stores state remotely in Terraform Cloud workspaces.
- **Why it is needed:** Remote state is safer and enables collaboration. Local state is allowed for education only.

## Common resource patterns

### Resource + supporting resource
Many AWS resources require a second resource for configuration. Examples:
- `aws_s3_bucket` + `aws_s3_bucket_versioning`
- `aws_apigatewayv2_api` + `aws_apigatewayv2_route` + `aws_apigatewayv2_integration`

### IAM trust + permission
IAM for Lambda typically needs two parts:
- **Trust policy** (who can assume the role)
- **Permission policy** (what the role can do)

## Why dependencies work automatically
Terraform builds a graph from references. When one resource uses another (e.g., `aws_lambda_function` references `aws_iam_role.lambda.arn`), Terraform automatically creates them in the correct order.

## Required pieces by example

### S3 example
- `aws_s3_bucket`: Creates the bucket
- `aws_s3_bucket_versioning`: Enables versioning to protect data

### IAM example
- `aws_iam_role`: Lambda execution role
- `aws_iam_policy`: Least-privilege permissions
- `aws_iam_role_policy_attachment`: Attaches the policy to the role

### Lambda example
- `aws_lambda_function`: Deploys the function using a local zip

### API Gateway example
- `aws_apigatewayv2_api`: The API container
- `aws_apigatewayv2_integration`: Links API -> Lambda
- `aws_apigatewayv2_route`: Exposes an HTTP path
- `aws_apigatewayv2_stage`: Publishes the API
- `aws_lambda_permission`: Lets API Gateway invoke Lambda

### Security group example
- `aws_security_group`: Firewall rules for VPC resources

### Route 53 example
- `aws_route53_record`: DNS record (standard or alias)

## Tips for beginners
- Start with one resource and apply.
- Use outputs to pass values to the next example.
- Keep names consistent with `project_name` and `environment`.
- Read the comments in each `main.tf` for the why behind each resource.
