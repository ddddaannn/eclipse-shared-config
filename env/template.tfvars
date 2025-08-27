#================================
# Customer specific tfvars file
#================================

location                       = "eastus"
resource_group_name            = "rg-prod-eastus-001"
vnet_name                      = "vnet-prod-eastus-001"
key_vault_name                 = "kv-prod-sql-eastus"
sql_admin_user_secret_name     = "sql-admin-user"
sql_admin_password_secret_name = "sql-admin-password"
sql_database_sku               = "GP_Gen5_2"
sql_database_max_size_gb       = "32"
sql_database_zone_redundant    = "true"
private_dns_zone_name          = "privatelink.database.windows.net"
backend_rg_name                = "rg-prod-eastus-001"
backend_storage_account_name   = "eclipsetfstate"
backend_container_name         = "tfstate"
tenant_id                      = "918a556b-12a8-4c30-b315-87ed46886f4f"
subscription_id                = "3415ae7b-767d-4e95-905d-c12c032081e0"
client_id                      = "087e3d4b-2ab6-4503-9425-2edbe2aa58a4"
aad_admin_login_username       = "Terraform"
aad_admin_object_id            = "087e3d4b-2ab6-4503-9425-2edbe2aa58a4"

#===============================================
# Please update values below for each customer
#===============================================

env               = "cust-xxxxx"
subnet_name       = "sn-10.54.x.x"
sql_server_name   = "sqlserver-eclipse-xxxxx-prod-use-001"
sql_database_name = "sqldb-eclipse-xxxxx-prod-use-001"
