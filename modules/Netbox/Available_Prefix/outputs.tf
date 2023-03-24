output "available_prefix_id" {
  value = netbox_available_prefix.available_prefix.*.id
}