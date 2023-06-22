
resource "azurerm_network_security_group" "network_security_group" {
  count               = length(var.subnet_names)
  name                = "${var.subnet_names[count.index].name}-nsg"
  location            = var.rg_location
  resource_group_name = var.rg_name


  dynamic "security_rule" {
    for_each = toset(var.subnet_names[count.index].nsg_rules)

    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
  # security_rule {
  #   name                       = "AllowHttps"
  #   priority                   = 100
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_range     = "443"
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }

  # security_rule {
  #   name                       = "allowhttp"
  #   priority                   = 101
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_range     = "80"
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }
  depends_on = [
    azurerm_subnet.subnet
  ]
}


resource "azurerm_subnet_network_security_group_association" "nsg-association" {
  count                     = length(var.subnet_names)
  subnet_id                 = azurerm_subnet.subnet[count.index].id
  network_security_group_id = azurerm_network_security_group.network_security_group[count.index].id
  depends_on = [
    azurerm_network_security_group.network_security_group
  ]
}
