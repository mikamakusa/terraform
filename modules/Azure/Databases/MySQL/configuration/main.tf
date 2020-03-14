resource "azurerm_mysql_configuration" "configuration" {
  count               = length(var.configuration)
  name                = lookup(var.configuration[count.index], "name")
  resource_group_name = lookup(var.configuration[count.index], "resource_group_name")
  server_name         = lookup(var.configuration[count.index], "server_name")
  value               = lookup(var.configuration[count.index], "value")
  
}
