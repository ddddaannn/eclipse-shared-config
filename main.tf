#====================================
# main.tf
# The main configuration file to deploy the SQL module and related settings
#====================================

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = var.resource_group_name
}

data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault_secret" "sql_admin_user" {
  name         = var.sql_admin_user_secret_name
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "sql_admin_password" {
  name         = var.sql_admin_password_secret_name
  key_vault_id = data.azurerm_key_vault.kv.id
}

module "azure_sql" {
  source = "git@github.com:epicor-global/cmn-ref-tf-azure-sql-module?ref=v1.0.0"

  location                    = var.location
  resource_group_name         = var.resource_group_name
  sql_server_name             = var.sql_server_name
  sql_database_name           = var.sql_database_name
  sql_database_sku            = var.sql_database_sku
  sql_database_max_size_gb    = var.sql_database_max_size_gb
  sql_database_zone_redundant = var.sql_database_zone_redundant
  sql_admin_user              = data.azurerm_key_vault_secret.sql_admin_user.value
  sql_admin_password          = data.azurerm_key_vault_secret.sql_admin_password.value
  aad_admin_login_username    = var.aad_admin_login_username
  aad_admin_object_id         = var.aad_admin_object_id
  subnet_id                   = data.azurerm_subnet.subnet.id
  private_dns_zone_name       = var.private_dns_zone_name
  vnet_id                     = data.azurerm_virtual_network.vnet.id
}
