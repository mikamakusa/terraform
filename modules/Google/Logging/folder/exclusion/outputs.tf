output "id" {
  value = google_logging_folder_exclusion.exclusion.*.id
}
