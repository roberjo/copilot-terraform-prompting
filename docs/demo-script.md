# Demo Script (Prompts + Expected Output)

This is a step-by-step script you can read during a live demo. Each step includes a prompt to paste into Copilot Chat and a short description of what you should see.

## 1) Base Terraform setup
Prompt:
"""
Create Terraform files for AWS in us-east-1 with:
- provider block
- required_version
- variables for project_name and environment
- Terraform Cloud backend (workspace name: demo-copilot)
Use clear comments and keep it beginner-friendly.
"""

Expected output:
- `main.tf` with provider and required providers
- `variables.tf` for `project_name` and `environment`
- `terraform` block showing a Terraform Cloud backend

## 2) S3 bucket
Prompt:
"""
Create an S3 bucket named "${project_name}-${environment}-assets".
Enable versioning and add tags for Project and Environment.
Return main.tf + outputs.tf.
"""

Expected output:
- `aws_s3_bucket` resource with tags
- `aws_s3_bucket_versioning` enabled
- `outputs.tf` for bucket name

## 3) IAM role and policy for Lambda
Prompt:
"""
Create an IAM role for Lambda with assume role policy for lambda.amazonaws.com.
Add a policy that allows:
- CloudWatch Logs (create log group/stream, put log events)
- Read/write to the S3 bucket created earlier
Attach the policy to the role.
"""

Expected output:
- IAM role with assume role policy
- IAM policy for logs + S3 access
- Policy attachment to the role

## 4) Lambda function
Prompt:
"""
Create an AWS Lambda function using a local zip file path (lambda.zip).
Use runtime nodejs18.x and handler index.handler.
Attach the IAM role we created earlier.
Add an output for the function name and ARN.
"""

Expected output:
- `aws_lambda_function` resource
- `outputs.tf` with function name and ARN

## 5) API Gateway integration
Prompt:
"""
Create an API Gateway HTTP API that integrates with the Lambda function.
Add a route for GET /hello.
Grant API Gateway permission to invoke the Lambda.
Output the API endpoint.
"""

Expected output:
- HTTP API resource
- Integration and route
- Lambda permission for API Gateway
- Output with API endpoint

## 6) Security group (optional)
Prompt:
"""
Create a security group named "${project_name}-${environment}-sg".
Allow inbound HTTPS (443) from the internet and all outbound.
Use a VPC ID variable called vpc_id.
"""

Expected output:
- Security group with inbound 443 rule
- Egress rule allowing all outbound
- Variable for `vpc_id`

## 7) Route 53 standard A record
Prompt:
"""
Create a Route 53 A record in an existing hosted zone.
Use variables: hosted_zone_id, record_name, record_value.
Set TTL to 300.
"""

Expected output:
- `aws_route53_record` with type A and TTL 300
- Variables for hosted zone and record values

## 8) Route 53 alias record (API Gateway custom domain)
Prompt:
"""
Create a Route 53 alias A record in an existing hosted zone.
Use variables: hosted_zone_id, record_name, alias_name, alias_zone_id.
Use an alias block and disable evaluate_target_health.
"""

Expected output:
- `aws_route53_record` using an alias block
- Variables for alias name + zone ID
