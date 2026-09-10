# Capstone Landing Zone

Terraform-based Azure Landing Zone implementation using a Hub-and-Spoke architecture. The default configuration deploys the landing-zone foundation while leaving high-cost components disabled.

## Environments

- DEV
- TEST
- PROD

## Core Components

- Hub VNet
- Spoke VNets
- VNet Peering
- Azure Firewall
- Azure Bastion
- VPN Gateway
- Network Security Groups
- Route Tables
- Azure Key Vault
- Private Endpoints
- DNS Private Resolver
- Log Analytics
- Azure Policies
- Terraform Remote State
- GitHub Actions CI/CD

## Repository Layout

- `state-management/`: creates the Azure Storage Account backend used by the other roots.
- `governance/policies/`: assigns the allowed-location and required-tag policies.
- `environments/hub/`: creates the shared Hub VNet, subnets, DNS, private DNS, and Log Analytics.
- `environments/dev/`, `environments/test/`, `environments/prod/`: create spoke VNets, route tables, NSGs, peering, Key Vaults, and private endpoints.

Each Terraform root has its own state file. Run commands from the repository root and use the matching `terraform -chdir=...` path.

## Prerequisites

- Terraform `1.15.8` or newer.
- Azure CLI authenticated to the target subscription.
- Permissions to create resource groups, networking, Key Vault, Log Analytics, Private DNS, and subscription policy assignments.
- The `rg-tfstate` resource group, `sttfstatecapstone01` storage account, and `tfstate` container must exist before initializing the environment roots.

Do not commit secrets, private keys, subscription IDs, or tenant IDs. Supply sensitive values through environment variables or a local untracked `.tfvars` file.

## Deployment Order

Deploy roots in this order so remote state and policy dependencies exist before dependent resources:

1. Create the remote state backend from `state-management/`.
2. Apply `governance/policies/` with `subscription_id` set.
3. Plan and apply `environments/hub/`.
4. Plan and apply `environments/dev/`, `environments/test/`, and `environments/prod/` as needed.

Example commands:

```powershell
terraform -chdir=state-management init
terraform -chdir=state-management plan
terraform -chdir=state-management apply

terraform -chdir=governance/policies init
terraform -chdir=governance/policies plan -var="subscription_id=$env:ARM_SUBSCRIPTION_ID"
terraform -chdir=governance/policies apply -var="subscription_id=$env:ARM_SUBSCRIPTION_ID"

terraform -chdir=environments/hub init
terraform -chdir=environments/hub plan
terraform -chdir=environments/hub apply

terraform -chdir=environments/dev init
terraform -chdir=environments/dev plan
terraform -chdir=environments/dev apply
```

Run the same `init`, `plan`, and `apply` commands for `test` and `prod` when those environments are required.

## Optional Costly Components

The default environment configuration keeps Azure Firewall, Azure Bastion, the DEV Linux VM, and firewall-dependent spoke routes disabled. The landing-zone networking, route tables, peering, private endpoints, DNS, Key Vaults, NSGs, and monitoring remain deployable.

Enable components in the relevant environment `terraform.tfvars` before planning:

- Hub Firewall: set `enable_firewall = true`.
- Hub Bastion: set `enable_bastion = true`.
- DEV Linux VM: set `enable_linux_vm = true` and provide `ssh_public_key`.
- DEV, TEST, and PROD firewall routes: set `enable_firewall_route = true` only after the Hub Firewall exists and its private IP matches `firewall_private_ip`.

To disable a component again, set its flag to `false` and run `terraform plan` before `terraform apply`. Terraform will remove only that optional component and dependent configuration; review the plan before approving it.

## CI/CD

GitHub Actions runs formatting, Checkov, validation, and independent plans for Hub, DEV, TEST, and PROD on pull requests targeting `main`. CI does not run `terraform apply`.

The plan job requires these GitHub Actions secrets:

- `AZURE_PLAN_CLIENT_ID`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`
- `SSH_PUBLIC_KEY` for the optional DEV VM plan input

The service principal identified by `AZURE_PLAN_CLIENT_ID` needs `Reader` at the subscription scope and `Storage Blob Data Contributor` on the Terraform state storage account. These permissions allow state locking and read-only plans; they do not allow resource creation or updates.

Deployment workflows are separate from CI and use the approval-gated GitHub Environment `terraform-apply`:

- `Terraform Deploy Hub` deploys `environments/hub/`.
- `Terraform Deploy DEV` deploys `environments/dev/`.
- `Terraform Deploy TEST` deploys `environments/test/`.
- `Terraform Deploy PROD` deploys `environments/prod/`.

Each deployment workflow runs `terraform init`, creates a saved plan, and applies that exact plan. They use the existing apply secrets `AZURE_APPLY_CLIENT_ID`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID`, and `SSH_PUBLIC_KEY`. The apply identity needs `Contributor` at the subscription scope and `Storage Blob Data Contributor` on the Terraform state storage account.

## Validation

Before opening a pull request:

```powershell
terraform fmt -check -recursive
terraform -chdir=governance/policies init -backend=false -input=false
terraform -chdir=governance/policies validate
terraform -chdir=environments/hub init -backend=false -input=false
terraform -chdir=environments/hub validate
terraform -chdir=environments/dev init -backend=false -input=false
terraform -chdir=environments/dev validate
```

Run the equivalent validation for `test` and `prod`. Always review `terraform plan` output; do not run `terraform apply` until unexpected creates, changes, or destroys are understood.
