# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    owner       = "aj"
    environment = "dev"
    managed_by  = "Terraform"
  }
}

# Network Module - VNet and Subnets
module "network" {
  source = "./modules/network"

  vnet_name           = "vnet_ajad_dev"
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  subnets             = var.subnets
}

# Network Security Group
resource "azurerm_network_security_group" "nsg-ajad" {
  name                = "nsg-ajad-app"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

# NSG Rules
resource "azurerm_network_security_rule" "nsg_rules" {
  for_each = var.nsg_rules

  name                       = each.value.name
  priority                   = each.value.priority
  direction                  = "Inbound"
  access                     = each.value.access
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = each.value.destination_port
  source_address_prefix      = "10.10.2.0/24"
  destination_address_prefix = "10.10.1.0/24"

  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg-ajad.name
}

# Associate the App Subnet with the NSG
resource "azurerm_subnet_network_security_group_association" "app" {
  subnet_id                 = module.network.subnet_ids["app"]
  network_security_group_id = azurerm_network_security_group.nsg-ajad.id
}

# Existing VNet move - safe to retain
moved {
  from = azurerm_virtual_network.vnet
  to   = module.network.azurerm_virtual_network.vnet
}

# Move App Subnet into Network Module
moved {
  from = azurerm_subnet.subnets["app"]
  to   = module.network.azurerm_subnet.subnets["app"]
}

# Move Management Subnet into Network Module
moved {
  from = azurerm_subnet.subnets["mgmt"]
  to   = module.network.azurerm_subnet.subnets["mgmt"]
}

# Move Database Subnet into Network Module
moved {
  from = azurerm_subnet.subnets["db"]
  to   = module.network.azurerm_subnet.subnets["db"]
}