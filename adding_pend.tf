
# resource "azurerm_private_dns_zone" "dns01" {
#   name                = "privatelink.azurecr.io"
#   resource_group_name = azurerm_resource_group.this.name
# }

# resource "azurerm_private_dns_zone_virtual_network_link" "dns_link_vnet" {
#   name                  = "dns-link01"
#   resource_group_name   = azurerm_resource_group.this.name
#   private_dns_zone_name = azurerm_private_dns_zone.dns01.name
#   virtual_network_id    = module.vnet.vnet_id
# }

# module "pend_acr" {
#   source = "./modules/terraform-azure-pend"
#   subnet_app_info = {
#       "subnet_name"       =  "acr-subnet",
#       "subnet_id"         = module.vnet.subnet_values["acr-subnet"],
#       "app_name"          = azurerm_container_registry.acr.name,
#       "app_id"            = azurerm_container_registry.acr.id,
#       "rg_location"       = azurerm_resource_group.this.location,
#       "rg_name"           = azurerm_resource_group.this.name,
#       "subresource_names" = ["registry"]
      
#     }
# }

# resource "azurerm_private_dns_a_record" "acr_pend_record" {
#   name                = lookup(module.pcs_int_pend.private_endpoint_info,"fqdn")
#   zone_name           = "privatelink.azurewebsites.aspnet"
#   resource_group_name = data.terraform_remote_state.rbac.outputs.rg_dns_zone_app_name
#   ttl                 = 300
#   records             = [lookup(module.pcs_int_pend.private_endpoint_info,"ipaddrs")]
# }