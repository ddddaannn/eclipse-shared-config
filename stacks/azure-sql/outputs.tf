output "sql_server_name" { value = module.sql.sql_server_name }
output "sql_server_fqdn" { value = module.sql.sql_server_fqdn }
output "db_id"           { value = try(module.sql.sql_db_id, null) }
output "pe_private_ip"   { value = try(module.sql_private_endpoint.private_ip, null) }

