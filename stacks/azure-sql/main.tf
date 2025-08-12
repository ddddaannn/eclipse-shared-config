data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "pe_subnet" {
  name                 = var.pe_subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

module "sql" {
  source = "git::https://example.com/your-org/cmn-ref-tf-azure-sql-module.git//modules/sql?ref=v1.0.0"

  location               = var.location
  resource_group_name    = data.azurerm_resource_group.rg.name

  server_name            = var.sql.server_name
  administrator_login    = var.sql.admin_login
  administrator_password = var.sql.admin_password

  aad_admin_object_id  = try(var.sql.aad_admin_object_id, null)
  aad_admin_login_name = try(var.sql.aad_admin_login_name, null)

  db_name               = try(var.sql.db_name, null)
  sku_name              = try(var.sql.sku_name, "GP_S_Gen5_2")
  min_tls_version       = try(var.sql.min_tls_version, "1.2")
  public_network_access = try(var.sql.public_network_access, false)

  threat_detection_email = try(var.sql.threat_detection_email, null)
  diag_log_analytics_id  = try(var.sql.diag_log_analytics_id, null)

  tags = var.tags
}

# Option A: Let the PE module create/own the zone (simple for greenfield)
module "sql_private_endpoint" {
  source = "git::https://example.com/your-org/cmn-ref-tf-private-endpoint-module.git//modules/private_endpoint?ref=v1.0.0"

  name                 = "${module.sql.sql_server_name}-pe"
  resource_group_name  = data.azurerm_resource_group.rg.name
  location             = var.location

  target_resource_id   = module.sql.sql_server_id
  subresource_names    = ["sqlServer"] # critical for SQL Server PE
  subnet_id            = data.azurerm_subnet.pe_subnet.id

  create_dns_zone      = var.dns.create_zone
  dns_zone_name        = try(var.dns.existing_zone_name, "privatelink.database.windows.net")
  dns_zone_rg_name     = try(var.dns.existing_zone_rg_name, data.azurerm_resource_group.rg.name)

  # If the module supports VNET links, pass the VNet IDs (often it does)
  vnet_ids_for_links   = [data.azurerm_virtual_network.vnet.id]

  manual_approval      = false
  tags                 = var.tags

  depends_on = [module.sql]
}
