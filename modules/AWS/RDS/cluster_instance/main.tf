resource "aws_rds_cluster_instance" "cluster_instance" {
  count                           = length(var.cluster_instance)
  cluster_identifier              = lookup(var.cluster_instance[count.index], "cluster_identifier")
  instance_class                  = lookup(var.cluster_instance[count.index], "instance_class")
  engine                          = lookup(var.cluster_instance[count.index], "engine")
  engine_version                  = lookup(var.cluster_instance[count.index], "engine_version")
  publicly_accessible             = lookup(var.cluster_instance[count.index], "publicly_accessible")
  db_subnet_group_name            = element(var.db_subnet_group_name, lookup(var.cluster_instance[count.index], "db_subnet_group_id"))
  db_parameter_group_name         = element(var.db_parameter_group_name, lookup(var.cluster_instance[count.index], "db_parameter_group_id"))
  apply_immediately               = lookup(var.cluster_instance[count.index], "apply_immediately")
  monitoring_role_arn             = element(var.monitoring_role_arn, lookup(var.cluster_instance[count.index], "monitoring_role_id"))
  monitoring_interval             = lookup(var.cluster_instance[count.index], "monitoring_interval")
  promotion_tier                  = lookup(var.cluster_instance[count.index], "promotion_tier")
  availability_zone               = lookup(var.cluster_instance[count.index], "availability_zone")
  preferred_backup_window         = lookup(var.cluster_instance[count.index], "preferred_backup_window")
  preferred_maintenance_window    = lookup(var.cluster_instance[count.index], "preferred_maintenance_window")
  performance_insights_enabled    = lookup(var.cluster_instance[count.index], "performance_insights_enabled")
  performance_insights_kms_key_id = lookup(var.cluster_instance[count.index], "performance_insights_enabled") == true ? element(var.performance_insights_kms_key_id, lookup(var.cluster_instance[count.index], "performance_insights_kms_key_id")) : null
  copy_tags_to_snapshot           = lookup(var.cluster_instance[count.index], "copy_tags_to_snapshot")
  tags                            = var.tags
}