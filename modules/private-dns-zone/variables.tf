variable "name" {
  description = "Name of the private DNS zone."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the private DNS zone."
  type        = string
}

variable "virtual_network_ids" {
  description = "Virtual networks to link to the private DNS zone."
  type        = map(string)
}

variable "tags" {
  description = "Tags to apply to the resource."
  type        = map(string)
  default     = {}
}