resource "google_sql_database" "database" {
  count     = length(var.database)
  provider  = "google-beta"
  instance  = element(var.instance_name, lookup(var.database[count.index], "instance_id"))
  name      = lookup(var.database[count.index], "name")
  charset   = lookup(var.database[count.index], "charset", null)
  collation = lookup(var.database[count.index], "collation", null)
  project   = var.project
}