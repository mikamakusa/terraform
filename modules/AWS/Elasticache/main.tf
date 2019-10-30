resource "aws_elasticache_security_group" "ElasticacheSecGroup" {
  count                = length(var.SecGroup)
  name                 = lookup(var.SecGroup[count.index], "name")
  security_group_names = [join("", data.terraform_remote_state.security_groups.*.id)]
}

resource "aws_elasticache_subnet_group" "ElasticacheSubnetGroup" {
  count      = length(var.SubnetGroup)
  name       = lookup(var.SubnetGroup[count.index], "name")
  subnet_ids = [join("", data.terraform_remote_state.vpc.outputs.private_subnets)]
}

resource "aws_elasticache_cluster" "elasticache" {
  count                        = length(var.elasticache)
  cluster_id                   = lookup(var.elasticache[count.index], "cluster_id")
  engine                       = lookup(var.elasticache[count.index], "engine")
  engine_version               = lookup(var.elasticache[count.index], "engine_version", null)
  maintenance_window           = lookup(var.elasticache[count.index], "maintenance_windows", null)
  port                         = lookup(var.elasticache[count.index], "port", null)
  subnet_group_name            = element(data.terraform_remote_state.vpc.outputs.private_subnets, 0)
  security_group_ids           = [join("", data.terraform_remote_state.security_groups.id)]
  snapshot_name                = lookup(var.elasticache[count.index], "snapshot_name", null)
  snapshot_retention_limit     = lookup(var.elasticache[count.index], "snapshot_retention_limit", null)
  az_mode                      = lookup(var.elasticache[count.index], "az_mode", null)
  preferred_availability_zones = [lookup(var.elasticache[count.index], "preferred_availability_zones") ? aws_elasticache_cluster.elasticache.engine : "memcached"]
}

resource "aws_elasticache_parameter_group" "ElasticacheParamGroup" {
  count  = "${"${length(var.elasticache)}" == "0" ? "0" : "${length(var.ParamGroup)}"}"
  family = lookup(var.ParamGroup[count.index], "family")
  name   = lookup(var.ParamGroup[count.index], "name")

  dynamic "parameter" {
    for_each = lookup(var.ParamGroup[count.index], "parameter")
    content {
      name  = lookup(parameter.value, "name", null)
      value = lookup(parameter.value, "value", null)
    }
  }
}

resource "aws_elasticache_replication_group" "ElasticacheReplicationGroup" {
  count                         = "${"${length(var.ParamGroup)}" == "0" ? "0" : "${length(var.RepGroup)}"}"
  replication_group_description = lookup(var.RepGroup[count.index], "replication_group_description")
  replication_group_id          = lookup(var.RepGroup[count.index], "replication_group_id")
  node_type                     = lookup(var.RepGroup[count.index], "node_type", null)
  port                          = lookup(var.RepGroup[count.index], "port", null)
  parameter_group_name          = element(aws_elasticache_parameter_group.ElasticacheParamGroup.*.name, lookup(var.RepGroup[count.index], "parameter_group_name"))
  automatic_failover_enabled    = lookup(var.RepGroup[count.index], "automatic_failover_enabled")
  engine                        = lookup(var.RepGroup[count.index], "engine", null)
  engine_version                = lookup(var.RepGroup[count.index], "engine_version")
  at_rest_encryption_enabled    = lookup(var.RepGroup[count.index], "at_rest_encryption_enabled", false)
  transit_encryption_enabled    = lookup(var.RepGroup[count.index], "transit_encryption_enabled", false)
  auth_token                    = lookup(var.RepGroup[count.index], "auth_token") ? aws_elasticache_replication_group.ElasticacheReplicationGroup.transit_encryption_enabled : true
  subnet_group_name             = element(data.terraform_remote_state.vpc.outputs.private_subnets, 0)
  security_group_ids            = [join("", data.terraform_remote_state.security_groups.id)]
  maintenance_window            = lookup(var.RepGroup[count.index], "maintenance_window", null)
  snapshot_name                 = lookup(var.RepGroup[count.index], "snapshot_name", null)
  snapshot_retention_limit      = lookup(var.RepGroup[count.index], "snapshot_retention_limit") ? aws_elasticache_replication_group.ElasticacheReplicationGroup.engine : "redis"
  snapshot_window               = lookup(var.RepGroup[count.index], "snapshot_window")
  apply_immediately             = lookup(var.RepGroup[count.index], "apply_immediately", false)

  dynamic "cluster_mode" {
    for_each = lookup(var.RepGroup[count.index], "cluster_mode") ? aws_elasticache_replication_group.ElasticacheReplicationGroup.automatic_failover_enabled : true
    content {
      replicas_per_node_group = lookup(cluster_mode.value, "replicas_per_node_group")
      num_node_groups         = lookup(cluster_mode.value, "num_node_groups")
    }
  }
}