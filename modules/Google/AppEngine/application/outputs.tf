output "id" {
  value = google_app_engine_application.application.*.id
}

output "name" {
  value = google_app_engine_application.application.*.name
}

output "app_id" {
  value = google_app_engine_application.application.*.app_id
}

output "url_dispatch_rule" {
  value = google_app_engine_application.application.*.url_dispatch_rule
}

output "code_bucket" {
  value = google_app_engine_application.application.*.code_bucket
}

output "default_hostname" {
  value = google_app_engine_application.application.*.default_hostname
}

output "default_bucket" {
  value = google_app_engine_application.application.*.default_bucket
}
