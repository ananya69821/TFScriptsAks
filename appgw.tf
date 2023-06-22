locals {
  frontend_port_name             = "${var.app_gateway_name}-${local.location}-feport"
  frontend_ip_configuration_name = "appgw-${var.app_gateway_name}-${local.location}-feip"
  gateway_ip_configuration_name  = "${var.app_gateway_name}-${local.location}-gatip"
  backend_address_pool_name      = "${var.app_gateway_name}-${local.location}bp"
   http_setting_name              = "${var.app_gateway_name}-${local.location}-http"
   request_routing_rule_name      = "${var.app_gateway_name}-${local.location}-rule"

  listener_name                  = "${var.app_gateway_name}-${local.location}-listner"

  resource_group_name = azurerm_resource_group.this.name
  location            = "eastus"
}

resource "azurerm_public_ip" "test" {
  name                = "appgateway1-eastus-gw-pip"
  location            = local.location
  resource_group_name = local.resource_group_name
  allocation_method   =  "Static"
  sku                 = "Standard" 
}

resource "azurerm_application_gateway" "network" {
  name                = "${var.app_gateway_name}"
  resource_group_name = "${azurerm_resource_group.this.name}"
  location            = "${azurerm_resource_group.this.location}"

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = "${module.vnet.subnet_values["appgw-subnet"]}"
  }

  frontend_port {
    name = "${local.frontend_port_name}"
    port = 80
  }

  frontend_port {
    name = "https_port"
    port = 443
  }

  frontend_ip_configuration {
    name                 = "${local.frontend_ip_configuration_name}"
    public_ip_address_id = "${azurerm_public_ip.test.id}"
  }

  backend_address_pool {
    name = "${local.backend_address_pool_name}"
  }

  backend_http_settings {
    name                  = "${local.http_setting_name}"
    cookie_based_affinity = "Disabled"
    path         = ""
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }
  http_listener {
    name                           = "${local.listener_name}"
    frontend_ip_configuration_name = "${local.frontend_ip_configuration_name}"
    frontend_port_name             = "${local.frontend_port_name}"
    protocol                       = "Http"
  }
request_routing_rule {
    name                        = "${local.request_routing_rule_name}"
    rule_type                   = "Basic"
    http_listener_name          = "${local.listener_name}"
    backend_address_pool_name   = "${local.backend_address_pool_name}"
    backend_http_settings_name  = "${local.http_setting_name}"
  }
}

