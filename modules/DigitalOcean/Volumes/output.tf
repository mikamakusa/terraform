output "do_volume_id" {
  value = "${digitalocean_volume.do_volume.id}"
}

output "do_volume_name" {
  value = "${digitalocean_volume.do_volume.name}"
}

output "do_volume_region" {
  value = "${digitalocean_volume.do_volume.region}"
}

output "do_volume_size" {
  value = "${digitalocean_volume.do_volume.size}"
}