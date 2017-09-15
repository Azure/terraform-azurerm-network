Create a basic network in Azure
==============================================================================

This Terraform module deploys a Virtual Network in Azure with the following characteristics: 

- Creates a network with a subnet or a set of subnets passed in as input parameters.
- Exposes a security group as one of the output parameters, which you can use to define additional security rules on subnets in the deployed network.


Usage
-----

```hcl 
module "network" { 
    source              = "Azure/network/azurerm"
    resource_group_name = "myapp"
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


Authors
=======
Originally created by [Eugene Chuvyrov](http://github.com/echuvyrov)
