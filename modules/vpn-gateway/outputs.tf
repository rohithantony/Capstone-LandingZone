output "id" {
  description = "ID of the VPN Gateway."
  value       = azurerm_virtual_network_gateway.this.id
}

output "public_ip_address" {
  description = "Public IP address of the VPN Gateway."
  value       = azurerm_public_ip.this.ip_address
}