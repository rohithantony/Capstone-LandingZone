output "resource_group_name" {
  description = "Name of the TEST resource group."
  value       = module.resource_group.name
}

output "resource_group_id" {
  description = "ID of the TEST resource group."
  value       = module.resource_group.id
}

output "virtual_network_name" {
  description = "Name of the TEST virtual network."
  value       = module.virtual_network.name
}

output "virtual_network_id" {
  description = "ID of the TEST virtual network."
  value       = module.virtual_network.id
}

output "subnet_names" {
  description = "Names of the TEST subnets."
  value       = module.subnet.names
}

output "subnet_ids" {
  description = "IDs of the TEST subnets."
  value       = module.subnet.ids
}