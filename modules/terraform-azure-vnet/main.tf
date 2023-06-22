terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

resource "azurerm_virtual_network" "virtual_network" {
  name                = var.virtual_network_info.name
  location            = var.rg_location
  resource_group_name = var.rg_name
  address_space       = [var.virtual_network_info.addrs]
  dns_servers         = var.virtual_network_info.dns_servers
  depends_on = [
    var.rg_name
  ]
}


