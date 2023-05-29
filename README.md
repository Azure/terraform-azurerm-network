# terraform-azurerm-network

## Create a basic network in Azure

This Terraform module deploys a Virtual Network in Azure with a subnet or a set of subnets passed in as input parameters.
Testing the Code.
The module does not create nor expose a security group. You could use https://github.com/Azure/terraform-azurerm-vnet to assign network security group to the subnets.

## Notice on Upgrade to V5.x

In v5.0.0, we would make `var.use_for_each` a required variable so the users must set the value explicitly. For whom are maintaining the existing infrastructure that was created with `count` should use `false`, for those who are creating a new stack, we encourage them to use `true`.

V5.0.0 is a major version upgrade. Extreme caution must be taken during the upgrade to avoid resource replacement and downtime by accident.

Running the `terraform plan` first to inspect the plan is strongly advised.

## Notice on Upgrade to V4.x

We've added a CI pipeline for this module to speed up our code review and to enforce a high code quality standard, if you want to contribute by submitting a pull request, please read [Pre-Commit & Pr-Check & Test](#Pre-Commit--Pr-Check--Test) section, or your pull request might be rejected by CI pipeline.

A pull request will be reviewed when it has passed Pre Pull Request Check in the pipeline, and will be merged when it has passed the acceptance tests. Once the ci Pipeline failed, please read the pipeline's output, thanks for your cooperation.

V4.0.0 is a major version upgrade. Extreme caution must be taken during the upgrade to avoid resource replacement and downtime by accident.

Running the `terraform plan` first to inspect the plan is strongly advised.

## Usage

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
  use_for_each = true
  tags = {
    environment = "dev"
    costcenter  = "it"
  }

  depends_on = [azurerm_resource_group.example]
}
```

## Notice to contributor

Thanks for your contribution! This module was created before Terraform introduce `for_each`, and according to the [document](https://developer.hashicorp.com/terraform/language/meta-arguments/count#when-to-use-for_each-instead-of-count):

>If your instances are almost identical, `count` is appropriate. If some of their arguments need distinct values that can't be directly derived from an integer, it's safer to use `for_each`.

This module contains resources with `count` meta-argument, but if we change `count` to `for_each` directly, it would require heavily manually state move operations with extremely caution, or the users who are maintaining existing infrastructure would face potential breaking change.

This module replicated a new `azurerm_subnet` which used `for_each`, and we provide a new toggle variable named `use_for_each`, this toggle is a switcher between `count` set and `for_each` set. Now user can set `var.use_for_each` to `true` to use `for_each`, and users who're maintaining existing resources could keep this toggle `false` to avoid potential breaking change. If you'd like to make changes to subnet resource, make sure that you've change both `resource` blocks. Thanks for your cooperation.

## Pre-Commit & Pr-Check & Test

### Configurations

- [Configure Terraform for Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure)

We assumed that you have setup service principal's credentials in your environment variables like below:

```shell
export ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
export ARM_TENANT_ID="<azure_subscription_tenant_id>"
export ARM_CLIENT_ID="<service_principal_appid>"
export ARM_CLIENT_SECRET="<service_principal_password>"
```

On Windows Powershell:

```shell
$env:ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
$env:ARM_TENANT_ID="<azure_subscription_tenant_id>"
$env:ARM_CLIENT_ID="<service_principal_appid>"
$env:ARM_CLIENT_SECRET="<service_principal_password>"
```

We provide a docker image to run the pre-commit checks and tests for you: `mcr.microsoft.com/azterraform:latest`

To run the pre-commit task, we can run the following command:

```shell
$ docker run --rm -v $(pwd):/src -w /src mcr.microsoft.com/azterraform:latest make pre-commit
```

On Windows Powershell:

```shell
$ docker run --rm -v ${pwd}:/src -w /src mcr.microsoft.com/azterraform:latest make pre-commit
```

In pre-commit task, we will:

1. Run `terraform fmt -recursive` command for your Terraform code.
2. Run `terrafmt fmt -f` command for markdown files and go code files to ensure that the Terraform code embedded in these files are well formatted.
3. Run `go mod tidy` and `go mod vendor` for test folder to ensure that all the dependencies have been synced.
4. Run `gofmt` for all go code files.
5. Run `gofumpt` for all go code files.
6. Run `terraform-docs` on `README.md` file, then run `markdown-table-formatter` to format markdown tables in `README.md`.

Then we can run the pr-check task to check whether our code meets our pipeline's requirement(We strongly recommend you run the following command before you commit):

```shell
$ docker run --rm -v $(pwd):/src -w /src -e TFLINT_CONFIG=.tflint_alt.hcl mcr.microsoft.com/azterraform:latest make pr-check
```

On Windows Powershell:

```shell
$ docker run --rm -v ${pwd}:/src -w /src -e TFLINT_CONFIG=.tflint_alt.hcl mcr.microsoft.com/azterraform:latest make pr-check
```

To run the e2e-test, we can run the following command:

```text
docker run --rm -v $(pwd):/src -w /src -e ARM_SUBSCRIPTION_ID -e ARM_TENANT_ID -e ARM_CLIENT_ID -e ARM_CLIENT_SECRET mcr.microsoft.com/azterraform:latest make e2e-test
```

On Windows Powershell:

```text
docker run --rm -v ${pwd}:/src -w /src -e ARM_SUBSCRIPTION_ID -e ARM_TENANT_ID -e ARM_CLIENT_ID -e ARM_CLIENT_SECRET mcr.microsoft.com/azterraform:latest make e2e-test
```

## Prerequisites

- [Docker](https://www.docker.com/community-edition#/download)

## Authors

Originally created by [Eugene Chuvyrov](http://github.com/echuvyrov)

## License

[MIT](LICENSE)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name                                                                      | Version       |
|---------------------------------------------------------------------------|---------------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3        |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)       | >= 3.0, < 4.0 |

## Providers

| Name                                                          | Version       |
|---------------------------------------------------------------|---------------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0, < 4.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                                | Type        |
|-------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [azurerm_subnet.subnet_count](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)               | resource    |
| [azurerm_subnet.subnet_for_each](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)            | resource    |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network)     | resource    |
| [azurerm_resource_group.network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name                                                                                                                                                                                                          | Description                                                                                                                                                                                                                                                                                   | Type                                                                                                                                                                           | Default                                     | Required |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space)                                                                                                                                   | The address space that is used by the virtual network.                                                                                                                                                                                                                                        | `string`                                                                                                                                                                       | `"10.0.0.0/16"`                             |    no    |
| <a name="input_address_spaces"></a> [address\_spaces](#input\_address\_spaces)                                                                                                                                | The list of the address spaces that is used by the virtual network.                                                                                                                                                                                                                           | `list(string)`                                                                                                                                                                 | `[]`                                        |    no    |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers)                                                                                                                                         | The DNS servers to be used with vNet.                                                                                                                                                                                                                                                         | `list(string)`                                                                                                                                                                 | `[]`                                        |    no    |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location)                                                                                                   | The location/region where the virtual network is created. Changing this forces a new resource to be created.                                                                                                                                                                                  | `string`                                                                                                                                                                       | `null`                                      |    no    |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)                                                                                                               | The name of an existing resource group to be imported.                                                                                                                                                                                                                                        | `string`                                                                                                                                                                       | n/a                                         |   yes    |
| <a name="input_subnet_delegation"></a> [subnet\_delegation](#input\_subnet\_delegation)                                                                                                                       | `service_delegation` blocks for `azurerm_subnet` resource, subnet names as keys, list of delegation blocks as value, more details about delegation block could be found at the [document](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet#delegation). | <pre>map(list(object({<br>    name = string<br>    service_delegation = object({<br>      name    = string<br>      actions = optional(list(string))<br>    })<br>  })))</pre> | `{}`                                        |    no    |
| <a name="input_subnet_enforce_private_link_endpoint_network_policies"></a> [subnet\_enforce\_private\_link\_endpoint\_network\_policies](#input\_subnet\_enforce\_private\_link\_endpoint\_network\_policies) | A map with key (string) `subnet name`, value (bool) `true` or `false` to indicate enable or disable network policies for the private link endpoint on the subnet. Default value is false.                                                                                                     | `map(bool)`                                                                                                                                                                    | `{}`                                        |    no    |
| <a name="input_subnet_names"></a> [subnet\_names](#input\_subnet\_names)                                                                                                                                      | A list of public subnets inside the vNet.                                                                                                                                                                                                                                                     | `list(string)`                                                                                                                                                                 | <pre>[<br>  "subnet1"<br>]</pre>            |    no    |
| <a name="input_subnet_prefixes"></a> [subnet\_prefixes](#input\_subnet\_prefixes)                                                                                                                             | The address prefix to use for the subnet.                                                                                                                                                                                                                                                     | `list(string)`                                                                                                                                                                 | <pre>[<br>  "10.0.1.0/24"<br>]</pre>        |    no    |
| <a name="input_subnet_service_endpoints"></a> [subnet\_service\_endpoints](#input\_subnet\_service\_endpoints)                                                                                                | A map with key (string) `subnet name`, value (list(string)) to indicate enabled service endpoints on the subnet. Default value is [].                                                                                                                                                         | `map(list(string))`                                                                                                                                                            | `{}`                                        |    no    |
| <a name="input_tags"></a> [tags](#input\_tags)                                                                                                                                                                | The tags to associate with your network and subnets.                                                                                                                                                                                                                                          | `map(string)`                                                                                                                                                                  | <pre>{<br>  "environment": "dev"<br>}</pre> |    no    |
| <a name="input_use_for_each"></a> [use\_for\_each](#input\_use\_for\_each)                                                                                                                                    | Use `for_each` instead of `count` to create multiple resource instances.                                                                                                                                                                                                                      | `bool`                                                                                                                                                                         | n/a                                         |   yes    |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name)                                                                                                                                               | Name of the vnet to create.                                                                                                                                                                                                                                                                   | `string`                                                                                                                                                                       | `"acctvnet"`                                |    no    |

## Outputs

| Name                                                                                           | Description                                              |
|------------------------------------------------------------------------------------------------|----------------------------------------------------------|
| <a name="output_vnet_address_space"></a> [vnet\_address\_space](#output\_vnet\_address\_space) | The address space of the newly created vNet              |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id)                                    | The id of the newly created vNet                         |
| <a name="output_vnet_location"></a> [vnet\_location](#output\_vnet\_location)                  | The location of the newly created vNet                   |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name)                              | The name of the newly created vNet                       |
| <a name="output_vnet_subnets"></a> [vnet\_subnets](#output\_vnet\_subnets)                     | The ids of subnets created inside the newly created vNet |
<!-- END_TF_DOCS -->
