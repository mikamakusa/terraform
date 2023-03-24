resource "netbox_available_prefix" "available_prefix" {
  count            = length(var.available_prefix)
  parent_prefix_id = element(var.prefix_id, lookup(var.available_prefix[count.index], "parent_prefix_id"))
  prefix_length    = lookup(var.available_prefix[count.index], "prefix_length")
  status           = lookup(var.available_prefix[count.index], "status")
}