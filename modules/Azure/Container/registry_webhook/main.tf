resource "azurerm_container_registry_webhook" "registry_webhook" {
  count               = length(var.registry_webhook)
  actions             = [lookup(var.registry_webhook[count.index], "actions")]
  name                = lookup(var.registry_webhook[count.index], "name")
  registry_name       = lookup(var.registry_webhook[count.index], "registry_id") == null ? var.registry_name : element(var.registry_name, lookup(var.registry_webhook[count.index], "registry_id"))
  resource_group_name = lookup(var.registry_webhook[count.index], "resource_group_id") == null ? var.resource_group_name : element(var.resource_group_name, lookup(var.registry_webhook[count.index], "resource_group_id"))
  location            = lookup(var.registry_webhook[count.index], "resource_group_id") == null ? var.resource_group_location : element(var.resource_group_location, lookup(var.registry_webhook[count.index], "resource_group_id"))
  service_uri         = lookup(var.registry_webhook[count.index], "service_uri")
  status              = lookup(var.registry_webhook[count.index], "status")
  scope               = lookup(var.registry_webhook[count.index], "scope")

  dynamic "custom_headers" {
    for_each = lookup(var.registry_webhook[count.index], "custom_headers")
    content {
      variables = custom_headers.value
    }
  }
}