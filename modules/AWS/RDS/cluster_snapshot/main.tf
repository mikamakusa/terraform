resource "aws_db_cluster_snapshot" "cluster_snapshot" {
  count                          = length(var.cluster_snapshot)
  db_cluster_identifier          = element(var.db_cluster_identifier, lookup(var.cluster_snapshot[count.index], "cluster_id"))
  db_cluster_snapshot_identifier = lookup(var.cluster_snapshot[count.index], "db_cluster_snapshot_identifier")
  tags                           = var.tags
}