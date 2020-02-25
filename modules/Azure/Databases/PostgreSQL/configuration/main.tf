resource "azurerm_postgresql_configuration" "configuration" {
  count               = length(var.configuration)
  name                = lookup(var.configuration[count.index], "name")
  resource_group_name = lookup(var.configuration[count.index], "server_id") == "" ? var.pgsql_resource_group_name : element(var.pgsql_resource_group_name, lookup(var.configuration[count.index], "server_id"))
  server_name         = lookup(var.configuration[count.index], "server_id") == "" ? var.pgsql_server_name : element(var.pgsql_server_name, lookup(var.configuration[count.index], "server_id"))
  value               = lookup(var.configuration[count.index], "value")
}