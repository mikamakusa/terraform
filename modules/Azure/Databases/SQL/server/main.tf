resource "azurerm_sql_server" "server" {
  count                        = length(var.server)
  administrator_login          = lookup(var.server[count.index], "admin_login")
  administrator_login_password = lookup(var.server[count.index], "admin_pass")
  location                     = lookup(var.server[count.index], "location_id") == [] ? var.sql_location : element(var.sql_location, lookup(var.server[count.index], "location_id"))
  name                         = lookup(var.server[count.index], "name")
  resource_group_name          = lookup(var.server[count.index], "resource_group_id") == [] ? var.sql_resource_group_name : element(var.sql_resource_group_name, lookup(var.server[count.index], "resource_group_id"))
  version                      = lookup(var.server[count.index], "version")
  tags                         = [var.tags]

  dynamic "sku" {
    for_each = lookup(var.server[count.index], "sku")
    content {
      name     = lookup(sku.value, "name")
      capacity = lookup(sku.value, "capacity")
      tier     = lookup(sku.value, "tier")
      family   = lookup(sku.value, "family")
    }
  }

  dynamic "per_database_settings" {
    for_each = lookup(var.server[count.index], "per_database_settings")
    content {
      min_capacity = lookup(per_database_settings.value, "min_capacity")
      max_capacity = lookup(per_database_settings.value, "max_capacity")
    }
  }
}