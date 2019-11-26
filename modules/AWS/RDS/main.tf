resource "aws_db_option_group" "option_group" {
  count                    = length(var.option_group)
  engine_name              = lookup(var.option_group[count.index], "engine_name")
  major_engine_version     = lookup(var.option_group[count.index], "major_engine_version")
  option_group_description = lookup(var.option_group[count.index], "option_group_description", null)

  dynamic "option" {
    for_each = lookup(var.option_group[count.index], "option")
    content {
      option_name                    = lookup(option.value, "option_name")
      port                           = lookup(option.value, "port", null)
      version                        = lookup(option.value, "version", null)
      db_security_group_memberships  = []
      vpc_security_group_memberships = []
      option_settings {
        name  = lookup(option.value, "option_settings_name", null)
        value = lookup(option.value, "options_settings_value", null)
      }
    }
  }

  tags = lookup(var.option_group[count.index], "tags")
}

resource "aws_db_parameter_group" "parameter_group" {
  count       = length(var.parameter_group)
  family      = lookup(var.parameter_group[count.index], "family")
  name        = lookup(var.parameter_group[count.index], "name", null)
  description = lookup(var.parameter_group[count.index], "description", null)

  dynamic "parameter" {
    for_each = lookup(var.parameter_group[count.index], "parameter")
    content {
      name  = lookup(parameter.value, "name")
      value = lookup(parameter.value, "value")
    }
  }

  tags = lookup(var.parameter_group[count.index], "tags")
}

resource "aws_db_subnet_group" "db_subnet_group" {
  count      = length(var.db_subnet)
  name       = lookup(var.db_subnet[count.index], "name")
  subnet_ids = [element(var.subnet_id, lookup(var.db_subnet[count.index], "subnet_id"))]
}

resource "aws_db_instance" "db_instance" {
  count                                 = length(var.db_instance)
  instance_class                        = lookup(var.db_instance[count.index], "instance_class")
  allocated_storage                     = lookup(var.db_instance[count.index], "allocated_storage", null)
  storage_type                          = lookup(var.db_instance[count.index], "storage_type", null)
  engine                                = lookup(var.db_instance[count.index], "engine", null)
  engine_version                        = lookup(var.db_instance[count.index], "engine_version", null)
  name                                  = lookup(var.db_instance[count.index], "name", null)
  username                              = lookup(var.db_instance[count.index], "username", null)
  password                              = base64encode(lookup(var.db_instance[count.index], "password", null))
  allow_major_version_upgrade           = lookup(var.db_instance[count.index], "allow_major_version_upgrade", null)
  apply_immediately                     = lookup(var.db_instance[count.index], "apply_immediately", false)
  availability_zone                     = lookup(var.db_instance[count.index], "availability_zone", null)
  backup_retention_period               = lookup(var.db_instance[count.index], "backup_retention_period", null)
  backup_window                         = lookup(var.db_instance[count.index], "backup_window", null)
  character_set_name                    = lookup(var.db_instance[count.index], "character_set_name", null)
  copy_tags_to_snapshot                 = lookup(var.db_instance[count.index], "copy_tags_to_snapshot", false)
  db_subnet_group_name                  = element(aws_db_subnet_group.db_subnet_group.*.name, lookup(var.db_instance[count.index], "db_subnet_group_id", null))
  deletion_protection                   = lookup(var.db_instance[count.index], "deletion_protection", false)
  domain                                = lookup(var.db_instance[count.index], "domain", null)
  domain_iam_role_name                  = lookup(var.db_instance[count.index], "domain", null) ? element(var.domain_iam_role, lookup(var.db_instance[count.index], "domain_iam_role_name", null)) : ""
  final_snapshot_identifier             = lookup(var.db_instance[count.index], "final_snapshot_identifier", null)
  iam_database_authentication_enabled   = lookup(var.db_instance[count.index], "iam_database_authentication_enabled", false)
  identifier                            = lookup(var.db_instance[count.index], "identifier", null)
  iops                                  = lookup(var.db_instance[count.index], "iops", null)
  kms_key_id                            = element(var.kms_key, lookup(var.db_instance[count.index], "kms_key_id", null))
  license_model                         = lookup(var.db_instance[count.index], "license_model", null)
  maintenance_window                    = lookup(var.db_instance[count.index], "maintenance_window", null)
  max_allocated_storage                 = lookup(var.db_instance[count.index], "max_allocated_storage", null)
  monitoring_interval                   = lookup(var.db_instance[count.index], "monitoring_interval", null)
  monitoring_role_arn                   = element(var.monitoring_role, lookup(var.db_instance[count.index], "monitoring_role_arn", null))
  multi_az                              = lookup(var.db_instance[count.index], "multi_az", false)
  option_group_name                     = element(aws_db_option_group.option_group.*.name, lookup(var.db_instance[count.index], "option_group_id", null))
  parameter_group_name                  = element(aws_db_parameter_group.parameter_group.*.name, lookup(var.db_instance[count.index], "parameter_group_id", null))
  publicly_accessible                   = lookup(var.db_instance[count.index], "publicly_accessible", false)
  storage_encrypted                     = lookup(var.db_instance[count.index], "storage_encrypted", false)
  timezone                              = lookup(var.db_instance[count.index], "timezone", null)
  vpc_security_group_ids                = [element(var.security_group_id, lookup(var.db_instance[count.index], "security_group_id", null))]
  performance_insights_enabled          = lookup(var.db_instance[count.index], "performance_insights_enabled", false)
  performance_insights_kms_key_id       = lookup(var.db_instance[count.index], "performance_insights_enabled") ? lookup(var.db_instance[count.index], "performance_insights_kms_key_id", null) : ""
  performance_insights_retention_period = lookup(var.db_instance[count.index], "performance_insights_retention_period", null)

  dynamic "s3_import" {
    for_each = lookup(var.db_instance[count.index], "copy_tags_to_snapshot")
    content {
      bucket_name           = lookup(s3_import.value, "bucket_name", null)
      ingestion_role        = lookup(s3_import.value, "ingestion_role", null)
      source_engine         = lookup(s3_import.value, "source_engine", null)
      source_engine_version = lookup(s3_import.value, "source_engine_version", null)
      bucket_prefix         = lookup(s3_import.value, "bucket_prefix", null)
    }
  }
}
