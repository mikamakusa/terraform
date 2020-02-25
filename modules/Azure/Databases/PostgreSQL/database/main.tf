resource "azurerm_postgresql_database" "database" {
  count               = length(var.database)
  name                = lookup(var.database[count.index], "name")
  resource_group_name = lookup(var.database[count.index], "server_id") == "" ? var.pgsql_resource_group_name : element(var.pgsql_resource_group_name, lookup(var.database[count.index], "server_id"))
  charset             = lookup(var.database[count.index], "charset")
  collation           = lookup(var.database[count.index], "collation")
  server_name         = lookup(var.database[count.index], "server_id") == "" ? var.pgsql_server_name : element(var.pgsql_server_name, lookup(var.database[count.index], "server_id"))
}