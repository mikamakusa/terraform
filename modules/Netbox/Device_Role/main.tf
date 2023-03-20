resource "netbox_device_role" "device_role" {
  count     = length(var.device_role)
  color_hex = lookup(var.device_role[count.index], "color_hex")
  name      = lookup(var.device_role[count.index], "name")
}