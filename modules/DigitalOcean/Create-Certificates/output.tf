output "do_cert_id" {
  value = "${digitalocean_certificate.do_certificate.id}"
}

output "do_cert_name" {
  value = "${digitalocean_certificate.do_certificate.name}"
}

output "do_cert_chain" {
  value = "${digitalocean_certificate.do_certificate.certificate_chain}"
}

output "do_cert_leaf" {
  value = "${digitalocean_certificate.do_certificate.leaf_certificate}"
}

output "do_cert_priv_key" {
  value = "${digitalocean_certificate.do_certificate.private_key}"
}