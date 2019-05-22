resource "google_bigtable_instance" "ggl_bt_instance" {
  count         = "${length(var.bt_instance)}"
  name          = "${lookup(var.bt_instance[count.index],"name")}"
  zone          = "${var.zone}"
  num_nodes     = "${lookup(var.bt_instance[count.index],"num_nodes")? 1:0}"
  cluster_id    = "${lookup(var.bt_instance[count.index],"cluster_id")}"
  project       = "${var.project}"
  display_name  = "${lookup(var.bt_instance[count.index],"display_name") ? 1:0}"
  storage_type  = "${lookup(var.bt_instance[count.index],"storage_type") ? 1:0}"
  instance_type = "${lookup(var.bt_instance[count.index],"instance_type") ? 1:0}"
  "cluster" {
    cluster_id = ""
    zone = ""
  }
}

resource "google_bigtable_table" "ggl_bt_table" {
  count         = "${length(var.bt_table)}"
  instance_name = "${element(google_bigtable_instance.ggl_bt_instance.*.name,lookup(var.bt_table[count.index],"instance_name"))}"
  name          = "${lookup(var.bt_table[count.index],"name")}"
  split_keys    = ["${lookup(var.bt_table[count.index],"split")? 1:0}"]
  project       = "${var.project ? 1 : 0}"
}
