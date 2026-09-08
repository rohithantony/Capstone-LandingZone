variable "name" {
  description = "Name of the network security group."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the NSG."
  type        = string
}

variable "security_rules" {
  description = "Security rules for the NSG."

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

variable "tags" {
  description = "Tags to apply to the NSG."
  type        = map(string)
  default     = {}
}