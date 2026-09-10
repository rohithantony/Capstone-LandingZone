variable "resource_group_name" {
  description = "Name of the PROD resource group."
  type        = string
}

variable "location" {
  description = "Azure region for the PROD environment."
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the PROD virtual network."
  type        = string
}

variable "virtual_network_address_space" {
  description = "Address space of the PROD virtual network."
  type        = list(string)
}

variable "subnets" {
  description = "Subnets for the PROD virtual network."
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "nsg_name" {
  description = "Name of the PROD network security group."
  type        = string
}

variable "security_rules" {
  description = "Security rules for the PROD NSG."

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
  description = "Name of the PROD route table."
  type        = string
}

variable "firewall_private_ip" {
  description = "Private IP address of the Hub Azure Firewall."
  type        = string
}

variable "enable_firewall_route" {
  description = "Whether to route spoke default traffic through the Hub Azure Firewall."
  type        = bool
  default     = false
}

variable "key_vault_name" {
  description = "Globally unique name of the environment Key Vault."
  type        = string
}

variable "tags" {
  description = "Common tags for the environment."
  type        = map(string)
}