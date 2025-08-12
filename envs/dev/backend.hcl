  backend "azurerm" {
    resource_group_name  = "rg-dann-tfstate-dev"
    storage_account_name = "satfstate8825"
    container_name       = "devtfstate"
    key                  = "hubspoke-dev.tfstate"
    subscription_id      = 18fc0dae-23c8-403e-8e83-b8db9be1892c
  }
}