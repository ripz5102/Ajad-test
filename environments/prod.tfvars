resource_group_name = "rg-ajad-prod"
location            = "uksouth"
environment         = "prod"

vnet_name          = "vnet_ajad_prod"
vnet_address_space = ["10.20.0.0/16"]

subnets = {
  app = {
    subnet_name    = "snet-app"
    address_prefix = "10.20.1.0/24"
  }
  mgmt = {
    subnet_name    = "snet-mgmt"
    address_prefix = "10.20.2.0/24"
  }
  db = {
    subnet_name    = "snet-db"
    address_prefix = "10.20.3.0/24"
  }
  backup = {
    subnet_name    = "snet-backup"
    address_prefix = "10.20.4.0/24"
  }
  monitoring = {
    subnet_name    = "snet-monitoring"
    address_prefix = "10.20.5.0/24"
  }
}