output "device_role_id" {
  value = netbox_device_role.device_role.*.id
}