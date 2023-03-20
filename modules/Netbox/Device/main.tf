resource "netbox_device" "device" {
  count          = length(var.device)
  name           = lookup(var.device[count.index], "name")
  device_type_id = element(var.device_type, lookup(var.device[count.index], "device_type_id"))
  role_id        = element(var.role, lookup(var.device[count.index], "role_id"))
  site_id        = element(var.site, lookup(var.device[count.index], "site_id"))
}