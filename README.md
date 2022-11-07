# terraform-azurerm-network

[![Build Status](https://travis-ci.org/Azure/terraform-azurerm-network.svg?branch=master)](https://travis-ci.org/Azure/terraform-azurerm-network)

## Create a basic network in Azure

This Terraform module deploys a Virtual Network in Azure with a subnet or a set of subnets passed in as input parameters.

The module does not create nor expose a security group. You could use https://github.com/Azure/terraform-azurerm-vnet to assign network security group to the subnets.

## Usage in Terraform 0.13
```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "my-resources"
  location = "West Europe"
}

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.example.name
  address_spaces      = ["10.0.0.0/16", "10.2.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]

  subnet_service_endpoints = {
    "subnet1" : ["Microsoft.Sql"],
    "subnet2" : ["Microsoft.Sql"],
    "subnet3" : ["Microsoft.Sql"]
  }

  tags = {
    environment = "dev"
    costcenter  = "it"
  }

  depends_on = [azurerm_resource_group.example]
}
```

## Usage in Terraform 0.12
```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "my-resources"
  location = "West Europe"
}

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.example.name
  address_space       = "10.0.0.0/16"
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]

  subnet_enforce_private_link_endpoint_network_policies = {
    "subnet1" : true
  }

  subnet_service_endpoints = {
    "subnet1" : ["Microsoft.Sql"],
    "subnet2" : ["Microsoft.Sql"],
    "subnet3" : ["Microsoft.Sql"]
  }

  tags = {
    environment = "dev"
    costcenter  = "it"
  }
}

```

## Test

### Configurations

- [Configure Terraform for Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure)

We provide 2 ways to build, run, and test the module on a local development machine.  [Native (Mac/Linux)](#native-maclinux) or [Docker](#docker).

### Native (Mac/Linux)

#### Prerequisites

- [Ruby **(~> 2.3)**](https://www.ruby-lang.org/en/downloads/)
- [Bundler **(~> 1.15)**](https://bundler.io/)
- [Terraform **(~> 0.11.7)**](https://www.terraform.io/downloads.html)
- [Golang **(~> 1.10.3)**](https://golang.org/dl/)

#### Environment setup

We provide simple script to quickly set up module development environment:

```sh
$ curl -sSL https://raw.githubusercontent.com/Azure/terramodtest/master/tool/env_setup.sh | sudo bash
```

#### Run test

Then simply run it in local shell:

```sh
$ cd $GOPATH/src/{directory_name}/
$ bundle install
$ rake build
$ rake full
```

### Docker

We provide a Dockerfile to build a new image based `FROM` the `microsoft/terraform-test` Docker hub image which adds additional tools / packages specific for this module (see Custom Image section).  Alternatively use only the `microsoft/terraform-test` Docker hub image [by using these instructions](https://github.com/Azure/terraform-test).

#### Prerequisites

- [Docker](https://www.docker.com/community-edition#/download)

#### Custom Image

This builds the custom image:

```sh
$ docker build --build-arg BUILD_ARM_SUBSCRIPTION_ID=$ARM_SUBSCRIPTION_ID --build-arg BUILD_ARM_CLIENT_ID=$ARM_CLIENT_ID --build-arg BUILD_ARM_CLIENT_SECRET=$ARM_CLIENT_SECRET --build-arg BUILD_ARM_TENANT_ID=$ARM_TENANT_ID -t azure-network .
```

This runs the build and unit tests:

```sh
$ docker run --rm azure-network /bin/bash -c "bundle install && rake build"
```

This runs the end to end tests:

```sh
$ docker run --rm azure-network /bin/bash -c "bundle install && rake e2e"
```

This runs the full tests:

```sh
$ docker run --rm azure-network /bin/bash -c "bundle install && rake full"
```

## Authors

Originally created by [Eugene Chuvyrov](http://github.com/echuvyrov)

## License

[MIT](LICENSE)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name                                                                      | Version |
|---------------------------------------------------------------------------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)       | >= 3.0  |

## Providers

| Name                                                          | Version |
|---------------------------------------------------------------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                                | Type        |
|-------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)                     | resource    |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network)     | resource    |
| [azurerm_resource_group.network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name                                                                                                                                                                                                          | Description                                                                                                                                                                               | Type                | Default                                     | Required |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------|---------------------------------------------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space)                                                                                                                                   | The address space that is used by the virtual network.                                                                                                                                    | `string`            | `"10.0.0.0/16"`                             |    no    |
| <a name="input_address_spaces"></a> [address\_spaces](#input\_address\_spaces)                                                                                                                                | The list of the address spaces that is used by the virtual network.                                                                                                                       | `list(string)`      | `[]`                                        |    no    |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers)                                                                                                                                         | The DNS servers to be used with vNet.                                                                                                                                                     | `list(string)`      | `[]`                                        |    no    |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)                                                                                                               | The name of an existing resource group to be imported.                                                                                                                                    | `string`            | n/a                                         |   yes    |
| <a name="input_subnet_enforce_private_link_endpoint_network_policies"></a> [subnet\_enforce\_private\_link\_endpoint\_network\_policies](#input\_subnet\_enforce\_private\_link\_endpoint\_network\_policies) | A map with key (string) `subnet name`, value (bool) `true` or `false` to indicate enable or disable network policies for the private link endpoint on the subnet. Default value is false. | `map(bool)`         | `{}`                                        |    no    |
| <a name="input_subnet_names"></a> [subnet\_names](#input\_subnet\_names)                                                                                                                                      | A list of public subnets inside the vNet.                                                                                                                                                 | `list(string)`      | <pre>[<br>  "subnet1"<br>]</pre>            |    no    |
| <a name="input_subnet_prefixes"></a> [subnet\_prefixes](#input\_subnet\_prefixes)                                                                                                                             | The address prefix to use for the subnet.                                                                                                                                                 | `list(string)`      | <pre>[<br>  "10.0.1.0/24"<br>]</pre>        |    no    |
| <a name="input_subnet_service_endpoints"></a> [subnet\_service\_endpoints](#input\_subnet\_service\_endpoints)                                                                                                | A map with key (string) `subnet name`, value (list(string)) to indicate enabled service endpoints on the subnet. Default value is [].                                                     | `map(list(string))` | `{}`                                        |    no    |
| <a name="input_tags"></a> [tags](#input\_tags)                                                                                                                                                                | The tags to associate with your network and subnets.                                                                                                                                      | `map(string)`       | <pre>{<br>  "environment": "dev"<br>}</pre> |    no    |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name)                                                                                                                                               | Name of the vnet to create.                                                                                                                                                               | `string`            | `"acctvnet"`                                |    no    |

## Outputs

| Name                                                                                           | Description                                              |
|------------------------------------------------------------------------------------------------|----------------------------------------------------------|
| <a name="output_vnet_address_space"></a> [vnet\_address\_space](#output\_vnet\_address\_space) | The address space of the newly created vNet              |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id)                                    | The id of the newly created vNet                         |
| <a name="output_vnet_location"></a> [vnet\_location](#output\_vnet\_location)                  | The location of the newly created vNet                   |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name)                              | The name of the newly created vNet                       |
| <a name="output_vnet_subnets"></a> [vnet\_subnets](#output\_vnet\_subnets)                     | The ids of subnets created inside the newly created vNet |
<!-- END_TF_DOCS -->
