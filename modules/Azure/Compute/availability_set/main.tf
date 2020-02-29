resource "azurerm_availability_set" "availability_set" {
  count                        = length(var.availability_set)
  location                     = element(var.location, lookup(var.availability_set[count.index], "location_id"))
  name                         = lookup(var.availability_set[count.index], "name")
  resource_group_name          = element(var.resource_group_name, lookup(var.availability_set[count.index], "resource_group_id"))
  platform_fault_domain_count  = lookup(var.availability_set[count.index], "platform_fault_domain_count")
  platform_update_domain_count = lookup(var.availability_set[count.index], "platform_update_domain_count")
  proximity_placement_group_id = element(var.proximity_placement_group_id, lookup(var.availability_set[count.index], "proximity_placement_group_id"))
  managed                      = lookup(var.availability_set[count.index], "managed")
  tags                         = var.tags
}