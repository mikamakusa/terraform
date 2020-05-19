output "id" {
  value = google_firebase_project.firebase_project.*.id
}

output "project" {
  value = google_firebase_project.firebase_project.*.project
}
