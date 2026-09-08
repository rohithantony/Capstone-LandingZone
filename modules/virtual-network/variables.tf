variable "name" {
  description = "Name of the virtual network."
  type        = string
}

variable "location" {
  description = "Azure region for the virtual network."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the virtual network."
  type        = string
}

variable "address_space" {
  description = "Address space of the virtual network."
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to the resource."
  type        = map(string)
  default     = {}
}