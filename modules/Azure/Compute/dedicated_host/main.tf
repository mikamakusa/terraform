resource "azurerm_dedicated_host" "dedicated_host" {
  count                   = length(var.dedicated_hosts)
  name                    = lookup(var.dedicated_hosts[count.index], "name")
  location                = element(var.location, lookup(var.dedicated_hosts[count.index], "location_id"))
  dedicated_host_group_id = element(var.dedicated_host_group_id, lookup(var.dedicated_hosts[count.index], "dedicated_host_group_id"))
  sku_name                = lookup(var.dedicated_hosts[count.index], "sku_name")
  platform_fault_domain   = lookup(var.dedicated_hosts[count.index], "platform_fault_domain")
  auto_replace_on_failure = lookup(var.dedicated_hosts[count.index], "auto_replace_on_failure", true)
  license_type            = lookup(var.dedicated_hosts[count.index], "license_type")
  tags                    = var.tags
}