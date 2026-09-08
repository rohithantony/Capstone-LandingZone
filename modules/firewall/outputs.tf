output "id" {
  description = "ID of the Azure Firewall."
  value       = azurerm_firewall.this.id
}

output "private_ip_address" {
  description = "Private IP address of the Azure Firewall."
  value       = azurerm_firewall.this.ip_configuration[0].private_ip_address
}

output "public_ip_address" {
  description = "Public IP address of the Azure Firewall."
  value       = azurerm_public_ip.this.ip_address
}