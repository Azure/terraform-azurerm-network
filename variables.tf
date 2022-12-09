variable "resource_group_name" {
  description = "The name of an existing resource group to be imported."
  type        = string
}

variable "use_for_each" {
  description = "Use `for_each` instead of `count` to create multiple resource instances."
  type        = bool
  nullable    = false
}

variable "address_space" {
  description = "The address space that is used by the virtual network."
  type        = string
  default     = "10.0.0.0/16"
}

variable "address_spaces" {
  description = "The list of the address spaces that is used by the virtual network."
  type        = list(string)
  default     = []
}

# If no values specified, this defaults to Azure DNS 
variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  type        = list(string)
  default     = []
}

variable "resource_group_location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "subnet_delegation" {
  description = "`service_delegation` blocks for `azurerm_subnet` resource, subnet names as keys, list of delegation blocks as value, more details about delegation block could be found at the [document](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet#delegation)."
  type = map(list(object({
    name = string
    service_delegation = object({
      name    = string
      actions = optional(list(string))
    })
  })))
  default  = {}
  nullable = false
}

variable "subnet_enforce_private_link_endpoint_network_policies" {
  description = "A map with key (string) `subnet name`, value (bool) `true` or `false` to indicate enable or disable network policies for the private link endpoint on the subnet. Default value is false."
  type        = map(bool)
  default     = {}
}

variable "subnet_names" {
  description = "A list of public subnets inside the vNet."
  type        = list(string)
  default     = ["subnet1"]
}

variable "subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "subnet_service_endpoints" {
  description = "A map with key (string) `subnet name`, value (list(string)) to indicate enabled service endpoints on the subnet. Default value is []."
  type        = map(list(string))
  default     = {}
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)
  default = {
    environment = "dev"
  }
}

variable "vnet_name" {
  description = "Name of the vnet to create."
  type        = string
  default     = "acctvnet"
}