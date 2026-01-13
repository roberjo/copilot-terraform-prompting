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
  # The bucket name uses project + environment for clarity.
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
  # This trust policy allows the Lambda service to assume the role.
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda" {
  # The execution role is required for every Lambda function.
  name               = "${var.project_name}-${var.environment}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume_lambda.json
}

resource "aws_iam_policy" "lambda_access" {
  # Least-privilege policy for logs and S3 access.
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
  # Attach the policy to the role so Lambda can use it.
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

resource "aws_apigatewayv2_api" "http_api" {
  # HTTP APIs are the simplest option for Lambda-backed endpoints.
  name          = "${var.project_name}-${var.environment}-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda" {
  # Connect the API to the Lambda function using AWS_PROXY.
  api_id             = aws_apigatewayv2_api.http_api.id
  integration_type   = "AWS_PROXY"
  integration_uri    = aws_lambda_function.hello.arn
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "hello" {
  # A route maps an HTTP method + path to the integration.
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "GET /hello"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  # $default allows requests without specifying a stage name.
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_lambda_permission" "api_invoke" {
  # Allow API Gateway to invoke the Lambda function.
  statement_id  = "AllowApiGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.hello.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.http_api.execution_arn}/*/*"
}
