output "vnet" {
  description = "The entire azurerm_virtual_network resource"
  value       = azurerm_virtual_network.this
}
output "vnet_id" {
  description = "The id of the newly created vNet"
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "The Name of the newly created vNet"
  value       = azurerm_virtual_network.this.name
}

output "vnet_location" {
  description = "The location of the newly created vNet"
  value       = azurerm_virtual_network.this.location
}

output "vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = azurerm_virtual_network.this.address_space
}

output "subnets" {
  description = "The subnets created by this module"
  value       = azurerm_subnet.this
}

output "network_security_groups" {
  description = "The network security groups objects created by this module"
  value       = azurerm_network_security_group.this
}
