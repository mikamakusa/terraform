output "self_link" {
  value = google_sql_database_instance.instance.*.self_link
}

output "connection_name" {
  value = google_sql_database_instance.instance.*.connection_name
}

output "service_account_email_address" {
  value = google_sql_database_instance.instance.*.service_account_email_address
}