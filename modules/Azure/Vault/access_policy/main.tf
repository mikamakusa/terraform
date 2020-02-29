resource "azurerm_key_vault_access_policy" "access_policy" {
  count                   = length(var.access_policy)
  object_id               = var.object_id
  tenant_id               = var.tenant_id
  application_id          = var.application_id
  key_vault_id            = element(var.key_vault_id, lookup(var.access_policy[count.index], "key_vault_id"))
  key_permissions         = lookup(var.access_policy[count.index], "key_permissions")
  certificate_permissions = [lookup(var.access_policy[count.index], "certificate_permissions", null)]
  secret_permissions      = [lookup(var.access_policy[count.index], "secret_permissions", null)]
  storage_permissions     = [lookup(var.access_policy[count.index], "storage_permissions", null)]
}