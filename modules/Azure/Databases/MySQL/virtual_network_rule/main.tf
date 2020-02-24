resource "azurerm_mysql_virtual_network_rule" "virtual_network_rule" {
  count               = length(var.virtual_network_rule)
  name                = lookup(var.virtual_network_rule[count.index], "name")
  resource_group_name = lookup(var.virtual_network_rule[count.index], "server_id") == "" ? var.mysql_resource_group_name : element(var.mysql_resource_group_name, lookup(var.virtual_network_rule[count.index], "server_id"))
  server_name         = lookup(var.virtual_network_rule[count.index], "server_id") == "" ? var.mysql_server_name : element(var.mysql_server_name, lookup(var.virtual_network_rule[count.index], "id_server"))
  subnet_id           = lookup(var.virtual_network_rule[count.index], "server_id") == "" ? var.subnet_id : element(var.subnet_id, lookup(var.virtual_network_rule[count.index], "id_server"))
}