provider "azurerm" {
  features {}
}

resource "random_id" "rg_name" {
  byte_length = 8
}

resource "azurerm_resource_group" "test" {
  name     = "test-${random_id.rg_name.hex}-rg"
  location = "UK South"
}


module "vnet" {
  source              = "../../"
  resource_group_name = azurerm_resource_group.test.name
  name                = "vnet"
  address_space       = ["10.0.0.0/16"]
  subnets = {
    subnet1 = {
      address_prefixes = ["10.0.1.0/24"]
      nsg_rules = [
        {
          name                       = "W32Time",
          priority                   = "100"
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "UDP"
          source_port_range          = "*"
          destination_port_range     = "123"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "RPC-Endpoint-Mapper",
          priority                   = "101"
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "UDP"
          source_port_range          = "*"
          destination_port_range     = "135"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    }
    subnet2 = {
      address_prefixes = ["10.0.2.0/24"]
      nsg              = false
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

