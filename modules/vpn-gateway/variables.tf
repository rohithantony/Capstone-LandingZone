variable "name" {
  description = "Name of the VPN Gateway."
  type        = string
}

variable "location" {
  description = "Azure region for the VPN Gateway."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the VPN Gateway."
  type        = string
}

variable "gateway_subnet_id" {
  description = "ID of the GatewaySubnet."
  type        = string
}

variable "sku" {
  description = "VPN Gateway SKU."
  type        = string
  default     = "VpnGw1"
}