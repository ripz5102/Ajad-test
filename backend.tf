terraform {
  backend "azurerm" {
    resource_group_name  = "rg-ajad-tfstate"
    storage_account_name = "tfajad1792532286"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"

    use_azuread_auth = true
    use_cli          = true
  }
}