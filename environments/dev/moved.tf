moved {
  from = azurerm_virtual_network.vnet
  to   = module.network.azurerm_virtual_network.vnet
}
moved {
  from = azurerm_subnet.app
  to   = azurerm_subnet.subnets["app"]
}

moved {
  from = azurerm_subnet.mgmt
  to   = azurerm_subnet.subnets["mgmt"]
}
moved {
  from = azurerm_subnet.subnets["app"]
  to   = module.network.azurerm_subnet.subnets["app"]
}

moved {
  from = azurerm_subnet.subnets["mgmt"]
  to   = module.network.azurerm_subnet.subnets["mgmt"]
}

moved {
  from = azurerm_subnet.subnets["db"]
  to   = module.network.azurerm_subnet.subnets["db"]
}