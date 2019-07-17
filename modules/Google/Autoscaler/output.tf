output "gcp_as_name" {
  value = google_compute_autoscaler.gcp_autoscaler.*.name
}

output "gcp_as_self_link" {
  value = google_compute_autoscaler.gcp_autoscaler.*.self_link
}