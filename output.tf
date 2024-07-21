output "name" {
  value       = azurerm_virtual_network_gateway.this.name
  description = "The name of the vpn gateway."
}

output "id" {
  value       = azurerm_virtual_network_gateway.this.id
  description = "The id of the vpn gateway."
}

output "location" {
  value       = azurerm_virtual_network_gateway.this.location
  description = "The location of the vpn gateway."
}

output "resource_group_name" {
  value       = azurerm_virtual_network_gateway.this.resource_group_name
  description = "The name of the resource group of the vpn gateway."
}
