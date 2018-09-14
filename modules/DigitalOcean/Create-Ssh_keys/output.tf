output "ssh_key_name" {
  value = "${digitalocean_ssh_key.do_ssh_keys.name}"
}

output "ssh_key_id" {
  value = "${digitalocean_ssh_key.do_ssh_keys.id}"
}