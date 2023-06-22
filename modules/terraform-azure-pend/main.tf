resource "azurerm_private_endpoint" "private_endpoint" {
   # for_each = azurerm_subnet.subnet
    #count = length(var.subnet_app_info)
  name                = "${var.subnet_app_info.app_name}-pend"
  location            = var.subnet_app_info.rg_location
  resource_group_name = var.subnet_app_info.rg_name
  subnet_id           = var.subnet_app_info.subnet_id

  private_service_connection {
    name                           = "${var.subnet_app_info.app_name}-pend-sc01"
    is_manual_connection           = false
    private_connection_resource_id =  var.subnet_app_info.app_id
    subresource_names              = var.subnet_app_info.subresource_names
    
  }

}


