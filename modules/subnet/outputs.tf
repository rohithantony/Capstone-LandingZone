output "ids" {
  description = "IDs of the created subnets."
  value = {
    for key, subnet in azurerm_subnet.this : key => subnet.id
  }
}

output "names" {
  description = "Names of the created subnets."
  value = {
    for key, subnet in azurerm_subnet.this : key => subnet.name
  }
}