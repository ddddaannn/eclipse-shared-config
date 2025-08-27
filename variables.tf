#====================================
# variables.tf
# The main variable file for the configuration
#====================================

variable "env" {
  description = "Environment name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Existing Resource Group name"
  type        = string
}

variable "vnet_name" {
  description = "Existing VNet name"
  type        = string
}

variable "subnet_name" {
  description = "Existing Subnet name"
  type        = string
}

variable "key_vault_name" {
  description = "Existing Key Vault name"
  type        = string
}

variable "sql_admin_user_secret_name" {
  description = "Secret name in Key Vault for SQL admin username"
  type        = string
}

variable "sql_admin_password_secret_name" {
  description = "Secret name in Key Vault for SQL admin password"
  type        = string
}

variable "aad_admin_login_username" {
  type        = string
  description = "Display name of the Azure AD group/user to be SQL Admin (e.g., 'SQL-Admins')."
}

variable "aad_admin_object_id" {
  type        = string
  description = "Object ID (GUID) of the Azure AD group/user to be SQL Admin."
}

variable "sql_database_zone_redundant" {
  description = "Whether the database is zone redundant (for supported SKUs)."
  type        = bool
  default     = false
}

variable "sql_database_sku" {
  description = "SKU name for Azure SQL Database"
  type        = string
}

variable "sql_database_max_size_gb" {
  description = "Maximum size of the Azure SQL Database in GB"
  type        = number
}

variable "sql_server_name" {
  description = "Azure SQL Server name"
  type        = string
}

variable "sql_database_name" {
  description = "Azure SQL Database name"
  type        = string
}

variable "private_dns_zone_name" {
  description = "Private DNS Zone name"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "client_id" {
  description = "Azure Client ID"
  type        = string
}

#====================================
# Backend vars
#====================================

variable "backend_rg_name" { type = string }
variable "backend_storage_account_name" { type = string }
variable "backend_container_name" { type = string }
