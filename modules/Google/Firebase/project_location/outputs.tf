output "id" {
  value = google_firebase_project_location.project_location.*.id
}

output "project" {
  value = google_firebase_project_location.project_location.*.project
}
