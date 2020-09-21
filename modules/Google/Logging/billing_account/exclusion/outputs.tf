output "id" {
  value = google_logging_billing_account_exclusion.exclusion.*.id
}
