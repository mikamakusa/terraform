resource "netbox_device" "device" {
  count          = length(var.device)
  name           = lookup(var.device[count.index], "name")
  device_type_id = element(var.device_type, lookup(var.device[count.index], "device_type_id"))
  role_id        = element(var.role_id, lookup(var.device[count.index], "role_id"))
  site_id        = element(var.site_id, lookup(var.device[count.index], "site_id"))
  cluster_id     = element(var.cluster_id, lookup(var.device[count.index], "cluster_id"))
  location_id    = element(var.location_id, lookup(var.device[count.index], "location_id"))
  status         = lookup(var.device[count.index], "status", "active")
}