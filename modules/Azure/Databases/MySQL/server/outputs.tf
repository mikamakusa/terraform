output "resource_group_name" {
  value = azurerm_mysql_server.server.*.resource_group_name
}

output "name" {
  value = azurerm_mysql_server.server.*.name
}