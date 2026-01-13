# copilot-terraform-prompting
Prompting guide for github copilot to create terraform resources.

This guide will be a short tutorial on using prompting in github copilot to generate AWS resources in VSCode with the required terraform cloud IaC files.

## Meeting kit
- Agenda: `docs/agenda.md`
- Demo flow: `docs/demo-flow.md`
- Demo script: `docs/demo-script.md`
- Architecture overview: `docs/architecture.md`
- Prompt library: `docs/prompt-library.md`
- Quick start: `docs/quick-start.md`
- Examples index: `examples/README.md`

## Step-by-step guide
1) Start here for the overall flow: `docs/quick-start.md`
2) Review the architecture and request flow: `docs/architecture.md`
3) Use the prompt library as you build: `docs/prompt-library.md`
4) Follow the resource examples in order:
   - S3: `examples/s3/`
   - IAM: `examples/iam/`
   - Lambda: `examples/lambda/`
   - API Gateway: `examples/api-gateway/`
   - Security Groups: `examples/security-groups/`
   - Route 53 A record: `examples/route53-a-record/`
5) Use the end-to-end scaffold when ready: `examples/full-stack/`
6) For live sessions, use the meeting kit:
   - Agenda: `docs/agenda.md`
   - Demo flow: `docs/demo-flow.md`

The guide should assume the users are new to the concepts of AWS resources, new to Terraform Cloud IaC, and prefer to use ASP.NET, Python, or Node.js for backend resources, and React or Next.js (Vite) for frontend apps.

## Prerequisites
- AWS account with permissions to create the in-scope resources
- Terraform Cloud organization and a workspace
- VS Code with GitHub Copilot enabled
- AWS CLI configured locally (for testing and validation)

## Assumptions
- A single AWS account and region are used for the walkthrough
- Terraform Cloud runs are VCS-driven (workspace linked to a repo)
- Terraform state is stored in Terraform Cloud workspaces for deployments, with an optional local state example for educational use
- DNS is managed in an existing Route 53 hosted zone

## AWS resources in scope
- Lambda
- S3
- API Gateway
- IAM
- Security Groups
- Route 53 DNS A records

## Prompt library
See `docs/prompt-library.md` for beginner-friendly prompts with explanations.
