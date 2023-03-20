resource "netbox_device_type" "device_type" {
  count           = length(var.device_type)
  model           = lookup(var.device_type[count.index], "model")
  slug            = lower(lookup(var.device_type[count.index], "model"))
  part_number     = lookup(var.device_type[count.index], "model")
  manufacturer_id = element(var.manufacturer, lookup(var.device_type[count.index], "manufacturer_id"))
  u_height        = lookup(var.device_type[count.index], "u_height")
}