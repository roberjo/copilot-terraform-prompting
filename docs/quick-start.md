# Quick Start (Beginner Friendly)

This is a guided sequence that chains the examples into a working demo.

## 1) Pick basic values
- `project_name`: a short name like `demo`
- `environment`: `dev`
- `aws_region`: `us-east-1`

## 2) Create the S3 bucket
- Go to `examples/s3/`
- Set `project_name` and `environment`
- Apply and copy the `bucket_name` output

## 3) Create the IAM role
- Go to `examples/iam/`
- Set `project_name`, `environment`, and `bucket_arn`
- Apply and copy the `lambda_role_arn` output

## 4) Package a Lambda zip
- Follow `docs/lambda-zip-tutorial.md`
- Keep the zip path as `lambda.zip`

## 5) Create the Lambda function
- Go to `examples/lambda/`
- Set `project_name`, `environment`, and `role_arn`
- Apply and copy the `lambda_function_arn` output

## 6) Create the HTTP API
- Go to `examples/api-gateway/`
- Set `project_name`, `environment`, and `lambda_arn`
- Apply and copy the `api_endpoint` output

## 7) (Optional) Add Route 53 DNS
- Go to `examples/route53-a-record/`
- Set `hosted_zone_id` and `record_name`
- For API Gateway custom domains, use the alias option

## 8) Validate
- Call `GET /hello` on the API endpoint
- Check Lambda logs in CloudWatch
