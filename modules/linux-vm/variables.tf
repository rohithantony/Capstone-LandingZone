variable "name" {
  description = "Name of the Linux virtual machine."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the VM."
  type        = string
}

variable "subnet_id" {
  description = "Subnet where the VM NIC will be attached."
  type        = string
}

variable "size" {
  description = "VM size."
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "Administrator username."
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for VM authentication."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the VM and NIC."
  type        = map(string)
  default     = {}
}
