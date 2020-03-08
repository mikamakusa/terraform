output "azure_sql_server_id" {
  value = "${azurerm_sql_server.azure_sqlserver.id}"
}

output "azure_sql_server_name" {
  value = "${azurerm_sql_server.azure_sqlserver.name}"
}

output "azure_sql_login" {
  value = "${azurerm_sql_server.azure_sqlserver.administrator_login}"
}

output "azure_sql_pass" {
  value = "${azurerm_sql_server.azure_sqlserver.administrator_login_password}"
}

output "azure_sql_db_name" {
  value = "${azurerm_sql_database.azure_sqlserver_database.name}"
}

output "azure_sql_fw_rule_name" {
  value = "${azurerm_sql_firewall_rule.azure_sqlserver_firewall_rule.name}"
}

output "azure_sql_fw_start_ip" {
  value = "${azurerm_sql_firewall_rule.azure_sqlserver_firewall_rule.start_ip_address}"
}

output "azure_sql_fw_rule_end_ip" {
  value = "${azurerm_sql_firewall_rule.azure_sqlserver_firewall_rule.end_ip_address}"
}

output "azure_sql_vnet_rule_name" {
  value = "${azurerm_sql_virtual_network_rule.azure_sql_vnet_rule.name}"
}

output "azure_sql_vnet_rule_subnet_id" {
  value = "${azurerm_sql_virtual_network_rule.azure_sql_vnet_rule.subnet_id}"
}