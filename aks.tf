data "azurerm_kubernetes_service_versions" "current" {
  location = azurerm_resource_group.this.location
  include_preview = false
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "${azurerm_resource_group.this.name}-cluster"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = "${azurerm_resource_group.this.name}-cluster"
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "${azurerm_resource_group.this.name}-nrg"

  default_node_pool {
    name                 = "systempool"
    vm_size              = "Standard_D2_v2"
     node_count = 1
   # orchestrator_version = data.azurerm_kubernetes_service_versions.current.latest_version
 #  availability_zones   = [1, 2, 3]
    # enable_auto_scaling  = true
    # max_count            = 3
    # min_count            = 1
    # type                 = "VirtualMachineScaleSets"
    # node_labels = {
    #   "nodepool-type"    = "system"
    #   "environment"      = "dev"
    #   "nodepoolos"       = "linux"
    #   "app"              = "system-apps" 
    # } 

  }

  identity {
    type = "SystemAssigned"
  }
  #  ingress_application_gateway {
  #   gateway_name = "newappgateway"
  # }

  tags = {
    Environment = "dev"
  }
  
  # network_profile {
  #   network_plugin = "azure"
  #   load_balancer_sku = "standard"
  # }

  # network_profile {
  #   network_plugin     = "azure"
  #   dns_service_ip     = var.aks_dns_service_ip
  #   docker_bridge_cidr = var.aks_docker_bridge_cidr
  #   service_cidr       = var.aks_service_cidr
  # }
# Windows Profile
  # windows_profile {
  #   admin_username = var.windows_admin_username
  #   admin_password = var.windows_admin_password
  # }

# Linux Profile
  # linux_profile {
  #   admin_username = "ubuntu"
  #   ssh_key {
  #     key_data = file(var.ssh_public_key)
  #   }
  # }

 
}