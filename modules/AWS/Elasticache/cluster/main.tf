resource "aws_elasticache_cluster" "elasticache" {
  count                        = length(var.elasticache)
  cluster_id                   = lookup(var.elasticache[count.index], "cluster_id")
  engine                       = lookup(var.elasticache[count.index], "engine")
  engine_version               = lookup(var.elasticache[count.index], "engine_version", null)
  maintenance_window           = lookup(var.elasticache[count.index], "maintenance_windows", null)
  port                         = lookup(var.elasticache[count.index], "port", null)
  subnet_group_name            = element(var.subnet_group, lookup(var.elasticache[count.index], "subnet_group_id"))
  security_group_ids           = [element(var.security_group, lookup(var.elasticache[count.index], "security_group_ids"))]
  snapshot_name                = lookup(var.elasticache[count.index], "snapshot_name", null)
  snapshot_retention_limit     = lookup(var.elasticache[count.index], "snapshot_retention_limit", null)
  az_mode                      = lookup(var.elasticache[count.index], "az_mode", null)
  preferred_availability_zones = [lookup(var.elasticache[count.index], "engine") == "memcached" ? lookup(var.elasticache[count.index], "preferred_availability_zones") : ""]
}