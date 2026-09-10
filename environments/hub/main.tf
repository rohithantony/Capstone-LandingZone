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

module "firewall" {
  count  = var.enable_firewall ? 1 : 0
  source = "../../modules/firewall"

  name                = "fw-hub"
  location            = var.location
  resource_group_name = module.resource_group.name
  subnet_id           = module.subnet.ids["firewall"]
  tags                = var.tags
}

module "bastion" {
  count  = var.enable_bastion ? 1 : 0
  source = "../../modules/bastion"

  name                = "bas-hub"
  location            = var.location
  resource_group_name = module.resource_group.name
  subnet_id           = module.subnet.ids["bastion"]
  tags                = var.tags
}


#Centralized Key Vault Private DNS Zone
module "key_vault_private_dns" {
  source = "../../modules/private-dns-zone"

  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = module.resource_group.name
  tags                = var.tags

  virtual_network_ids = {
    hub = module.virtual_network.id
  }
}

module "dns_private_resolver" {
  source = "../../modules/dns-private-resolver"

  name                = "dnspr-hub"
  resource_group_name = module.resource_group.name
  location            = var.location
  virtual_network_id  = module.virtual_network.id
  subnet_id           = module.subnet.ids["dns_resolver"]
  tags                = var.tags
}

module "log_analytics" {
  source = "../../modules/log-analytics"

  name                = "law-hub"
  location            = var.location
  resource_group_name = module.resource_group.name
  retention_in_days   = 30
  tags                = var.tags
}


#Diagnostic Settings for Azure Firewall
module "firewall_diagnostics" {
  count  = var.enable_firewall ? 1 : 0
  source = "../../modules/diagnostic-settings"

  name                       = "diag-firewall"
  target_resource_id         = module.firewall[0].id
  log_analytics_workspace_id = module.log_analytics.id

  enabled_logs = [
    "AZFWApplicationRule",
    "AZFWNetworkRule",
    "AZFWNatRule",
    "AZFWThreatIntel"
  ]

  enabled_metrics = [
    "AllMetrics"
  ]
}

#Diagnostic Settings for Azure Bastion
module "bastion_diagnostics" {
  count  = var.enable_bastion ? 1 : 0
  source = "../../modules/diagnostic-settings"

  name                       = "diag-bastion"
  target_resource_id         = module.bastion[0].id
  log_analytics_workspace_id = module.log_analytics.id

  enabled_logs = [
    "BastionAuditLogs"
  ]

  enabled_metrics = [
    "AllMetrics"
  ]
}

