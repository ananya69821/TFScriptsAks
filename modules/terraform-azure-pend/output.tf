output "private_endpoint_info" {
  value = {
    "fqdn" = azurerm_private_endpoint.private_endpoint.custom_dns_configs[0].fqdn,
    "ipaddrs" = azurerm_private_endpoint.private_endpoint.custom_dns_configs[0].ip_addresses[0]
  }
}

output "private_endpoint_name" {
  value = azurerm_private_endpoint.private_endpoint.name
}

output "private_endpoint_id" {
  value = azurerm_private_endpoint.private_endpoint.id
}