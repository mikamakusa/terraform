resource "azurerm_key_vault" "key_vault" {
  count                           = length(var.key_vault)
  location                        = element(var.location, lookup(var.key_vault[count.index], "location_id"))
  name                            = lookup(var.key_vault[count.index], "name")
  resource_group_name             = element(var.resource_group_name, lookup(var.key_vault[count.index], "resource_group_id"))
  tenant_id                       = var.tenant_id
  enabled_for_deployment          = lookup(var.key_vault[count.index], "enabled_for_deployment", true)
  enabled_for_disk_encryption     = lookup(var.key_vault[count.index], "enabled_for_disk_encryption", true)
  enabled_for_template_deployment = lookup(var.key_vault[count.index], "enabled_for_template_deployment", true)
  sku_name                        = lookup(var.key_vault[count.index], "sku_name")

  dynamic "access_policy" {
    for_each = lookup(var.key_vault[count.index], "access_policy")
    content {
      object_id               = var.object_id
      tenant_id               = var.tenant_id
      certificate_permissions = [lookup(access_policy.value, "certificate_permission")]
      application_id          = var.application_id
      storage_permissions     = [lookup(access_policy.value, "storage_permissions")]
      secret_permissions      = [lookup(access_policy.value, "secret_permissions")]
    }
  }

  dynamic "network_acls" {
    for_each = lookup(var.key_vault[count.index], "network_acls")
    content {
      bypass                     = lookup(network_acls.value, "bypass", "AzureServices")
      default_action             = lookup(network_acls.value, "default_action", "Allow")
      ip_rules                   = [lookup(network_acls.value, "ip_rules")]
      virtual_network_subnet_ids = [element(var.subnet_ids, lookup(network_acls.value, "virtual_network_subnet_ids"))]
    }
  }
}