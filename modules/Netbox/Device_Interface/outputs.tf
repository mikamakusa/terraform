output "device_interface_id" {
  value = netbox_device_interface.device_interface.*.id
}