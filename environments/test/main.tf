terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.4"
    }
  }
}

provider "azurerm" {
  features {}
}

module "resource_group" {
  source = "../../modules/resource-group"

  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "virtual_network" {
  source = "../../modules/virtual-network"

  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = module.resource_group.name
  address_space       = var.virtual_network_address_space
  tags                = var.tags
}

module "subnet" {
  source = "../../modules/subnet"

  resource_group_name  = module.resource_group.name
  virtual_network_name = module.virtual_network.name
  subnets              = var.subnets
}

module "nsg" {
  source = "../../modules/nsg"

  name                = var.nsg_name
  location            = var.location
  resource_group_name = module.resource_group.name
  security_rules      = var.security_rules
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "application" {
  subnet_id                 = module.subnet.ids["application"]
  network_security_group_id = module.nsg.id
}

module "route_table" {
  source = "../../modules/route-table"

  name                = var.route_table_name
  location            = var.location
  resource_group_name = module.resource_group.name
  tags                = var.tags

  routes = {
    default_to_firewall = {
      name                   = "route-default-to-firewall"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = var.firewall_private_ip
    }
  }

  subnet_ids = module.subnet.ids
}

data "azurerm_virtual_network" "hub" {
  name                = "vnet-hub"
  resource_group_name = "rg-hub"
}

module "hub_peering" {
  source = "../../modules/vnet-peering"

  this_resource_group_name  = module.resource_group.name
  this_virtual_network_name = module.virtual_network.name
  this_virtual_network_id   = module.virtual_network.id

  peer_resource_group_name  = data.azurerm_virtual_network.hub.resource_group_name
  peer_virtual_network_name = data.azurerm_virtual_network.hub.name
  peer_virtual_network_id   = data.azurerm_virtual_network.hub.id

  this_to_peer_name = "peer-test-to-hub"
  peer_to_this_name = "peer-hub-to-test"
}

data "azurerm_client_config" "current" {}

module "key_vault" {
  source = "../../modules/key-vault"

  name                = var.key_vault_name
  location            = var.location
  resource_group_name = module.resource_group.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags                = var.tags
}

module "key_vault_private_endpoint" {
  source = "../../modules/private-endpoint"

  name                           = "pe-kv-test"
  location                       = var.location
  resource_group_name            = module.resource_group.name
  subnet_id                      = module.subnet.ids["application"]
  private_connection_resource_id = module.key_vault.id
  subresource_names              = ["vault"]
  tags                           = var.tags
}

#Link the Key Vault private endpoint to the private DNS zone in the Hub environment
data "azurerm_private_dns_zone" "key_vault" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = "rg-hub"
}

resource "azurerm_private_dns_zone_virtual_network_link" "key_vault" {
  name                  = "link-test-keyvault"
  resource_group_name   = data.azurerm_private_dns_zone.key_vault.resource_group_name
  private_dns_zone_name = data.azurerm_private_dns_zone.key_vault.name
  virtual_network_id    = module.virtual_network.id
}

## Diagnostic settings for Key Vault
data "terraform_remote_state" "hub" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "sttfstatecapstone01"
    container_name       = "tfstate"
    key                  = "hub.tfstate"
  }
}

module "key_vault_diagnostics" {
  source = "../../modules/diagnostic-settings"

  name                       = "diag-kv-test"
  target_resource_id         = module.key_vault.id
  log_analytics_workspace_id = data.terraform_remote_state.hub.outputs.log_analytics_workspace_id

  enabled_logs = [
    "AuditEvent"
  ]

  enabled_metrics = [
    "AllMetrics"
  ]
}
