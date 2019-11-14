output "floating_ip_id" {
  value = digitalocean_floating_ip.floating_ip.*.id
}

output "floating_ip_value" {
  value = digitalocean_floating_ip.floating_ip.*.ip_address
}

output "floating_ip_urn" {
  value = digitalocean_floating_ip.floating_ip.*.urn
}