output "id" {
  value = google_sql_database.database.*.id
}

output "self_link" {
  value = google_sql_database.database.*.self_link
}