# Modules Example

This example shows how to modularize a simple S3 bucket so it can be reused across environments.

## Structure
- `root/`: root configuration calling the module
- `modules/s3-bucket/`: reusable module

## How to use
1) Go to `examples/modules/root/`
2) Set `project_name` and `environment`
3) Run `terraform init` and `terraform apply`

## How the module gets its values (simple explanation)
The root config passes values into the module in the `module "s3_bucket"` block.
Inside the module, `modules/s3-bucket/variables.tf` defines the variables the module accepts as inputs.
The module resources read those variables and use them when naming and configuring resources.
