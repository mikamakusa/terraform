resource "aws_rds_global_cluster" "global_cluster" {
  count                     = length(var.global_cluster)
  global_cluster_identifier = lookup(var.global_cluster[count.index], "global_cluster_identifier")
  database_name             = lookup(var.global_cluster[count.index], "database_name")
  deletion_protection       = lookup(var.global_cluster[count.index], "deletion_protection")
  engine                    = lookup(var.global_cluster[count.index], "engine")
  engine_version            = lookup(var.global_cluster[count.index], "engine_version")
  storage_encrypted         = lookup(var.global_cluster[count.index], "storage_encrypted")
}