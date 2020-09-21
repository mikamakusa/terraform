output "id" {
  value = google_compute_autoscaler.autoscaler.*.id
}

output "creation_timestamp" {
  value = google_compute_autoscaler.autoscaler.*.creation_timestamp
}

output "self_link" {
  value = google_compute_autoscaler.autoscaler.*.self_link
}
