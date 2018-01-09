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

Test
-----
### Configurations
- [Configure Terraform for Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure)

We provide 2 ways to build, run, and test module on local dev box:

### Native(Mac/Linux)

#### Prerequisites
- [Ruby **(~> 2.3)**](https://www.ruby-lang.org/en/downloads/)
- [Bundler **(~> 1.15)**](https://bundler.io/)
- [Terraform **(~> 0.11.0)**](https://www.terraform.io/downloads.html)

#### Quick Run
We provide simple script to quickly set up module development environment:
```sh
$ curl -sSL https://raw.githubusercontent.com/Azure/terramodtest/master/tool/env_setup.sh | sudo bash
```
Then simply run it in local shell:
```sh
$ bundle install
$ rake build
$ rake e2e
```

### Docker
We provide Dockerfile to build and run module development environment locally:
#### Prerequisites
- [Docker](https://www.docker.com/community-edition#/download)
#### Quick Run
```sh
$ docker build -t azure-network .
$ docker run -it azure-network /bin/sh
$ rake build
$ rake e2e
```

Authors
=======
Originally created by [Eugene Chuvyrov](http://github.com/echuvyrov)
