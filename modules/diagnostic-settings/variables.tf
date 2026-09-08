variable "name" {
  description = "Name of the diagnostic setting."
  type        = string
}

variable "target_resource_id" {
  description = "Resource ID of the resource to monitor."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID."
  type        = string
}

variable "enabled_logs" {
  description = "Diagnostic log categories to enable."
  type        = list(string)
  default     = []
}

variable "enabled_metrics" {
  description = "Diagnostic metric categories to enable."
  type        = list(string)
  default     = []
}