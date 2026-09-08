output "id" {
  description = "ID of the DNS Private Resolver."
  value       = azurerm_private_dns_resolver.this.id
}

output "inbound_endpoint_ip" {
  description = "Private IP address of the inbound DNS endpoint."
  value       = azurerm_private_dns_resolver_inbound_endpoint.this.ip_configurations[0].private_ip_address
}