resource "azurerm_container_registry" "registry" {
  count                    = length(var.registry)
  name                     = lookup(var.registry[count.index], "name")
  location                 = lookup(var.registry[count.index], "resource_group_id") == null ? var.resource_group_location : element(var.resource_group_location, lookup(var.registry[count.index], "resource_group_id"))
  resource_group_name      = lookup(var.registry[count.index], "resource_group_id") == null ? var.resource_group_name : element(var.resource_group_name, lookup(var.registry[count.index], "resource_group_id"))
  sku                      = lookup(var.registry[count.index], "sku")
  admin_enabled            = lookup(var.registry[count.index], "admin_enabled")
  storage_account_id       = lookup(var.registry[count.index], "storage_account_id")
  georeplication_locations = [lookup(var.registry[count.index], "georeplication_locations")]

  dynamic "network_rule_set" {
    for_each = [for i in lookup(var.registry[count.index], "network_rule_set") : {
      ip_rule         = lookup(i, "ip_rule", null)
      virtual_network = lookup(i, "virtual_network", null)
    }]
    content {
      default_action = lookup(network_rule_set.value, "default_action")
      dynamic "ip_rule" {
        for_each = network_rule_set.value.ip_rule == null ? [] : [for i in network_rule_set.value.ip_rule : {
          action   = i.action
          ip_range = i.ip_range
        }]
        content {
          action   = ip_rule.value.action
          ip_range = ip_rule.value.ip_range
        }
      }
      dynamic "virtual_network" {
        for_each = network_rule_set.value.virtual_network == null ? [] : [for i in network_rule_set.value.virtual_network : {
          action    = i.action
          subnet_id = i.subnet_id
        }]
        content {
          action    = virtual_network.value.action
          subnet_id = virtual_network.value.subnet_id
        }
      }
    }
  }
  dynamic "tags" {
    for_each = lookup(var.registry[count.index], "tags")
    content {
      variables = tags.value
    }
  }
}