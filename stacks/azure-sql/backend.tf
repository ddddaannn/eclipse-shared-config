terraform {
  backend "azurerm" {
    resource_group_name  = "rg-dann-tfstate-dev"
    storage_account_name = "satfstate8825"
    container_name       = "devtfstate"
    key                  = "hubspoke-dev.tfstate"
  }
}