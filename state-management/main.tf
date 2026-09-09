terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "state" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

#checkov:skip=CKV_AZURE_59:The existing Terraform backend uses the public Azure Blob endpoint; disabling public access requires a private endpoint and reachable private DNS for every runner.
#checkov:skip=CKV_AZURE_206:Changing replication changes the existing state account's resilience and cost profile and is outside this hardening change.
#checkov:skip=CKV2_AZURE_33:The state backend has no private endpoint; adding one requires private DNS and runner network changes.
#checkov:skip=CKV2_AZURE_40:Disabling shared-key authorization requires migrating all backend clients to Azure AD authentication.
#checkov:skip=CKV2_AZURE_1:Customer-managed encryption requires a Key Vault, identity, and key lifecycle that are not part of the existing state-management design.
resource "azurerm_storage_account" "state" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.state.name
  location                 = azurerm_resource_group.state.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  https_traffic_only_enabled = true
  min_tls_version            = "TLS1_2"

  allow_nested_items_to_be_public = false

  shared_access_key_enabled = true

  blob_properties {
    delete_retention_policy {
      days = 7
    }

    container_delete_retention_policy {
      days = 7
    }

    versioning_enabled  = true
    change_feed_enabled = true
  }

  queue_properties {
    logging {
      delete                = true
      read                  = true
      version               = "1.0"
      write                 = true
      retention_policy_days = 7
    }
  }

  sas_policy {
    expiration_period = "07.00:00:00"
    expiration_action = "Log"
  }

  tags = var.tags
}

#checkov:skip=CKV2_AZURE_21:Blob service logging requires a separate storage logging configuration and is deferred to avoid changing the existing state account contract.
resource "azurerm_storage_container" "tfstate" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.state.id
  container_access_type = "private"
}