resource "aws_rds_cluster" "cluster" {
  count                               = length(var.cluster)
  cluster_identifier                  = lookup(var.cluster[count.index], "cluster_identifier", null)
  copy_tags_to_snapshot               = lookup(var.cluster[count.index], "copy_tags_to_snapshot", false)
  database_name                       = lookup(var.cluster[count.index], "database_name", null)
  deletion_protection                 = lookup(var.cluster[count.index], "deletion_protection", false)
  master_username                     = lookup(var.cluster[count.index], "master_username", null)
  master_password                     = lookup(var.cluster[count.index], "master_password", null)
  final_snapshot_identifier           = lookup(var.cluster[count.index], "final_snapshot_identifier", null)
  skip_final_snapshot                 = lookup(var.cluster[count.index], "skip_final_snapshot", null)
  availability_zones                  = lookup(var.cluster[count.index], "availability_zones", null)
  backtrack_window                    = lookup(var.cluster[count.index], "backtrack_window", null)
  backup_retention_period             = lookup(var.cluster[count.index], "backup_retention_period", null)
  preferred_backup_window             = lookup(var.cluster[count.index], "preferred_backup_window", null)
  port                                = lookup(var.cluster[count.index], "port", null)
  vpc_security_group_ids              = [var.vpc_security_group_ids]
  global_cluster_identifier           = lookup(var.cluster[count.index], "global_cluster_identifier", null)
  storage_encrypted                   = lookup(var.cluster[count.index], "storage_encrypted", null)
  replication_source_identifier       = lookup(var.cluster[count.index], "replication_source_identifier", null)
  apply_immediately                   = lookup(var.cluster[count.index], "apply_immediately", true)
  db_subnet_group_name                = element(var.db_subnet_group_name, lookup(var.cluster[count.index], "db_subnet_group_id"))
  db_cluster_parameter_group_name     = element(var.db_cluster_parameter_group_name, lookup(var.cluster[count.index], "db_cluster_parameter_group_id"))
  kms_key_id                          = element(var.kms_key_id, lookup(var.cluster[count.index], "kms_key_id"))
  iam_roles                           = element(var.iam_roles, lookup(var.cluster[count.index], "iam_roles_id"))
  iam_database_authentication_enabled = lookup(var.cluster[count.index], "iam_database_authentication_enabled", true)
  engine                              = lookup(var.cluster[count.index], "engine", null)
  engine_mode                         = lookup(var.cluster[count.index], "engine_mode", null)
  engine_version                      = lookup(var.cluster[count.index], "engine_version", null)
  source_region                       = lookup(var.cluster[count.index], "source_region", null)
  enabled_cloudwatch_logs_exports     = lookup(var.cluster[count.index], "engine_mode") == "serverless" ? lookup(var.cluster[count.index], "enabled_cloudwatch_logs_exports") : null
  enable_http_endpoint                = lookup(var.cluster[count.index], "engine_mode") == "serverless" ? lookup(var.cluster[count.index], "enable_http_endpoint") : null

  dynamic "scaling_configuration" {
    for_each = lookup(var.cluster[count.index], "scaling_configuration") == null ? [] : lookup(var.cluster[count.index], "scaling_configuration")
    content {
      auto_pause               = lookup(scaling_configuration.value, "auto_pause")
      max_capacity             = lookup(scaling_configuration.value, "max_capacity")
      min_capacity             = lookup(scaling_configuration.value, "min_capacity")
      seconds_until_auto_pause = lookup(scaling_configuration.value, "seconds_until_auto_pause")
      timeout_action           = lookup(scaling_configuration.value, "timeout_action")
    }
  }

  dynamic "s3_import" {
    for_each = lookup(var.cluster[count.index], "s3_import") == null ? [] : lookup(var.cluster[count.index], "s3_import")
    content {
      bucket_name           = lookup(s3_import.value, "bucket_name")
      bucket_prefix         = lookup(s3_import.value, "bucket_prefix")
      ingestion_role        = lookup(s3_import.value, "ingestion_role")
      source_engine         = lookup(s3_import.value, "source_engine")
      source_engine_version = lookup(s3_import.value, "source_engine_version")
    }
  }
}
