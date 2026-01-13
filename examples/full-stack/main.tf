terraform {
  # Require a recent Terraform version for consistent behavior.
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }

  # For real deployments, use Terraform Cloud workspaces.
  # backend "remote" {
  #   organization = "your-org"
  #   workspaces {
  #     name = "demo-copilot"
  #   }
  # }
}

provider "aws" {
  # Keep the region configurable for easy reuse.
  region = var.aws_region
}

resource "aws_s3_bucket" "assets" {
  # The bucket is the storage container used by the app.
  # Naming uses project + environment to avoid collisions.
  bucket = "${var.project_name}-${var.environment}-assets"

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "assets" {
  # Versioning protects against accidental deletes or overwrites.
  bucket = aws_s3_bucket.assets.id

  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_iam_policy_document" "assume_lambda" {
  # Trust policy: allows the Lambda service to assume this role.
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
  name               = "${var.project_name}-${var.environment}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume_lambda.json
}

resource "aws_iam_policy" "lambda_access" {
  # Permission policy: allows logs and S3 access.
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
          aws_s3_bucket.assets.arn,
          "${aws_s3_bucket.assets.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_access" {
  # Attach the policy so the role can use it.
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda_access.arn
}

resource "aws_lambda_function" "hello" {
  # Simple Lambda using a local zip file.
  function_name = "${var.project_name}-${var.environment}-hello"
  role          = aws_iam_role.lambda.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"

  filename         = var.lambda_zip_path
  source_code_hash = filebase64sha256(var.lambda_zip_path)
}

resource "aws_api_gateway_rest_api" "api" {
  # REST API container for resources, methods, and integrations.
  name = "${var.project_name}-${var.environment}-api"
}

resource "aws_api_gateway_resource" "hello" {
  # Create the /hello path under the API root.
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "hello"
}

resource "aws_api_gateway_method" "hello_get" {
  # Define the GET /hello method.
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.hello.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  # Link the method to Lambda using proxy integration.
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.hello.id
  http_method = aws_api_gateway_method.hello_get.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.hello.arn
}

resource "aws_api_gateway_deployment" "api" {
  # Deployment publishes the API configuration to a stage.
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = var.stage_name

  # Force a new deployment when the integration changes.
  depends_on = [aws_api_gateway_integration.lambda]
}

resource "aws_lambda_permission" "api_invoke" {
  # Allow API Gateway to invoke the Lambda function.
  statement_id  = "AllowApiGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.hello.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}
