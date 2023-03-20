resource "netbox_site" "site" {
  count  = length(var.site)
  name   = lookup(var.site[count.index], "name")
  slug   = lookup(var.site[count.index], "slug")
  status = lookup(var.site[count.index], "status")
}