Create a basic network in Azure
==============================================================================

This Terraform module deploys a Virtual Network in Azure with the following characteristics: 

- Creates a network with a subnet or a set of subnets passed in as input parameters.
- Exposes a security group as one of the output parameters, which you can use to define additional security rules on subnets in the deployed network.

Module Input Variables 
----------------------

- `prefix` - The prefix that will be used for all resources that will be created by this module.
- `location` - The Azure location where the resources will be created.
- `address_space` - The address space for the virtual network that will be created.
- `dns_servers` - DNS Servers to use for this network; if blank, this defaults to use Azure DNS.
- `subnet_prefixes` - An array of subnet prefixes for subnets that will be created inside this network.
- `subnet_names` - An array of subnet names for subnets that will be created inside this network (this is parallel to subnet_prefixes array).  
- `tags` - A map of the tags to use on the resources that are deployed with this module.

Usage
-----

```hcl 
module "network" { 
    source              = "Microsoft/network/azurerm"
    prefix              = "myapp"
    location            = "westus"
    address_space       = "10.0.0.0/16"
    subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    subnet_names        = ["subnet1", "subnet2", "subnet3"]

    tags                = {
                            environment = "dev"
                            costcenter  = "it"
                          }
}

```

Outputs
=======

- `vnet_id` - Id of the Virtual Network created
- `vnet_name` - Name of the Virtual Network created
- `vnet_location` - Location of the Virtual Network created
- `vnet_address_space` - Address space of the Virtual Network created
- `vnet_dns_servers` - DNS Servers of the Virtual Network created
- `vnet_subnets` - Ids of subnets inside the Virtual Network created
- `security_group_id` - Id of the security group created and attached to each subnet within the Virtual Network created

Authors
=======
Originally created by [Eugene Chuvyrov](http://github.com/echuvyrov)