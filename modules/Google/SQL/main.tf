resource "google_sql_database_instance" "google_sql_db_instance" {
  provider             = "google-beta"
  count                = "${length(var.google_db_instance)}"
  name                 = "${lookup(var.google_db_instance[count.index],"name")}"
  database_version     = "${lookup(var.google_db_instance[count.index],"version")}"
  master_instance_name = "${lookup(var.google_db_instance[count.index],"instance_name")}"
  project              = "${lookup(var.google_db_instance[count.index],"project")}"

  replica_configuration {
    ca_certificate     = "${file(${lookup(var.google_db_instance[count.index],"ca_cert")})}"
    client_certificate = "${file(${lookup(var.google_db_instance[count.index],"client_cert")})}"
    client_key         = "${file(${lookup(var.google_db_instance[count.index],"client_key")})}"
    username           = "${lookup(var.google_db_instance[count.index],"username")}"
    password           = "${lookup(var.google_db_instance[count.index],"password")}"
  }

  "settings" {
    tier = "${lookup(var.google_db_instance[count.index],"tier")}"
  }
}

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
