resource "azurerm_disk_encryption_set" "disk_encryption_set" {
  count               = length(var.disk_encryption_set)
  name                = lookup(var.disk_encryption_set[count.index], "name")
  resource_group_name = element(var.resource_group_name, lookup(var.disk_encryption_set[count.index], "resource_group_id"))
  location            = element(var.location, lookup(var.disk_encryption_set[count.index], "location_id"))
  key_vault_key_id    = element(var.key_vault_key_id, lookup(var.disk_encryption_set[count.index], "key_vault_key_id"))
  tags                = var.tags

  dynamic "identity" {
    for_each = lookup(var.disk_encryption_set[count.index], "identity")
    content {
      type = lookup(identity.value, "type")
    }
  }
}