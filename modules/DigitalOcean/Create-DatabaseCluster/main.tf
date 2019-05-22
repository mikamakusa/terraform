resource "digitalocean_database_cluster" "do_db_cluster" {
  count      = "${length(var.db_cluster)}"
  name       = "${var.prefix}-${lookup(var.db_cluster[count.index],"name")}"
  node_count = "${lookup(var.db_cluster[count.index],"node_count")}"
  region     = "${var.region}"
  size       = "${lookup(var.db_cluster[count.index],"size")}"
  engine     = "${lookup(var.db_cluster[count.index],"engine")}"
  version    = "${lookup(var.db_cluster[count.index],"version")}"

  maintenance_window {
    day  = "${lookup(var.db_cluster[count.index],"day")}"
    hour = "${lookup(var.db_cluster[count.index],"hour")}"
  }
}
