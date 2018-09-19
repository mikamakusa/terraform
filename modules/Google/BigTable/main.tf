resource "google_bigtable_instance" "ggl_bq_instance" {
  count = "${length(var.bq_instance)}"
  name = "${lookup(var.bq_instance[count.index],"name")}"
  zone = "${var.zone}"
  num_nodes = "${lookup(var.bq_instance[count.index],"num_nodes")? 1:0}"
  cluster_id = "${lookup(var.bq_instance[count.index],"cluster_id")}"
  project = "${var.project}"
  display_name = "${lookup(var.bq_instance[count.index],"display_name") ? 1:0}"
  storage_type = "${lookup(var.bq_instance[count.index],"storage_type") ? 1:0}"
  instance_type = "${lookup(var.bq_instance[count.index],"instance_type") ? 1:0}"
}