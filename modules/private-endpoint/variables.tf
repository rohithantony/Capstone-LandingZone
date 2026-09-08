variable "name" {
  description = "Name of the private endpoint."
  type        = string
}

variable "location" {
  description = "Azure region for the private endpoint."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the private endpoint."
  type        = string
}

variable "subnet_id" {
  description = "Subnet where the private endpoint will be deployed."
  type        = string
}

variable "private_connection_resource_id" {
  description = "Resource ID of the Azure service accessed through the private endpoint."
  type        = string
}

variable "subresource_names" {
  description = "Subresource names exposed by the target Azure service."
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to the resource."
  type        = map(string)
  default     = {}
}