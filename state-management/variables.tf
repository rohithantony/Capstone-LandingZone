variable "resource_group_name" {
  description = "Name of the resource group used for Terraform state."
  type        = string
  default     = "rg-tfstate"
}

variable "storage_account_name" {
  description = "Globally unique Azure Storage Account name for Terraform state."
  type        = string
  default     = "sttfstatecapstone01"
}

variable "container_name" {
  description = "Blob container used to store Terraform state."
  type        = string
  default     = "tfstate"
}

variable "location" {
  description = "Azure region for Terraform state resources."
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "Tags for state management resources."
  type        = map(string)
  default     = {}
}