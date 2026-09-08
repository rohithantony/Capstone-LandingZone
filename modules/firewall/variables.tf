variable "name" {
  description = "Name of the Azure Firewall."
  type        = string
}

variable "location" {
  description = "Azure region for the Azure Firewall."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the Azure Firewall."
  type        = string
}

variable "subnet_id" {
  description = "ID of the AzureFirewallSubnet."
  type        = string
}

variable "sku_tier" {
  description = "Azure Firewall SKU tier."
  type        = string
  default     = "Standard"
}

variable "tags" {
  description = "Tags to apply to the resource."
  type        = map(string)
  default     = {}
}