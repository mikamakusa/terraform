resource "netbox_site_group" "site_group" {
  count       = length(var.site_group)
  name        = lookup(var.site_group[count.index], "name")
  description = lookup(var.site_group[count.index], "description", null)
  parent_id   = element(netbox_site_group.site_group.*.id, lookup(var.site_group[count.index], "parent_id", null))
}