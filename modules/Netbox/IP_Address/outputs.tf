output "ip_address_id" {
  value = netbox_ip_address.ip_address.*.id
}