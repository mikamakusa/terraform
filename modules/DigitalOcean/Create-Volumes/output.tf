output "volume_id" {
  value = digitalocean_volume.do_volume.*.id
}

output "volume_urn" {
  value = digitalocean_volume.do_volume.*.urn
}

output "volume_filesystem_type" {
  value = digitalocean_volume.do_volume.*.filesystem_type
}

output "volume_filesystem_label" {
  value = digitalocean_volume.do_volume.*.filesystem_label
}

output "volume_attachment_id" {
  value = digitalocean_volume_attachment.volume_attachement.*.id
}

output "volume_snapshot_id" {
  value = digitalocean_volume_snapshot.volume_snapshot.*.id
}

output "volume_snapshot_created_at" {
  value = digitalocean_volume_snapshot.volume_snapshot.*.created_at
}

output "volume_snapshot_min_disk_size" {
  value =  digitalocean_volume_snapshot.volume_snapshot.*.min_disk_size
}

output "volume_snapshot_regions" {
  value = digitalocean_volume_snapshot.volume_snapshot.*.regions
}

output "volume_snapshot_size" {
  value = digitalocean_volume_snapshot.volume_snapshot.*.size
}