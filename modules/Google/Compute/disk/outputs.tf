output "id" {
  value = google_compute_disk.disk.*.id
}

output "source_image_id" {
  value = google_compute_disk.disk.*.source_image_id
}

output "self_link" {
  value = google_compute_disk.disk.*.self_link
}
