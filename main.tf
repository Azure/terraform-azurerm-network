#Azure Generic vNet Module
resource "azurerm_resource_group" "network" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}

module "terraform-azurerm-vnet" {
  source              = "Azure/vnet/azurerm"
  version             = "1.0.0"
  vnet_name           = "${var.vnet_name}"
  location            = "${var.location}"
  address_space       = "${var.address_space}"
  resource_group_name = "${azurerm_resource_group.network.name}"
  dns_servers         = "${var.dns_servers}"
  tags                = "${var.tags}"
}
