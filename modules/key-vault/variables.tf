variable "name" {
  description = "Globally unique name of the Key Vault."
  type        = string
}

variable "location" {
  description = "Azure region for the Key Vault."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the Key Vault."
  type        = string
}

variable "tenant_id" {
  description = "Microsoft Entra tenant ID."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the resource."
  type        = map(string)
  default     = {}
}