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
  # Pick a default region so beginners can run quickly.
  region = "us-east-1"
}

resource "aws_route53_record" "a_record" {
  # Standard A record that points to an IPv4 address.
  count   = var.use_alias ? 0 : 1
  zone_id = var.hosted_zone_id
  name    = var.record_name
  type    = "A"
  ttl     = 300

  records = [var.record_value]
}

resource "aws_route53_record" "alias_record" {
  # Alias A record for AWS targets like API Gateway custom domains.
  count   = var.use_alias ? 1 : 0
  zone_id = var.hosted_zone_id
  name    = var.record_name
  type    = "A"

  alias {
    name                   = var.alias_name
    zone_id                = var.alias_zone_id
    evaluate_target_health = false
  }
}
