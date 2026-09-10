variable "resource_group_name" {
  description = "Name of the Hub resource group."
  type        = string
}

variable "location" {
  description = "Azure region for the Hub."
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the Hub virtual network."
  type        = string
}

variable "virtual_network_address_space" {
  description = "Address space of the Hub virtual network."
  type        = list(string)
}

variable "subnets" {
  description = "Subnets for the Hub virtual network."
  type = map(object({
    name             = string
    address_prefixes = list(string)
    delegation = optional(object({
      name                    = string
      service_delegation_name = string
      actions                 = list(string)
    }))
  }))
}

variable "tags" {
  description = "Common tags for the environment."
  type        = map(string)
}

variable "enable_firewall" {
  description = "Whether to deploy Azure Firewall and its diagnostics."
  type        = bool
  default     = false
}

variable "enable_bastion" {
  description = "Whether to deploy Azure Bastion and its diagnostics."
  type        = bool
  default     = false
}