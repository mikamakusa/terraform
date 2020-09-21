output "id" {
  value = google_compute_attached_disk.attached_disk.*.id
}
