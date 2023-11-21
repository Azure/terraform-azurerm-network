#Azure Generic vNet Module
data "azurerm_resource_group" "network" {
  count = var.resource_group_location == null ? 1 : 0

  name = var.resource_group_name
}

locals {
  resource_group_location = var.resource_group_location == null ? data.azurerm_resource_group.network[0].location : var.resource_group_location
}

resource "azurerm_virtual_network" "vnet" {
  address_space       = length(var.address_spaces) == 0 ? [var.address_space] : var.address_spaces
  location            = local.resource_group_location
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  dns_servers         = var.dns_servers
  tags = merge(var.tags, (/*<box>*/ (var.tracing_tags_enabled ? { for k, v in /*</box>*/ {
    avm_git_commit           = "c506f86f75a34ad34c2b4437e8076f1f06bf6a00"
    avm_git_file             = "main.tf"
    avm_git_last_modified_at = "2022-11-23 09:20:55"
    avm_git_org              = "Azure"
    avm_git_repo             = "terraform-azurerm-network"
    avm_yor_trace            = "aedafc56-ff63-46ac-a821-5b86c3896c5e"
    } /*<box>*/ : replace(k, "avm_", var.tracing_tags_prefix) => v } : {}) /*</box>*/), (/*<box>*/ (var.tracing_tags_enabled ? { for k, v in /*</box>*/ {
    avm_yor_name = "vnet"
  } /*<box>*/ : replace(k, "avm_", var.tracing_tags_prefix) => v } : {}) /*</box>*/))
}

moved {
  from = azurerm_subnet.subnet
  to   = azurerm_subnet.subnet_count
}

resource "azurerm_subnet" "subnet_count" {
  count = var.use_for_each ? 0 : length(var.subnet_names)

  address_prefixes                               = [var.subnet_prefixes[count.index]]
  name                                           = var.subnet_names[count.index]
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  enforce_private_link_endpoint_network_policies = lookup(var.subnet_enforce_private_link_endpoint_network_policies, var.subnet_names[count.index], false)
  service_endpoints                              = lookup(var.subnet_service_endpoints, var.subnet_names[count.index], [])

  dynamic "delegation" {
    for_each = lookup(var.subnet_delegation, var.subnet_names[count.index], [])

    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }
}

resource "azurerm_subnet" "subnet_for_each" {
  for_each = var.use_for_each ? toset(var.subnet_names) : []

  address_prefixes                               = [local.subnet_names_prefixes_map[each.value]]
  name                                           = each.value
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  enforce_private_link_endpoint_network_policies = lookup(var.subnet_enforce_private_link_endpoint_network_policies, each.value, false)
  service_endpoints                              = lookup(var.subnet_service_endpoints, each.value, [])

  dynamic "delegation" {
    for_each = lookup(var.subnet_delegation, each.value, [])

    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }
}

locals {
  azurerm_subnets = var.use_for_each ? [for s in azurerm_subnet.subnet_for_each : s] : [for s in azurerm_subnet.subnet_count : s]
}