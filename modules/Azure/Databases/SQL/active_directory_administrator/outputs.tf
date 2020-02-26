output "active_directory_administrator_id" {
  value = azurerm_sql_active_directory_administrator.active_directory_administrator.*.id
}