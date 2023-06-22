resource "azurerm_subnet" "subnet" {
  count = length(var.subnet_names)

  name                                           = var.subnet_names[count.index].name
  resource_group_name                            = var.rg_name
  virtual_network_name                           = azurerm_virtual_network.virtual_network.name
  address_prefixes                               = [var.subnet_names[count.index].addrs]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true

  # dynamic "delegation" {
  #   for_each = toset(var.subnet_names[count.index].subnet_delegation)

  #   content {
  #     name = delegation.value.name

  #     service_delegation {
  #       name    = delegation.value.service_delegation.name
  #       actions = delegation.value.service_delegation.actions
  #     }
  #   }
  # }
  depends_on = [
    azurerm_virtual_network.virtual_network
  ]
}


