output "id" {
  value = google_secret_manager_secret.secret.*.id
}

output "name" {
  value = google_secret_manager_secret.secret.*.name
}

output "create_time" {
  value = google_secret_manager_secret.secret.*.create_time
}
