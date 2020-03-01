resource "azurerm_resource_group" "resource_group" {
  count    = length(var.resource_group)
  location = lookup(var.resource_group[count.index], "location")
  name     = lookup(var.resource_group[count.index], "name")
  tags = var.tags
}