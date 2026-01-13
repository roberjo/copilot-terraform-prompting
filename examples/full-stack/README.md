# Full Stack Demo (End-to-End)

This example outlines how to wire the pieces together. It is a scaffold meant for the live demo.

## Planned structure
- `main.tf`: provider, backend, and resources
- `variables.tf`: shared variables
- `outputs.tf`: primary outputs (bucket, lambda, api endpoint)

## Notes
- Use Terraform Cloud backend for state in real deployments.
- For educational demos, you can temporarily use local state.
