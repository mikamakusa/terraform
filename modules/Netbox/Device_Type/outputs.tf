output "device_type_id" {
  value = netbox_device_type.device_type.*.id
}