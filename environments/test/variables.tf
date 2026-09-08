variable "resource_group_name" {
  description = "Name of the TEST resource group."
  type        = string
}

variable "location" {
  description = "Azure region for the TEST environment."
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the TEST virtual network."
  type        = string
}

variable "virtual_network_address_space" {
  description = "Address space of the TEST virtual network."
  type        = list(string)
}

variable "subnets" {
  description = "Subnets for the TEST virtual network."
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "nsg_name" {
  description = "Name of the TEST network security group."
  type        = string
}

variable "security_rules" {
  description = "Security rules for the TEST NSG."

  type = map(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    description                = optional(string)
  }))

  default = {}
}

variable "route_table_name" {
  description = "Name of the TEST route table."
  type        = string
}

variable "firewall_private_ip" {
  description = "Private IP address of the Hub Azure Firewall."
  type        = string
}

variable "key_vault_name" {
  description = "Globally unique name of the environment Key Vault."
  type        = string
}

variable "tags" {
  description = "Common tags for the environment."
  type        = map(string)
}

