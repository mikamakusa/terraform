resource "netbox_ipam_role" "ipam_role" {
  count       = length(var.ipam_role)
  name        = lookup(var.ipam_role[count.index], "name")
  description = lookup(var.ipam_role[count.index], "description", null)
  slug        = lookup(var.ipam_role[count.index], "slug", null)
  weight      = tonumber(lookup(var.ipam_role[count.index], "weight", null))
}