variable "name" {
  description = "Name of the vnet to create"
  default     = "acctvnet"
}

variable "resource_group_name" {
  description = "Name of the resource group to be imported."
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = ["10.0.0.0/16"]
}

# If no values specified, this defaults to Azure DNS 
variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  default     = []
}

# If no values specified, this defaults to creating two subnets
variable "subnets" {
  default = {
    subnet1 = {
      address_prefixes = ["10.0.1.0/24"]
    }

    subnet1 = {
      address_prefixes = ["10.0.2.0/24"]
    }
  }
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {
    ENV = "test"
  }
}
