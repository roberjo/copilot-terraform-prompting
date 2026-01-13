terraform {
  # Require a recent Terraform version for consistent behavior.
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

provider "aws" {
  # Region is required so the provider knows where to create resources.
  region = "us-east-1"
}

data "aws_iam_policy_document" "assume_lambda" {
  # Trust policy: allows the Lambda service to assume this role.
  # Without this, Lambda cannot use the role.
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda" {
  # Execution role for Lambda functions.
  # The role is required for Lambda to access other AWS services.
  name               = "${var.project_name}-${var.environment}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume_lambda.json
}

resource "aws_iam_policy" "lambda_access" {
  # Permission policy: defines what the role can do.
  # This example allows CloudWatch Logs and S3 access only.
  name = "${var.project_name}-${var.environment}-lambda-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = [
          var.bucket_arn,
          "${var.bucket_arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_access" {
  # Attach the permission policy to the execution role.
  # Lambda needs the policy attached to inherit permissions.
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda_access.arn
}
