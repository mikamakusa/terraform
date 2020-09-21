output "id" {
  value = google_compute_address.address.*.id
}

output "self_link" {
  value = google_compute_address.address.*.self_link
}
