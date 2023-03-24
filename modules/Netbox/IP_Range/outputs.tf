output "ip_range_id" {
  value = netbox_ip_range.ip_range.*.id
}