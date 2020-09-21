output "id" {
  value = google_cloudfunctions_function.function.*.id
}

output "https_trigger_url" {
  value = google_cloudfunctions_function.function.*.https_trigger_url
}

output "source_repository" {
  value = google_cloudfunctions_function.function.*.source_repository.0.deployed_url
}
