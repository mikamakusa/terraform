resource "netbox_tenant" "tenant" {
  count = length(var.tenant)
  name  = lookup(var.tenant[count.index], "name")
}

resource "netbox_site" "site" {
  count  = length(var.site)
  name   = lookup(var.site[count.index], "name")
  slug   = lookup(var.site[count.index], "slug")
  status = lookup(var.site[count.index], "status")
}

resource "netbox_location" "location" {
  count         = length(var.location)
  name          = lookup(var.location[count.index], "name")
  custom_fields = lookup(var.location[count.index], "custom_fields")
  site_id       = element(netbox_site.site.*.id, lookup(var.location[count.index], "site_id"))
  slug          = lookup(var.location[count.index], "slug")
  tags          = lookup(var.location[count.index], "tags")
  tenant_id     = element(netbox_tenant.tenant.*.id, lookup(var.location[count.index], "tenant_id"))
}