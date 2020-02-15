resource "aws_elasticache_replication_group" "replication_group" {
  count                         = length(var.replication_group)
  replication_group_description = lookup(var.replication_group[count.index], "replication_group_description")
  replication_group_id          = lookup(var.replication_group[count.index], "replication_group_id")
  node_type                     = lookup(var.replication_group[count.index], "node_type", null)
  port                          = lookup(var.replication_group[count.index], "port", null)
  parameter_group_name          = element(var.parameter_group_name, lookup(var.replication_group[count.index], "parameter_group_name"))
  automatic_failover_enabled    = lookup(var.replication_group[count.index], "automatic_failover_enabled", true)
  engine                        = lookup(var.replication_group[count.index], "engine", null)
  engine_version                = lookup(var.replication_group[count.index], "engine_version", null)
  at_rest_encryption_enabled    = lookup(var.replication_group[count.index], "at_rest_encryption_enabled", false)
  transit_encryption_enabled    = lookup(var.replication_group[count.index], "transit_encryption_enabled", true)
  auth_token                    = lookup(var.replication_group[count.index], "auth_token")
  subnet_group_name             = element(var.subnet_group_name, lookup(var.replication_group[count.index], "subnet_group_id"))
  security_group_ids            = [element(var.security_group_id, lookup(var.replication_group[count.index], "security_group_id"))]
  maintenance_window            = lookup(var.replication_group[count.index], "maintenance_window", null)
  snapshot_name                 = lookup(var.replication_group[count.index], "snapshot_name", null)
  snapshot_window               = lookup(var.replication_group[count.index], "snapshot_window")
  apply_immediately             = lookup(var.replication_group[count.index], "apply_immediately", false)

  dynamic "cluster_mode" {
    for_each = lookup(var.replication_group[count.index], "cluster_mode")
    content {
      replicas_per_node_group = lookup(cluster_mode.value, "replicas_per_node_group")
      num_node_groups         = lookup(cluster_mode.value, "num_node_groups")
    }
  }
}