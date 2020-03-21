resource "google_sql_database" "google_sql_db" {
  provider  = "google-beta"
  count     = "${length(var.google_sql_db)}"
  instance  = "${element(google_sql_database_instance.google_sql_db_instance.*.name,lookup(var.google_sql_db[count.index],"instance_name"))}"
  project   = "${element(google_sql_database_instance.google_sql_db_instance.*.project,lookup(var.google_sql_db[count.index],"project_id"))}"
  name      = "${lookup(var.google_sql_db[count.index],"name")}"
  charset   = "${lookup(var.google_sql_db[count.index],"charset")}"
  collation = "${lookup(var.google_sql_db[count.index],"collation")}"
}

resource "google_sql_user" "google_sql_user" {
  provider = "google-beta"
  count    = "${length(var.google_sql_user)}"
  instance = "${element(google_sql_database_instance.google_sql_db_instance.*.name,lookup(var.google_sql_user[count.index],"instance_name"))}"
  project  = "${element(google_sql_database_instance.google_sql_db_instance.*.project,lookup(var.google_sql_user[count.index],"project_id"))}"
  name     = "${lookup(var.google_sql_user[count.index],"name")}"
  password = "${lookup(var.google_sql_user[count.index],"password")}"
  host     = "${lookup(var.google_sql_user[count.index],"host")}"
}
