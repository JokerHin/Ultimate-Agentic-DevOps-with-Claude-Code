---
name: scaffold-terraform
description: Scaffolds AWS S3 and CloudFront Terraform modules for static site hosting
allowed-tools: Bash, Read, Write, Grep
---

# Scaffold Terraform Infrastructure

Follow the instructions in `template-spec.md` to generate the Terraform files inside the `terraform/` directory.

## Steps

1. Read `template-spec.md` in this directory.
2. Create the `terraform/` root directory if it does not exist.
3. Generate the required Terraform configuration files:
   - `main.tf`
   - `variables.tf`
   - `outputs.tf`
   - `providers.tf`
4. Confirm completion and output a full list of created files with a short summary.
