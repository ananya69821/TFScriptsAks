output "subnet_values" {
  value = zipmap(azurerm_subnet.subnet[*].name, azurerm_subnet.subnet[*].id)
}

output "subnet_values1" {
  value = {
    name = azurerm_subnet.subnet[*].name,
    id   = azurerm_subnet.subnet[*].id
  }
}

output "vnet_id" {
  description = "The ID of your VNET"
  value       = azurerm_virtual_network.virtual_network.id
}

output "vnet_name" {
  description = "The name of your VNET"
  value       = azurerm_virtual_network.virtual_network.name
}

output "vnet_location" {
  description = "The location of your VNET"
  value       = azurerm_virtual_network.virtual_network.location
}


output "vnet_address_space" {
  description = "The address space of your VNET"
  value       = azurerm_virtual_network.virtual_network.address_space
}

output "subnet_id" {
  description = "The ID of your subnet attched to a VNET"
  value       = azurerm_subnet.subnet[*].id
}

output "subnet_name" {
  description = "The ID of your subnet attched to a VNET"
  value       = azurerm_subnet.subnet[*].name
}
