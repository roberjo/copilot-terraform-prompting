# Live Demo Flow

## Setup (before the meeting)
- Ensure Terraform Cloud org/workspace is ready
- Ensure Route 53 hosted zone exists
- Confirm AWS credentials have required permissions

## Flow (live)
1) Open `README.md` and review scope + assumptions
2) Generate base Terraform: provider, backend, variables
3) Add S3 bucket + IAM role/policy
4) Add Lambda function + REST API Gateway integration
5) Add Security Group(s) for any networked resources
6) (Optional) Add custom domain + base path mapping
7) Add Route 53 A record pointing to the API Gateway custom domain (if used)
7) Run a plan/apply via Terraform Cloud
8) Validate output (invoke API, check logs)

## Wrap-up prompts
- “What changes if we add a second environment?”
- “How do we enforce least privilege?”
- “Which resource should be modularized first?”
