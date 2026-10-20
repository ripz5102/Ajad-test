variable "resource_group_name" {
  type    = string
  default = "rg-ajad-dev"
}

variable "location" {
  type    = string
  default = "uksouth"
}

variable "subnets" {
  type = map(object({
    subnet_name    = string
    address_prefix = string
  }))

  default = {
    app = {
      subnet_name    = "snet-app"
      address_prefix = "10.10.1.0/24"
    }

    mgmt = {
      subnet_name    = "snet-mgmt"
      address_prefix = "10.10.2.0/24"
    }
    db = {
      subnet_name    = "snet-db"
      address_prefix = "10.10.3.0/24"
    }
    backup = {
      subnet_name    = "snet-backup"
      address_prefix = "10.10.4.0/24"
    }
  }
}
variable "nsg_rules" {
  type = map(object({
    name             = string
    priority         = number
    access           = string
    destination_port = string
  }))

  default = {
    https = {
      name             = "Allow-HTTPS-From-Mgmt"
      priority         = 100
      access           = "Allow"
      destination_port = "443"
    }

    http = {
      name             = "Deny-HTTP-From-Mgmt"
      priority         = 110
      access           = "Deny"
      destination_port = "80"
    }
  }
}

variable "vnet_name" {
  type    = string
  default = "vnet_ajad_dev"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.10.0.0/16"]
}



