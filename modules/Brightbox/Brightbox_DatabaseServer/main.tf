resource "brightbox_database_server" "bbx_database_server" {
  count               = length(var.databases)
  name                = lookup(var.databases[count.index],"name", null)
  description         = lookup(var.databases[count.index],"description", null)
  database_engine     = lookup(var.databases[count.index],"db_engine", null)
  database_version    = lookup(var.databases[count.index],"db_version", null)
  database_type       = lookup(var.databases[count.index],"db_type", null)
  maintenance_hour    = lookup(var.databases[count.index],"maintenance_hour", null)
  maintenance_weekday = lookup(var.databases[count.index],"maintenance_weekday", null)
  allow_access        = [element(var.allow_access,lookup(var.databases[count.index],"server"))]
  snapshot            = lookup(var.databases[count.index],"snapshot", null)
  zone                = lookup(var.databases[count.index],"zone", null)
}
