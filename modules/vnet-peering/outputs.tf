output "this_to_peer_id" {
  description = "ID of the peering from the first VNet to the peer."
  value       = azurerm_virtual_network_peering.this_to_peer.id
}

output "peer_to_this_id" {
  description = "ID of the peering from the peer VNet to the first VNet."
  value       = azurerm_virtual_network_peering.peer_to_this.id
}