variable "name" {
  description = "Name of the Log Analytics workspace."
  type        = string
}

variable "location" {
  description = "Azure region for the workspace."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the workspace."
  type        = string
}

variable "retention_in_days" {
  description = "Number of days to retain logs."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags to apply to the resource."
  type        = map(string)
  default     = {}
}