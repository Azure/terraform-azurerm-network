provider "azurerm" {
  features {}
}

resource "random_id" "rg_name" {
  byte_length = 8
}

resource "azurerm_resource_group" "test" {
  name     = "testRG-${random_id.rg_name.hex}"
  location = var.location
}

module "network" {
  source              = "../../"
  resource_group_name = azurerm_resource_group.test.name
  address_spaces      = ["10.0.0.0/16", "10.2.0.0/16"]

  subnets_list = {
    subnet-subnet1 = {
      name                     = "subnet1"
      address_prefixes         = ["10.0.1.0/24"]
      enforce_private_link     = true
      subnet_service_endpoints = ["Microsoft.Sql"]
    },
    subnet-subnet2 = {
      name                     = "subnet2"
      address_prefixes         = ["10.0.2.0/24"]
      enforce_private_link     = false
      subnet_service_endpoints = ["Microsoft.Sql"]
    },
    subnet-subnet3 = {
      name                     = "subnet3"
      address_prefixes         = ["10.0.3.0/24"]
      enforce_private_link     = false
      subnet_service_endpoints = ["Microsoft.Sql"]
    }
  }

  tags = {
    environment = "dev"
    costcenter  = "it"
  }

  depends_on = [azurerm_resource_group.test]
}
