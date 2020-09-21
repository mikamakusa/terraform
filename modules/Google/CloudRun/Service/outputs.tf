output "name" {
  value = google_cloud_run_service.service.*.name
}

output "location" {
  value = google_cloud_run_service.service.*.location
}
