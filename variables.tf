variable "subnet_names" {
  type        = list(string)
  description = "A list of subnet names to create"
}

variable "subnet_prefixes" {
  type        = list(string)
  description = "A list of subnet prefixes (CIDR blocks) for the subnets"
}
