resource "azurerm_mysql_database" "database" {
  count               = length(var.database)
  charset             = lookup(var.database[count.index], "charset")
  collation           = lookup(var.database[count.index], "collation")
  name                = lookup(var.database[count.index], "database_name")
  resource_group_name = lookup(var.database[count.index], "server_id") == "" ? var.mysql_resource_group_name : element(var.mysql_resource_group_name, lookup(var.database[count.index], "server_id"))
  server_name         = lookup(var.database[count.index], "server_id") == "" ? var.mysql_server_name : element(var.mysql_server_name, lookup(var.database[count.index], "server_id"))
}