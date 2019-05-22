resource "google_bigquery_dataset" "ggl_bq_dset" {
  count                       = "${length(var.ggl_bq_dset)}"
  dataset_id                  = "${lookup(var.ggl_bq_dset[count.index],"dataset_id")}"
  friendly_name               = "${lookup(var.ggl_bq_dset[count.index],"friendly_name")}"
  description                 = "${lookup(var.ggl_bq_dset[count.index],"desc")}"
  location                    = "${lookup(var.ggl_bq_dset[count.index],"location")}"
  default_table_expiration_ms = "${lookup(var.ggl_bq_dset[count.index],"expiration_ms")}"
  labels                      = ["${var.labels}"]
}

resource "google_bigquery_table" "ggl_bq_table" {
  count           = "${ "${length(var.ggl_bq_table)}" == "0" ? "0" : "${length(var.ggl_bq_dset)}"}"
  dataset_id      = "${element(google_bigquery_dataset.ggl_bq_dset.*.id,lookup(var.ggl_bq_table[count.index],"dataset_id"))}"
  table_id        = "${lookup(var.ggl_bq_table[count.index],"table_id")}"
  project         = "${var.project}"
  description     = "${lookup(var.ggl_bq_table[count.index],"description")}"
  expiration_time = "${lookup(var.ggl_bq_table[count.index],"expiration_time")}"
  friendly_name   = "${lookup(var.ggl_bq_table[count.index],"friendly_name")}"
  schema          = "${file(lookup(var.ggl_bq_table[count.index],"schema"))}"

  time_partitioning = ["${var.time_part}"]

  view = ["${var.view}"]

  labels = ["${var.labels}"]
}
