variable "subscription_id" {}
variable "tenant_id" {}
variable "location" { default = "southeastasia" }

variable "resource_group_name" {}
variable "vnet_name" {}
variable "pe_subnet_name" {}

variable "sql" {
  type = object({
    server_name             = string
    admin_login             = string
    admin_password          = string
    aad_admin_object_id     = optional(string)
    aad_admin_login_name    = optional(string)
    db_name                 = optional(string)
    sku_name                = optional(string) # e.g., GP_S_Gen5_2 or S0
    min_tls_version         = optional(string) # "1.2"
    public_network_access   = optional(bool)   # false for PE-only
    threat_detection_email  = optional(string)
    diag_log_analytics_id   = optional(string) # if sending diagnostics
  })
  sensitive = true
}

variable "dns" {
  type = object({
    create_zone           = bool
    existing_zone_rg_name = optional(string)
    existing_zone_name    = optional(string)   # privatelink.database.windows.net
  })
}

variable "tags" { type = map(string) }
