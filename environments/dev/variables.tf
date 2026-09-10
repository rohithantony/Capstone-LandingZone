variable "resource_group_name" {
  description = "Name of the DEV resource group."
  type        = string
}

variable "location" {
  description = "Azure region for the DEV environment."
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the DEV virtual network."
  type        = string
}

variable "virtual_network_address_space" {
  description = "Address space of the DEV virtual network."
  type        = list(string)
}

variable "subnets" {
  description = "Subnets for the DEV virtual network."
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "nsg_name" {
  description = "Name of the DEV network security group."
  type        = string
}

variable "security_rules" {
  description = "Security rules for the DEV application subnet."
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
  description = "Name of the DEV route table."
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

variable "vm_name" {
  description = "Name of the DEV Linux VM."
  type        = string
}

variable "enable_linux_vm" {
  description = "Whether to deploy the DEV Linux VM."
  type        = bool
  default     = false
}

variable "vm_size" {
  description = "Size of the DEV Linux VM."
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "Administrator username for the DEV VM."
  type        = string
  default     = "azureadmin"
}

variable "ssh_public_key" {
  description = "SSH public key for the DEV VM."
  type        = string
  default     = ""
}