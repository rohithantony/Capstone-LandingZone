variable "name" {
  description = "Name of the DNS Private Resolver."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the DNS Private Resolver."
  type        = string
}

variable "location" {
  description = "Azure region for the DNS Private Resolver."
  type        = string
}

variable "virtual_network_id" {
  description = "Hub virtual network ID."
  type        = string
}

variable "subnet_id" {
  description = "Subnet dedicated to the DNS Private Resolver."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the resource."
  type        = map(string)
  default     = {}
}