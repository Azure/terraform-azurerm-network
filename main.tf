#Azure Generic vNet Module
data "azurerm_resource_group" "network" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.network.name
  location            = data.azurerm_resource_group.network.location
  address_space       = length(var.address_spaces) == 0 ? [var.address_space] : var.address_spaces
  dns_servers         = var.dns_servers
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  for_each                                       = var.subnets_list
  name                                           = each.value.name
  resource_group_name                            = data.azurerm_resource_group.network.name
  address_prefixes                               = each.value.address_prefixes
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  enforce_private_link_endpoint_network_policies = lookup(each.value, "enforce_private_link", false)
  service_endpoints                              = lookup(each.value, "subnet_service_endpoints", [])
}
