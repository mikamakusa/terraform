output "do_domain_name" {
  value = "${digitalocean_domain.do_domain.name}"
}

output "do_domain_id" {
  value = "${digitalocean_domain.do_domain.id}"
}

output "do_domain_ip" {
  value = "${digitalocean_domain.do_domain.ip_address}"
}