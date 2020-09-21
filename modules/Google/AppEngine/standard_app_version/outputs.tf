output "id" {
  value = google_app_engine_standard_app_version.standard_app_version.*.id
}

output "name" {
  value = google_app_engine_standard_app_version.standard_app_version.*.name
}
