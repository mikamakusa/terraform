resource "netbox_device_interface" "device_interface" {
  count     = length(var.device_interface)
  name      = lookup(var.device_interface[count.index], "name")
  type      = lookup(var.device_interface[count.index], "type")
  device_id = element(var.device, lookup(var.device_interface[count.index], "device_id"))
}