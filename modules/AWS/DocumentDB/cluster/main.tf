resource "aws_cluster" "cluster" {
  count                           = length(var.cluster)
  cluster_identifier              = lookup(var.cluster[count.index], "cluster_identifier", null)
  engine                          = lookup(var.cluster[count.index], "engine", null)
  availability_zones              = [lookup(var.cluster[count.index], "availability_zones", null)]
  apply_immediately               = lookup(var.cluster[count.index], "apply_immediately", null)
  master_username                 = lookup(var.cluster[count.index], "master_username", null)
  master_password                 = lookup(var.cluster[count.index], "master_password", null)
  port                            = lookup(var.cluster[count.index], "port", null)
  backup_retention_period         = lookup(var.cluster[count.index], "backup_retention_period", null)
  preferred_backup_window         = lookup(var.cluster[count.index], "preferred_backup_window", null)
  preferred_maintenance_window    = lookup(var.cluster[count.index], "preferred_maintenance_window", null)
  skip_final_snapshot             = lookup(var.cluster[count.index], "skip_final_snapshot", true)
  snapshot_identifier             = lookup(var.cluster[count.index], "snapshot_identifier", null)
  storage_encrypted               = lookup(var.cluster[count.index], "storage_encrypted", null)
  db_cluster_parameter_group_name = element(var.parameter_group_name, lookup(var.cluster[count.index], "parameter_group_id"), null)
  db_subnet_group_name            = element(var.subnet_group_id, lookup(var.cluster[count.index], "subnet_group_id"), null)
  vpc_security_group_ids          = [element(var.security_group_id, lookup(var.cluster[count.index], "security_group_id")), null]
}