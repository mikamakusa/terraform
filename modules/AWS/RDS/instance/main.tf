resource "aws_db_instance" "instance" {
  count                                 = length(var.instance)
  instance_class                        = lookup(var.instance[count.index], "instance_class")
  allocated_storage                     = lookup(var.instance[count.index], "allocated_storage", null)
  storage_type                          = lookup(var.instance[count.index], "storage_type", null)
  engine                                = lookup(var.instance[count.index], "engine", null)
  engine_version                        = lookup(var.instance[count.index], "engine_version", null)
  name                                  = lookup(var.instance[count.index], "name", null)
  username                              = lookup(var.instance[count.index], "username", null)
  password                              = base64encode(lookup(var.instance[count.index], "password", null))
  allow_major_version_upgrade           = lookup(var.instance[count.index], "allow_major_version_upgrade", null)
  apply_immediately                     = lookup(var.instance[count.index], "apply_immediately", false)
  availability_zone                     = lookup(var.instance[count.index], "availability_zone", null)
  backup_retention_period               = lookup(var.instance[count.index], "backup_retention_period", null)
  backup_window                         = lookup(var.instance[count.index], "backup_window", null)
  character_set_name                    = lookup(var.instance[count.index], "character_set_name", null)
  copy_tags_to_snapshot                 = lookup(var.instance[count.index], "copy_tags_to_snapshot", false)
  db_subnet_group_name                  = element(var.db_subnet_group_name, lookup(var.instance[count.index], "db_subnet_group_id", null))
  deletion_protection                   = lookup(var.instance[count.index], "deletion_protection", false)
  domain                                = lookup(var.instance[count.index], "domain", null)
  domain_iam_role_name                  = lookup(var.instance[count.index], "domain") != "" ? var.domain_iam_role_name : ""
  final_snapshot_identifier             = lookup(var.instance[count.index], "final_snapshot_identifier", null)
  iam_database_authentication_enabled   = lookup(var.instance[count.index], "iam_database_authentication_enabled", false)
  identifier                            = lookup(var.instance[count.index], "identifier", null)
  iops                                  = lookup(var.instance[count.index], "iops", null)
  kms_key_id                            = var.kms_key_id
  license_model                         = lookup(var.instance[count.index], "license_model", null)
  maintenance_window                    = lookup(var.instance[count.index], "maintenance_window", null)
  max_allocated_storage                 = lookup(var.instance[count.index], "max_allocated_storage", null)
  monitoring_interval                   = lookup(var.instance[count.index], "monitoring_interval", null)
  monitoring_role_arn                   = var.monitoring_role_arn
  multi_az                              = lookup(var.instance[count.index], "multi_az", false)
  option_group_name                     = element(var.option_group_name, lookup(var.instance[count.index], "option_group_id", null))
  parameter_group_name                  = element(var.parameter_group_name, lookup(var.instance[count.index], "parameter_group_id", null))
  publicly_accessible                   = lookup(var.instance[count.index], "publicly_accessible", false)
  storage_encrypted                     = lookup(var.instance[count.index], "storage_encrypted", false)
  timezone                              = lookup(var.instance[count.index], "timezone", null)
  vpc_security_group_ids                = [var.vpc_security_group_ids]
  performance_insights_enabled          = lookup(var.instance[count.index], "performance_insights_enabled", false)
  performance_insights_kms_key_id       = lookup(var.instance[count.index], "performance_insights_enabled") != "false" ? var.performance_insights_kms_key_id : ""
  performance_insights_retention_period = lookup(var.instance[count.index], "performance_insights_retention_period", null)

  dynamic "s3_import" {
    for_each = lookup(var.instance[count.index], "s3_import") == null ? [] : lookup(var.instance[count.index], "s3_import")
    content {
      bucket_name           = lookup(s3_import.value, "bucket_name", null)
      ingestion_role        = lookup(s3_import.value, "ingestion_role", null)
      source_engine         = lookup(s3_import.value, "source_engine", null)
      source_engine_version = lookup(s3_import.value, "source_engine_version", null)
      bucket_prefix         = lookup(s3_import.value, "bucket_prefix", null)
    }
  }

  dynamic "timeouts" {
    for_each = lookup(var.instance[count.index], "timeouts") == null ? [] : lookup(var.instance[count.index], "timeouts")
    content {
      create = lookup(timeouts.value, "create")
      delete = lookup(timeouts.value, "delete")
      update = lookup(timeouts.value, "update")
    }
  }
}
