output "sql_db_instance_name" {
  value = "${google_sql_database_instance.google_sql_db_instance.name}"
}

output "sql_db_instance_id" {
  value = "${google_sql_database_instance.google_sql_db_instance.id}"
}

output "sql_db_instance_ip" {
  value = "${google_sql_database_instance.google_sql_db_instance.ip_address}"
}

output "sql_db_name" {
  value = "${google_sql_database.google_sql_db.name}"
}

output "sql_db_id" {
  value = "${google_sql_database.google_sql_db.id}"
}