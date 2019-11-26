output "firewall_id" {
  value = cloudstack_firewall.firewall.*.id
}