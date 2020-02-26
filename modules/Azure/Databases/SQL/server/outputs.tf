output "server_id" {
  value = azurerm_sql_server.server.*.id
}

output "resource_group_name" {
  value = azurerm_sql_server.server.*.resource_group_name
}

output "location" {
  value = azurerm_sql_server.server.*.location
}

output "administrator_login" {
  value = azurerm_sql_server.server.*.administrator_login
}

output "administrator_password" {
  value = azurerm_sql_server.server.*.administrator_login_password
}