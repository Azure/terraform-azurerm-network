provider "azurerm" {
  features {}
}

resource "random_id" "rg_name" {
  byte_length = 8
}

resource "azurerm_resource_group" "test" {
  name     = "test-${random_id.rg_name.hex}-rg"
  location = var.location
}


module "vnet" {
  source              = "../../"
  resource_group_name = azurerm_resource_group.test.name
  name                = "vnet"
  address_space       = ["10.0.0.0/16"]
  subnets = {
    subnet1 = {
      address_prefixes = ["10.0.1.0/24"]
    }
    subnet2 = {
      address_prefixes = ["10.0.2.0/24"]
    }
  }

  tags = {
    environment = "dev"
    costcenter  = "it"
  }
}

// example with no subnets

module "vnet2" {
  source              = "../../"
  resource_group_name = azurerm_resource_group.test.name
  name                = "vnet2"
  address_space       = ["10.0.0.0/16"]
  subnets             = {}
  tags = {
    environment = "dev"
    costcenter  = "it"
  }
}

