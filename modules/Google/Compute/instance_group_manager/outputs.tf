output "id" {
  value = google_compute_instance_group_manager.group_manager.*.id
}

output "fingerprint" {
  value = google_compute_instance_group_manager.group_manager.*.fingerprint
}

output "instance_group" {
  value = google_compute_instance_group_manager.group_manager.*.instance_group
}

output "self_link" {
  value = google_compute_instance_group_manager.group_manager.*.self_link
}
