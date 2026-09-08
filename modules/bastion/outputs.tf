output "id" {
  description = "ID of the Azure Bastion host."
  value       = azurerm_bastion_host.this.id
}

output "public_ip_address" {
  description = "Public IP address of Azure Bastion."
  value       = azurerm_public_ip.this.ip_address
}