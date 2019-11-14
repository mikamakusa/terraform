output "firewall_id" {
  value = digitalocean_firewall.do_firewall.*.id
}

output "firewall_name" {
  value = digitalocean_firewall.do_firewall.*.name
}

output "firewall_outbound_rule" {
  value = digitalocean_firewall.do_firewall.*.outbound_rule
}

output "firewall_inbound_rule" {
  value = digitalocean_firewall.do_firewall.*.inbound_rule
}

output firewall_tags {
  value = digitalocean_firewall.do_firewall.*.tags
}

output "firewall_droplet_ids" {
  value = digitalocean_firewall.do_firewall.*.droplet_ids
}

output firewall_status {
  value = digitalocean_firewall.do_firewall.*.status
}

output "firewall_created_at" {
  value = digitalocean_firewall.do_firewall.*.created_at
}

output "firewall_pending_changed" {
  value = digitalocean_firewall.do_firewall.*.pending_changes
}