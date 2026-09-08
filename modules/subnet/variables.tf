variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the virtual network."
  type        = string
}

variable "subnets" {
  description = "Map of subnets to create."

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