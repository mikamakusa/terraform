output "az_mysql_server_id" {
  value = "${azurerm_mysql_server.mysql_server.id}"
}

output "az_mysql_server_name" {
  value = "${azurerm_mysql_server.mysql_server.name}"
}

output "az_mysql_server_login" {
  value = "${azurerm_mysql_server.mysql_server.administrator_login}"
}

output "az_mysql_server_pass" {
  value = "${azurerm_mysql_server.mysql_server.administrator_login_password}"
}