---
name: tf-plan
description: Runs terraform plan and summarizes the infrastructure changes without modifying files
allowed-tools: Bash, Read, Grep
disable-model-invocation: true
---

# Terraform Plan Execution

1. Navigate to the `terraform/` directory.
2. Run `terraform plan -no-color`.
3. Read and analyze the command output:
   - If successful: Summarize planned additions, changes, or destructions.
   - If an error occurs (such as missing credentials/auth error): Explain the error clearly and state the required fix.
