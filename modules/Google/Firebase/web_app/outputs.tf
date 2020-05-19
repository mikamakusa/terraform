output "id" {
  value = google_firebase_web_app.web_app.*.id
}

output "app_id" {
  value = google_firebase_web_app.web_app.*.app_id
}

output "project" {
  value = google_firebase_web_app.web_app.*.project
}

output "name" {
  value = google_firebase_web_app.web_app.*.name
}

output "display_name" {
  value = google_firebase_web_app.web_app.*.display_name
}
