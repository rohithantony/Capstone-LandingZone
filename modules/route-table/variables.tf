variable "name" {
  description = "Name of the route table."
  type        = string
}

variable "location" {
  description = "Azure region for the route table."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the route table."
  type        = string
}

variable "routes" {
  description = "Routes to create in the route table."
  type = map(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = {}
}

variable "subnet_ids" {
  description = "Subnet IDs to associate with the route table."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to the resource."
  type        = map(string)
  default     = {}
}