resource "aws_docdb_cluster_snapshot" "snapshot" {
  count                          = length(var.snapshot)
  db_cluster_identifier          = element(var.cluster_id, lookup(var.snapshot[count.index], "cluster_id"))
  db_cluster_snapshot_identifier = lookup(var.snapshot[count.index], "db_cluster_snapshot_identifier")
}