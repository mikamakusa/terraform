output "available_ip_address_id" {
  value = netbox_available_ip_address.available_ip_address.*.id
}