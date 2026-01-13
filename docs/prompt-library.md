# Prompt Library (Beginner Friendly)

Each prompt is written to be copied into GitHub Copilot Chat. After Copilot responds, review the code and adjust names/regions as needed.

## 1) Base Terraform setup
**Goal:** Create the provider, backend, and common variables.

Prompt:
"""
Create Terraform files for AWS in us-east-1 with:
- provider block
- required_version
- variables for project_name and environment
- Terraform Cloud backend (workspace name: demo-copilot)
Use clear comments and keep it beginner-friendly.
"""

Why it helps:
- Establishes a consistent foundation for all resources.
- Introduces variables and remote state early.

## 2) S3 bucket for app storage
**Goal:** Create a versioned S3 bucket with basic tags.

Prompt:
"""
Create an S3 bucket for app storage named "${project_name}-${environment}-assets".
Enable versioning and add tags for Project and Environment.
Return main.tf + outputs.tf.
"""

Why it helps:
- Demonstrates naming conventions and lifecycle basics.
- Outputs are useful for wiring into other resources.

## 3) IAM role and policy for Lambda
**Goal:** Add a least-privilege role for Lambda.

Prompt:
"""
Create an IAM role for Lambda with assume role policy for lambda.amazonaws.com.
Add a policy that allows:
- CloudWatch Logs (create log group/stream, put log events)
- Read/write to the S3 bucket created earlier
Attach the policy to the role.
"""

Why it helps:
- Shows how IAM roles connect to services.
- Reinforces least privilege.

## 4) Lambda function (zip-based)
**Goal:** Add a simple Lambda function wired to the IAM role.

Prompt:
"""
Create an AWS Lambda function using a local zip file path (lambda.zip).
Use runtime nodejs18.x and handler index.handler.
Attach the IAM role we created earlier.
Add an output for the function name and ARN.
"""

Why it helps:
- Demonstrates the minimum required fields for Lambda.
- Sets up outputs for downstream resources.

## 5) API Gateway integration
**Goal:** Create an HTTP API and connect it to Lambda.

Prompt:
"""
Create an API Gateway HTTP API that integrates with the Lambda function.
Add a route for GET /hello.
Grant API Gateway permission to invoke the Lambda.
Output the API endpoint.
"""

Why it helps:
- Shows an end-to-end path from request to Lambda.
- Adds a usable endpoint to test.

## 6) Security group (for future networked resources)
**Goal:** Add a security group for any VPC-based resources.

Prompt:
"""
Create a security group named "${project_name}-${environment}-sg".
Allow inbound HTTPS (443) from the internet and all outbound.
Use a VPC ID variable called vpc_id.
"""

Why it helps:
- Introduces VPC-awareness in a safe, isolated way.
- Prepares for ECS/RDS or VPC Lambda examples later.

## 7) Route 53 A record (standard)
**Goal:** Add a simple A record for a custom domain.

Prompt:
"""
Create a Route 53 A record in an existing hosted zone.
Use variables: hosted_zone_id, record_name, record_value.
Set TTL to 300.
"""

Why it helps:
- Explains how DNS ties into app endpoints.
- Uses a simple IP-based example.

## 8) Route 53 alias record (API Gateway custom domain)
**Goal:** Add a Route 53 alias record for API Gateway custom domain.

Prompt:
"""
Create a Route 53 alias A record in an existing hosted zone.
Use variables: hosted_zone_id, record_name, alias_name, alias_zone_id.
Use an alias block and disable evaluate_target_health.
"""

Why it helps:
- Mirrors how API Gateway custom domains are typically wired.
- Shows the difference between standard A records and alias records.
