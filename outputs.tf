output "sql_server_fqdn" {
  description = "FQDN do SQL Server"
  value       = azurerm_mssql_server.sqlserver.fully_qualified_domain_name
}

output "sql_database_name" {
  description = "Nome do banco de dados"
  value       = azurerm_mssql_database.sqldb.name
}

output "db_connection_string" {
  description = "Connection string do banco de dados"
  value       = "Server=tcp:${azurerm_mssql_server.sqlserver.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.sqldb.name};Persist Security Info=False;User ID=${azurerm_mssql_server.sqlserver.administrator_login};Password=${var.sql_admin_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  sensitive   = true
}

output "storage_account_name" {
  description = "Nome do Storage Account"
  value       = azurerm_storage_account.storage.name
}

output "storage_account_connection_string" {
  description = "Connection string do Storage Account"
  value       = azurerm_storage_account.storage.primary_connection_string
  sensitive   = true
}

output "storage_account_primary_blob_endpoint" {
  description = "Endpoint do blob storage"
  value       = azurerm_storage_account.storage.primary_blob_endpoint
}

output "storage_container_name" {
  description = "Nome do container de imagens"
  value       = azurerm_storage_container.images.name
}