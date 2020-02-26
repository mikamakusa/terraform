resource "azurerm_sql_active_directory_administrator" "active_directory_administrator" {
  count               = length(var.active_directory_administrator)
  login               = lookup(var.active_directory_administrator[count.index], "login")
  object_id           = var.object_id
  resource_group_name = element(var.resource_group_name, lookup(var.active_directory_administrator[count.index], "resource_group_id"))
  server_name         = element(var.server_name, lookup(var.active_directory_administrator[count.index], "server_id"))
  tenant_id           = var.tenant_id
}