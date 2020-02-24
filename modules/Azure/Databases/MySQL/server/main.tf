resource "azurerm_mysql_server" "server" {
  count                        = length(var.server)
  administrator_login          = lookup(var.server[count.index], "administrator_login")
  administrator_login_password = lookup(var.server[count.index], "administrator_password")
  location                     = lookup(var.server[count.index], "location")
  name                         = lookup(var.server[count.index], "name")
  resource_group_name          = lookup(var.server[count.index], "resource_group_id") == "" ? var.resource_group_name : element(var.resource_group_name, lookup(var.server[count.index], "resource_group_id"))
  ssl_enforcement              = lookup(var.server[count.index], "ssl_enforcement")
  version                      = lookup(var.server[count.index], "version")

  dynamic "sku" {
    for_each = lookup(var.server[count.index], "sku")
    content {
      capacity = lookup(sku.value, "capacity")
      family   = lookup(sku.value, "family")
      name     = lookup(sku.value, "name")
      tier     = lookup(sku.value, "tier")
    }
  }

  dynamic "storage_profile" {
    for_each = lookup(var.server[count.index], "storage_profile")
    content {
      storage_mb            = lookup(storage_profile.value, "storage_mb")
      backup_retention_days = lookup(storage_profile.value, "backup_retention_days")
      geo_redundant_backup  = lookup(storage_profile.value, "geo_redundant_backup")
    }
  }
}
