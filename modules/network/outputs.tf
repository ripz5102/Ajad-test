output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_ids" {
  value = {
    for key, subnet in azurerm_subnet.subnets :
    key => subnet.id
  }
}