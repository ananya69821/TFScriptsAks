resource "azurerm_route_table" "route_table" {
  count               = length(var.subnet_names)
  name                = "${var.subnet_names[count.index].name}-rt"
  location            = var.rg_location
  resource_group_name = var.rg_name

  dynamic "route" {
    for_each = toset(var.subnet_names[count.index].routes)

    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = route.value.next_hop_in_ip_address != "" ? route.value.next_hop_in_ip_address : null
    }
  }
}
resource "azurerm_subnet_route_table_association" "routeTable" {
  count          = length(var.subnet_names)
  subnet_id      = azurerm_subnet.subnet[count.index].id
  route_table_id = azurerm_route_table.route_table[count.index].id
  depends_on = [
    azurerm_route_table.route_table,
    azurerm_subnet.subnet
  ]
}