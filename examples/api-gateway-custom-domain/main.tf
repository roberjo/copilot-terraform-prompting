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
  region = var.aws_region
}

resource "aws_api_gateway_domain_name" "custom" {
  # Custom domain name for the REST API.
  domain_name = var.domain_name

  # ACM certificate must be in the same region as the API.
  regional_certificate_arn = var.certificate_arn

  endpoint_configuration {
    # Use REGIONAL for simple setups and Route 53 alias records.
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_base_path_mapping" "api" {
  # Map the custom domain to an API and stage.
  domain_name = aws_api_gateway_domain_name.custom.domain_name
  rest_api_id = var.rest_api_id
  stage_name  = var.stage_name

  # Empty base_path maps the root of the domain to the API.
  base_path = var.base_path
}

resource "aws_route53_record" "api_alias" {
  # Route 53 alias record pointing the domain at API Gateway.
  zone_id = var.hosted_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_api_gateway_domain_name.custom.regional_domain_name
    zone_id                = aws_api_gateway_domain_name.custom.regional_zone_id
    evaluate_target_health = false
  }
}
