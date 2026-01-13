# Terraform Modularization Example

This example shows how to move a resource into a reusable module and then call it from a root configuration.

## Why modularize
- Reuse the same pattern across environments
- Keep root configs small and readable
- Make testing and versioning easier

## Structure
```
examples/modules/
  root/
    main.tf
    variables.tf
    outputs.tf
  modules/
    s3-bucket/
      main.tf
      variables.tf
      outputs.tf
```

## Module: `modules/s3-bucket`
The module creates a versioned S3 bucket and returns its name and ARN.

## Root: `root/`
The root config passes `project_name` and `environment` into the module and exposes the outputs.

## How to use
1) Go to `examples/modules/root/`
2) Set `project_name` and `environment`
3) Run `terraform init` and `terraform apply`
