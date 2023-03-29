resource "netbox_rack" "rack" {
  count          = length(var.rack)
  name           = lookup(var.rack[count.index], "name")
  site_id        = element(var.site_id, lookup(var.rack[count.index], "site_id"))
  status         = lookup(var.rack[count.index], "status", "active")
  u_height       = lookup(var.rack[count.index], "u_height")
  width          = lookup(var.rack[count.index], "width")
  desc_units     = false
  location_id    = lookup(var.rack[count.index], "location_id")
  max_weigth     = lookup(var.rack[count.index], "max_weigth", 0)
  mounting_depth = lookup(var.rack[count.index], "mounting_depth", 0)
  outer_depth    = lookup(var.rack[count.index], "outer_depth", 0)
  outer_width    = lookup(var.rack[count.index], "outer_width", 0)
  role_id        = element(var.role_id, lookup(var.rack[count.index], "role_id"))
  tenant_id      = element(var.tenant_id, lookup(var.rack[count.index], "tenant_id"))
  weigth         = lookup(var.rack[count.index], "weigth", 19)
}