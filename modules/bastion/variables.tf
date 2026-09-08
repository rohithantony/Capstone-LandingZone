variable "name" {
  description = "Name of the Azure Bastion host."
  type        = string
}

variable "location" {
  description = "Azure region for Azure Bastion."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing Azure Bastion."
  type        = string
}

variable "subnet_id" {
  description = "ID of the AzureBastionSubnet."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the resource."
  type        = map(string)
  default     = {}
}