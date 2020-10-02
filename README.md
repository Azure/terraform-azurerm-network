# terraform-azurerm-network

[![Build Status](https://travis-ci.org/Azure/terraform-azurerm-network.svg?branch=master)](https://travis-ci.org/Azure/terraform-azurerm-network)

## Create a basic network in Azure, optionally create subnets and NSG attached to those subnets

This Terraform module deploys a Virtual Network in Azure with a subnet and NSG or a set of subnets passed in as input parameters.


## Usage - create vnet two subnets, subnet1 without NSG subnet2 with NSG
```hcl
resource "azurerm_resource_group" "test" {
  name     = "my-resources"
  location = "West Europe"
}

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.test.name
  address_space       = "10.0.0.0/16"

  subnets = {
    subnet1 = {
      address_prefixes = ["10.0.1.0/24"]
      nsg              = false
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

```

## Usage - create vnet with no subnsets
```hcl
resource "azurerm_resource_group" "test" {
  name     = "my-resources"
  location = "West Europe"
}

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.test.name
  address_space       = "10.0.0.0/16"
  subnets = {}

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

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| address\_space | The address space that is used by the virtual network. | `list(string)` | <pre>[<br>  "10.0.0.0/16"<br>]</pre> | no |
| dns\_servers | The DNS servers to be used with vNet. | `list` | `[]` | no |
| name | Name of the vnet to create | `string` | `"acctvnet"` | no |
| resource\_group\_name | Name of the resource group to be imported. | `any` | n/a | yes |
| subnets | If no values specified, this defaults to creating two subnets | `map` | <pre>{<br>  "subnet1": {<br>    "address_prefixes": [<br>      "10.0.2.0/24"<br>    ]<br>  }<br>}</pre> | no |
| tags | The tags to associate with your network and subnets. | `map(string)` | <pre>{<br>  "env": "test"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| network\_security\_groups | The network security groups objects created by this module |
| subnets | The subnets created by this module |
| vnet | The entire azurerm\_virtual\_network resource |
| vnet\_address\_space | The address space of the newly created vNet |
| vnet\_id | The id of the newly created vNet |
| vnet\_location | The location of the newly created vNet |
| vnet\_name | The Name of the newly created vNet |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Originally created by [Eugene Chuvyrov](http://github.com/echuvyrov)
Updated by [Alex Bevan](http://github.com/echuvyrov)

## License

[MIT](LICENSE)
