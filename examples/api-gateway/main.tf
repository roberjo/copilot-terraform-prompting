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
  uri                     = var.lambda_arn
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
  function_name = var.lambda_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}
