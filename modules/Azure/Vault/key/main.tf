resource "azurerm_key_vault_key" "key" {
  count        = length(var.key)
  name         = lookup(var.key[count.index], "name")
  key_vault_id = element(var.key_vault_id, lookup(var.key[count.index], "key_vault_id"))
  key_opts     = [lookup(var.key[count.index], "key_opts")]
  key_type     = lookup(var.key[count.index], "key_type")
  key_size     = lookup(var.key[count.index], "key_size", null)
  curve        = lookup(var.key[count.index], "key_size") == null ? lookup(var.key[count.index], "curve") : null
  tags         = var.tags
}