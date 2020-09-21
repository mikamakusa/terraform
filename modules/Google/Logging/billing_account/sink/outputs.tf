output "id" {
  value = google_logging_billing_account_sink.sink.*.id
}

output "writer_identity" {
  value = google_logging_billing_account_sink.sink.*.writer_identity
}
