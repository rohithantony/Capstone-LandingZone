
variable "subscription_id" {
  description = "Azure subscription ID where policies are assigned."
  type        = string
}

variable "allowed_locations" {
  description = "Azure regions allowed by policy."
  type        = list(string)

  default = [
    "eastus",
    "global"
  ]
}

