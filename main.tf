#Azure Generic vNet Module
data "azurerm_resource_group" "network" {
  count = var.resource_group_location == null ? 1 : 0

  name = var.resource_group_name
}

locals {
  resource_group_location = var.resource_group_location == null ? data.azurerm_resource_group.network[0].location : var.resource_group_location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = local.resource_group_location
  address_space       = length(var.address_spaces) == 0 ? [var.address_space] : var.address_spaces
  dns_servers         = var.dns_servers
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  count                                          = length(var.subnet_names)
  name                                           = var.subnet_names[count.index]
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = [var.subnet_prefixes[count.index]]
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  enforce_private_link_endpoint_network_policies = lookup(var.subnet_enforce_private_link_endpoint_network_policies, var.subnet_names[count.index], false)
  service_endpoints                              = lookup(var.subnet_service_endpoints, var.subnet_names[count.index], [])
}
