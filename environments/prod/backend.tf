terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "sttfstatecapstone01"
    container_name       = "tfstate"
    key                  = "prod.tfstate"
  }
}