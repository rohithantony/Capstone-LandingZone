# Copilot Instructions

## Project
This repository contains a Terraform-based Azure Landing Zone.

## Terraform Standards
- Use Terraform with the AzureRM provider.
- Prefer reusable Terraform modules over duplicated resources.
- Follow the existing repository structure and module conventions.
- Do not hardcode secrets, passwords, private keys, subscription IDs, tenant IDs, or client secrets.
- Use variables, environment variables, GitHub Actions variables, or Azure-managed authentication where appropriate.
- Keep Terraform code formatted with `terraform fmt`.
- Code must pass `terraform validate`.

## Azure Naming
Follow the existing naming convention in the repository.
Use lowercase names with hyphens where Azure resource naming permits.

## Required Tags
Resources should use the existing standard tags:

- Environment
- Project
- ManagedBy

Do not introduce inconsistent tag names.

## Security
- Workload VMs should not use public IP addresses unless explicitly required.
- Prefer private connectivity.
- Use NSGs to explicitly control network traffic.
- SSH access should be restricted to trusted internal sources such as Azure Bastion.
- Do not weaken existing security controls merely to make Terraform apply succeed.
- Never commit secrets or private keys.

## Networking
- Preserve the existing Hub-and-Spoke architecture.
- Do not create unnecessary spoke-to-spoke peering.
- Respect the existing route tables and Azure Firewall design.
- Do not modify CIDR ranges unless explicitly required.

## Infrastructure Changes
Before making changes:
1. Inspect existing modules and environment configuration.
2. Reuse existing modules where possible.
3. Keep changes focused on the requested requirement.
4. Explain assumptions when generating Terraform.
5. Review generated code before committing it.

## Validation
Before creating a pull request, run:

terraform fmt -check -recursive
terraform validate
Checkov or tfsec

Then run:

terraform plan

Never run `terraform apply` locally as part of normal pull-request validation unless explicitly required.