resource "azurerm_dedicated_host_group" "dedicated_host_group" {
  count                       = length(var.dedicated_host_group)
  name                        = lookup(var.dedicated_host_group[count.index], "name")
  resource_group_name         = element(var.resource_group_name, lookup(var.dedicated_host_group[count.index], "resource_group_id"))
  location                    = element(var.location, lookup(var.dedicated_host_group[count.index], "location_id"))
  platform_fault_domain_count = lookup(var.dedicated_host_group[count.index], "platform_fault_domain_count")
  zones                       = [lookup(var.dedicated_host_group[count.index], "zones")]
  tags                        = var.tags
}