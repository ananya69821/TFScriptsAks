terraform {
  backend "local" {
    # Configuration options for the local backend
    path = "./terraform.state"
  }
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "=3.0.0"
      
    }
  }
}

provider "azurerm" {
  features {}
 # skip_provider_registration = true
  subscription_id = "086a01dc-a5e3-447b-b63a-e33083042401"
  client_id       = "a2844c0e-f791-4865-8e19-ce2f6c67c26f"
  client_secret   = "Yqj8Q~PijP8Y0HgRcblqkOYGfHVYoiUlmsgYcaHA"
  tenant_id       = "ca216e2c-342c-462c-9490-8b5b15fa4cfc"
}

resource "azurerm_resource_group" "this" {
  name     = "RG-01"
  location = "East US"

}

module "vnet" {
  source  = "./modules/terraform-azure-vnet"
  virtual_network_info = {
    "name"  = "vnet1",
    "addrs" = "10.0.0.0/16",
  }
  subnet_names = [
    {
      "name"  = "appgw-subnet",
      "addrs" = "10.0.1.0/24",
            "nsg_rules" = [
        {
          "name"  = "allow-inbound-65200-65535",
          "priority" = 100,
          "direction"                   = "Inbound",
          "access"                      = "Allow",
          "protocol"                    = "*",
          "source_port_range"           = "*",
          "destination_port_range"      = "65200-65535",
          "source_address_prefix"       = "*",
          "destination_address_prefix"  = "*"
        }

      ]

    },
    {
      "name"  = "devops-subnet",
      "addrs" = "10.0.2.0/24",
      "nsg_rules" = [
        {
          "name"  = "allow-win",
          "priority" = 100,
          "direction"                   = "Inbound",
          "access"                      = "Allow",
          "protocol"                    = "Tcp",
          "source_port_range"           = "*",
          "destination_port_range"      = "3389",
          "source_address_prefix"       = "*",
          "destination_address_prefix"  = "*"
        },
        {
          "name"  = "allow-ssh",
          "priority" = 103,
          "direction"                   = "Inbound",
          "access"                      = "Allow",
          "protocol"                    = "Tcp",
          "source_port_range"           = "*",
          "destination_port_range"      = "22",
          "source_address_prefix"       = "*",
          "destination_address_prefix"  = "*"
        },
        {
          "name"                        = "allow-https",
          "priority"                    = 101,
          "direction"                   = "Outbound",
          "access"                      = "Allow",
          "protocol"                    = "Tcp",
          "source_port_range"           = "*",
          "destination_port_range"      = "443",
          "source_address_prefix"       = "*",
          "destination_address_prefix"  = "*"
        },
        {
          "name"                        = "allow-http",
          "priority"                    = 102,
          "direction"                   = "Outbound",
          "access"                      = "Allow",
          "protocol"                    = "Tcp",
          "source_port_range"           = "*",
          "destination_port_range"      = "80",
          "source_address_prefix"       = "*",
          "destination_address_prefix"  = "*"
        }

      ]
    },
    {
      "name"  = "aks-subnet",
      "addrs" = "10.0.4.0/22",

    }
  ]
  rg_name     = azurerm_resource_group.this.name
  rg_location = "eastus"
}

resource "azurerm_container_registry" "acr" {
  name                = "myaksacr01"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Premium"
  admin_enabled       = true
}

############# AKS Agent Configuration #######################################
# resource "azurerm_public_ip" "mypublicip" {
#   name                = "my-public-ip"
#   location            = azurerm_resource_group.this.location
#   resource_group_name = azurerm_resource_group.this.name
#   allocation_method   = "Static"
# }

# resource "azurerm_network_interface" "nice01" {
#   name                = "nic-agentvm"
#   location            = azurerm_resource_group.this.location
#   resource_group_name = azurerm_resource_group.this.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = module.vnet.subnet_values["devops-subnet"]
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.mypublicip.id
#   }
# }

# resource "azurerm_linux_virtual_machine" "agentvm" {
#   name                = "agentvm"
#   resource_group_name = azurerm_resource_group.this.name
#   location            = azurerm_resource_group.this.location
#   size                = "Standard_F2"
#   admin_username      = "adminuser"
#   admin_password = "123Ananya@"
#   network_interface_ids = [
#     azurerm_network_interface.nice01.id,
#   ]
#   disable_password_authentication = false

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-focal"
#     sku       = "20_04-lts"
#     version   = "latest"
#   }
# }
