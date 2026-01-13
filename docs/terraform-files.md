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
- `aws_api_gateway_rest_api` + `aws_api_gateway_resource` + `aws_api_gateway_method` + `aws_api_gateway_integration`

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
- `aws_api_gateway_rest_api`: The API container
- `aws_api_gateway_resource`: Defines the path (e.g., /hello)
- `aws_api_gateway_method`: Attaches an HTTP method
- `aws_api_gateway_integration`: Links API -> Lambda
- `aws_api_gateway_deployment`: Publishes the API to a stage
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

## Terraform state (technical overview)

### What state is
- **Definition:** A state file is Terraform’s record of what it believes exists in your infrastructure, including resource IDs and metadata.
- **Why it matters:** Terraform uses state to map your configuration to real-world resources and to calculate what must change.

### How state works
- When you run `apply`, Terraform updates state with the real IDs returned by the provider.
- When you run `plan`, Terraform compares your configuration + current state to live infrastructure.
- State is stored locally by default, or remotely in Terraform Cloud when configured.

### Why state is important
- **Resource tracking:** Without state, Terraform cannot tell if a resource already exists.
- **Dependency ordering:** Terraform uses state references to create resources in the correct order.
- **Change detection:** Terraform plans changes by diffing config/state/live data.

### What drift is
- **Definition:** Drift occurs when real infrastructure changes outside of Terraform.
- **Common causes:** Manual console changes, CI jobs, or other tools modifying resources.

### How drift is detected
- During `plan`, Terraform refreshes data from the provider to see the current live values.
- If the live values differ from state/config, Terraform reports differences in the plan output.

### Core commands

#### `terraform init`
- **What it does:** Downloads provider plugins, initializes backend, and sets up the working directory.
- **Why it matters:** No Terraform actions work until `init` has successfully prepared the environment.

#### `terraform plan`
- **What it does:** Calculates the proposed changes without making them.
- **Why it matters:** It is the safe review step to validate what will be created, modified, or destroyed.

#### `terraform apply`
- **What it does:** Executes the plan and updates state with the real resource IDs.
- **Why it matters:** It is the only step that changes infrastructure.
