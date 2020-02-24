resource "azurerm_mysql_configuration" "configuration" {
  count               = length(var.configuration)
  name                = lookup(var.configuration[count.index], "name")
  resource_group_name = lookup(var.configuration[count.index], "resource_group_id") == "" ? var.resource_group_name : element(var.resource_group_name, lookup(var.configuration[count.index], "resource_group_id"))
  server_name         = lookup(var.configuration[count.index], "mysql_server_id") == "" ? var.mysql_server_name : element(var.mysql_server_name, lookup(var.configuration[count.index], "mysql_server_id"))
  value               = lookup(var.configuration[count.index], "value")
}
