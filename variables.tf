variable "resource_group_name" {
  type        = string
  description = "The name of an existing resource group to be imported."
}

variable "use_for_each" {
  type        = bool
  description = "Use `for_each` instead of `count` to create multiple resource instances."
  nullable    = false
}

variable "address_space" {
  type        = string
  default     = "10.0.0.0/16"
  description = "The address space that is used by the virtual network."
}

variable "address_spaces" {
  type        = list(string)
  default     = []
  description = "The list of the address spaces that is used by the virtual network."
}

# If no values specified, this defaults to Azure DNS 
variable "dns_servers" {
  type        = list(string)
  default     = []
  description = "The DNS servers to be used with vNet."
}

variable "resource_group_location" {
  type        = string
  default     = null
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
}

variable "subnet_delegation" {
  type = map(list(object({
    name = string
    service_delegation = object({
      name    = string
      actions = optional(list(string))
    })
  })))
  default     = {}
  description = "`service_delegation` blocks for `azurerm_subnet` resource, subnet names as keys, list of delegation blocks as value, more details about delegation block could be found at the [document](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet#delegation)."
  nullable    = false
}

variable "subnet_enforce_private_link_endpoint_network_policies" {
  type        = map(bool)
  default     = {}
  description = "A map with key (string) `subnet name`, value (bool) `true` or `false` to indicate enable or disable network policies for the private link endpoint on the subnet. Default value is false."
}

variable "subnet_names" {
  type        = list(string)
  default     = ["subnet1"]
  description = "A list of public subnets inside the vNet."
}

variable "subnet_prefixes" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "The address prefix to use for the subnet."
}

variable "subnet_service_endpoints" {
  type        = map(list(string))
  default     = {}
  description = "A map with key (string) `subnet name`, value (list(string)) to indicate enabled service endpoints on the subnet. Default value is []."
}

variable "tags" {
  type = map(string)
  default = {
    environment = "dev"
  }
  description = "The tags to associate with your network and subnets."
}

variable "vnet_name" {
  type        = string
  default     = "acctvnet"
  description = "Name of the vnet to create."
}
