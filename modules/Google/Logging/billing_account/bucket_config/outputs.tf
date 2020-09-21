output "id" {
  value = google_logging_billing_account_bucket_config.bucket_config.*.id
}

output "name" {
  value = google_logging_billing_account_bucket_config.bucket_config.*.name
}

output "lifecycle_state" {
  value = google_logging_billing_account_bucket_config.bucket_config.*.lifecycle_state
}
