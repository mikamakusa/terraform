output "ipaddress_id" {
  value = cloudstack_ipaddress.ipaddress.*.id
}

output "ipaddress_value" {
  value = cloudstack_ipaddress.ipaddress.*.ip_address
}