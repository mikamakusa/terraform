output "custom_field_id" {
  value = netbox_custom_field.custom_field.*.id
}