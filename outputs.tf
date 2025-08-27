#====================================
# outputs.tf
# The output file that holds information for items deployed
#====================================

output "sql_server_fqdn" {
  value = module.azure_sql.sql_server_fqdn
}

output "sql_database_name" {
  value = module.azure_sql.sql_database_name
}

output "private_endpoint_ip" {
  value = module.azure_sql.private_endpoint_ip
}

output "private_dns_zone_name" {
  value = module.azure_sql.private_dns_zone_name
}
