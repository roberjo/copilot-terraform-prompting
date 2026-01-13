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

resource "aws_apigatewayv2_api" "http_api" {
  # The API container that holds routes, integrations, and stages.
  # HTTP APIs are the simplest option for Lambda-backed endpoints.
  name          = "${var.project_name}-${var.environment}-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda" {
  # Integration connects the API to the Lambda backend.
  # AWS_PROXY forwards the full request to Lambda.
  api_id             = aws_apigatewayv2_api.http_api.id
  integration_type   = "AWS_PROXY"
  integration_uri    = var.lambda_arn
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "hello" {
  # Route defines the HTTP method + path for the API.
  # It points to the integration created above.
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "GET /hello"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  # Stages publish routes so they are callable.
  # $default avoids needing a stage name in the URL.
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_lambda_permission" "api_invoke" {
  # Lambda is locked down by default.
  # This permission lets API Gateway invoke the function.
  statement_id  = "AllowApiGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.http_api.execution_arn}/*/*"
}
