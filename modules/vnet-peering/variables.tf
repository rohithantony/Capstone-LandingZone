variable "this_resource_group_name" {
  description = "Resource group containing the first virtual network."
  type        = string
}

variable "this_virtual_network_name" {
  description = "Name of the first virtual network."
  type        = string
}

variable "this_virtual_network_id" {
  description = "ID of the first virtual network."
  type        = string
}

variable "peer_resource_group_name" {
  description = "Resource group containing the peer virtual network."
  type        = string
}

variable "peer_virtual_network_name" {
  description = "Name of the peer virtual network."
  type        = string
}

variable "peer_virtual_network_id" {
  description = "ID of the peer virtual network."
  type        = string
}

variable "this_to_peer_name" {
  description = "Name of the peering from the first VNet to the peer."
  type        = string
}

variable "peer_to_this_name" {
  description = "Name of the peering from the peer VNet to the first VNet."
  type        = string
}