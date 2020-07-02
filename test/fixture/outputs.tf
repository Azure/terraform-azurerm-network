output "test_vnet_id" {
  value = module.vnet.vnet_id
}

output "vnet_subnets" {
  value = module.vnet.subnets
}

output "vnet_subnet1_id" {
  value = module.vnet.subnets["subnet1"].id
}
