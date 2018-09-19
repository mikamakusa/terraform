resource "brightbox_database_server" "bbx_database_server" {
  count               = "${length(var.databases)}"
  name                = "${lookup(var.databases[count.index],"name")}"
  description         = "${lookup(var.databases[count.index],"description")? 1 : 0}"
  database_engine     = "${lookup(var.databases[count.index],"db_engine")? 1 : 0}"
  database_version    = "${lookup(var.databases[count.index],"db_version")? 1 : 0}"
  database_type       = "${lookup(var.databases[count.index],"db_type")? 1 : 0}"
  maintenance_hour    = "${lookup(var.databases[count.index],"maintenance_hour")? 1 : 0}"
  maintenance_weekday = "${lookup(var.databases[count.index],"maintenance_weekday")? 1 : 0}"
  allow_access        = ["${element(var.allow_access,lookup(var.databases[count.index],"server"))}"]
  snapshot            = "${lookup(var.databases[count.index],"snapshot")? 1 : 0}"
  zone                = "${lookup(var.databases[count.index],"zone")? 1 : 0}"
}
