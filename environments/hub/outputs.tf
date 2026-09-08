output "resource_group_name" {
  description = "Name of the Hub resource group."
  value       = module.resource_group.name
}

output "resource_group_id" {
  description = "ID of the Hub resource group."
  value       = module.resource_group.id
}

output "virtual_network_name" {
  description = "Name of the Hub virtual network."
  value       = module.virtual_network.name
}

output "virtual_network_id" {
  description = "ID of the Hub virtual network."
  value       = module.virtual_network.id
}

output "subnet_names" {
  description = "Names of the Hub subnets."
  value       = module.subnet.names
}

output "subnet_ids" {
  description = "IDs of the Hub subnets."
  value       = module.subnet.ids
}

output "firewall_private_ip" {
  description = "Private IP address of the Hub Azure Firewall."
  value       = module.firewall.private_ip_address
}

output "firewall_public_ip" {
  description = "Public IP address of the Hub Azure Firewall."
  value       = module.firewall.public_ip_address
}

output "bastion_public_ip" {
  description = "Public IP address of Azure Bastion."
  value       = module.bastion.public_ip_address
}

output "dns_resolver_inbound_ip" {
  description = "Inbound endpoint IP of the Hub DNS Private Resolver."
  value       = module.dns_private_resolver.inbound_endpoint_ip
}

output "log_analytics_workspace_id" {
  description = "ID of the Hub Log Analytics workspace."
  value       = module.log_analytics.id
}