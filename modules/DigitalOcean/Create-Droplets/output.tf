output "droplet_id" {
  value = "${digitalocean_droplet.do_droplets.id}"
}

output "droplet_name" {
  value = "${digitalocean_droplet.do_droplets.name}"
}

output "droplet_image" {
  value = "${digitalocean_droplet.do_droplets.image}"
}

output "droplet_region" {
  value = "${digitalocean_droplet.do_droplets.region}"
}

output "droplet_ipv4" {
  value = "${digitalocean_droplet.do_droplets.ipv4_address}"
}