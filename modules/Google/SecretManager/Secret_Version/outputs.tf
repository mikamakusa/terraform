output "id" {
  value = google_secret_manager_secret_version.secret_version.*.id
}

output "name" {
  value = google_secret_manager_secret_version.secret_version.*.name
}

output "create_time" {
  value = google_secret_manager_secret_version.secret_version.*.create_time
}

output "destroy_time" {
  value = google_secret_manager_secret_version.secret_version.*.destroy_time
}
