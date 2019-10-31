resource "aws_neptune_subnet_group" "aws_neptune_subnet_group" {
  count       = length(var.neptune_subnet_group)
  name        = lookup(var.neptune_subnet_group[count.index], "name")
  name_prefix = lookup(var.neptune_subnet_group[count.index], "name_prefix") ? aws_neptune_subnet_group.aws_neptune_subnet_group.name : ""
  subnet_ids  = [element(data.terraform_remote_state.vpc.outputs.private_subnets, 0)]
}

resource "aws_neptune_parameter_group" "neptune_parameter_group" {
  count  = length(var.neptune_param_group)
  family = lookup(var.neptune_param_group[count.index], "family")
  name   = lookup(var.neptune_param_group[count.index], "name")
}

resource "aws_neptune_cluster" "aws_neptune" {
  count                                = length(var.neptune)
  cluster_identifier                   = lookup(var.neptune[count.index], "cluster_identifier", null)
  cluster_identifier_prefix            = lookup(var.neptune[count.index], "cluster_identifier_prefix") ? aws_neptune_cluster.aws_neptune.cluster_identifier : ""
  engine                               = lookup(var.neptune[count.index], "engine", "neptune")
  engine_version                       = lookup(var.neptune[count.index], "engine_version", null)
  backup_retention_period              = lookup(var.neptune[count.index], "backup_retention_period", 1)
  preferred_backup_window              = lookup(var.neptune[count.index], "preferred_backup_window", null)
  apply_immediately                    = lookup(var.neptune[count.index], "apply_immediately", false)
  snapshot_identifier                  = lookup(var.neptune[count.index], "snapshot_identifier", null)
  skip_final_snapshot                  = lookup(var.neptune[count.index], "skip_final_snapshot", false)
  final_snapshot_identifier            = lookup(var.neptune[count.index], "final_snapshot_identifier", null)
  vpc_security_group_ids               = [join("", data.terraform_remote_state.security_groups.id)]
  availability_zones                   = [lookup(var.neptune[count.index], "availability_zones", null)]
  neptune_subnet_group_name            = element(aws_neptune_subnet_group.aws_neptune_subnet_group.*.name, lookup(var.neptune[count.index], "subnet_name"))
  neptune_cluster_parameter_group_name = element(aws_neptune_parameter_group.neptune_parameter_group.*.name, lookup(var.neptune[count.index], "parameter_group_name"))
  port                                 = lookup(var.neptune[count.index], "port", null)
  replication_source_identifier        = lookup(var.neptune[count.index], "replication_source_identifier", null)
  iam_database_authentication_enabled  = lookup(var.neptune[count.index], "iam_database_authentication_enabled", false)
  iam_roles                            = [lookup(var.neptune[count.index], "iam_roles", false)]
  kms_key_arn                          = lookup(var.neptune[count.index], "kms_key_arn", false)
}

resource "aws_neptune_cluster_instance" "cluster_instance" {
  count                        = "${"${length(var.neptune)}" == "0" ? "0" : "${length(var.neptune_cluster_instance)}"}"
  cluster_identifier           = element(aws_neptune_cluster.aws_neptune.*.id, lookup(var.neptune_cluster_instance[count.index], "cluster_id"))
  instance_class               = lookup(var.neptune_cluster_instance[count.index], "instance_class")
  engine                       = lookup(var.neptune_cluster_instance[count.index], "engine", null)
  engine_version               = lookup(var.neptune_cluster_instance[count.index], "engine_version", null)
  identifier                   = lookup(var.neptune_cluster_instance[count.index], "identifier", null)
  identifier_prefix            = lookup(var.neptune_cluster_instance[count.index], "identifier_prefix", null) ? aws_neptune_cluster_instance.cluster_instance.identifier : ""
  neptune_subnet_group_name    = element(aws_neptune_subnet_group.aws_neptune_subnet_group.*.name, lookup(var.neptune_cluster_instance[count.index], "subnet_name"))
  neptune_parameter_group_name = element(aws_neptune_parameter_group.neptune_parameter_group.*.name, lookup(var.neptune_cluster_instance[count.index], "parameter_group_name"))
  port                         = lookup(var.neptune_cluster_instance[count.index], "port", null)
  apply_immediately            = lookup(var.neptune_cluster_instance[count.index], "apply_immediately", false)
  auto_minor_version_upgrade   = lookup(var.neptune_cluster_instance[count.index], "auto_minor_version_upgrade", true)
  availability_zone            = lookup(var.neptune_cluster_instance[count.index], "availability_zone", null)
  preferred_backup_window      = lookup(var.neptune_cluster_instance[count.index], "preferred_backup_window", null)
  preferred_maintenance_window = lookup(var.neptune_cluster_instance[count.index], "preferred_maintenance_window", null)
  promotion_tier               = lookup(var.neptune_cluster_instance[count.index], "promotion_tier", null)
  publicly_accessible          = lookup(var.neptune_cluster_instance[count.index], "publicly_accessible", false)
}

resource "aws_neptune_cluster_snapshot" "cluster_snapshot" {
  count                          = "${"${length(var.neptune)}" == "0" ? "0" : "${length(var.neptune_snapshot)}"}"
  db_cluster_identifier          = element(aws_neptune_cluster.aws_neptune.*.id, lookup(var.neptune_snapshot[count.index], "cluster_id"))
  db_cluster_snapshot_identifier = lookup(var.neptune_snapshot[count.index], "db_cluster_snapshot_identifier")
}

resource "aws_sns_topic" "sns_neptune" {
  name = "neptune"
}

resource "aws_neptune_event_subscription" "neptune_event" {
  count         = "${"${length(var.neptune_cluster_instance)}" == "0" ? "0" : "${length(var.neptune_events)}"}"
  sns_topic_arn = element(aws_sns_topic.sns_neptune.id, lookup(var.neptune_events[count.index], "sns_id"))
  source_type   = lookup(var.neptune_events[count.index], "source_type", null)
  source_ids    = [lookup(var.neptune_events[count.index], "source_ids", null)]
  name          = lookup(var.neptune_events[count.index], "name", null)
  name_prefix   = lookup(var.neptune_events[count.index], "name_prefix") ? aws_neptune_event_subscription.neptune_event.name : ""
  enabled       = lookup(var.neptune_events[count.index], "enabled", false)
  event_categories = [
    "maintenance",
    "availability",
    "creation",
    "backup",
    "restoration",
    "recovery",
    "deletion",
    "failover",
    "failure",
    "notification",
    "configuration change",
    "read replica",
  ]
}

resource "aws_neptune_cluster_parameter_group" "cluster_parameter_group" {
  count       = length(var.cluster_ParamGroup)
  family      = lookup(var.cluster_ParamGroup[count.index], "family")
  name        = lookup(var.cluster_ParamGroup[count.index], "name", null)
  name_prefix = lookup(var.cluster_ParamGroup[count.index], "name_prefix", null) ? aws_neptune_cluster_parameter_group.cluster_parameter_group.name : ""
  description = lookup(var.cluster_ParamGroup[count.index], "description", null)

  dynamic "parameter" {
    for_each = lookup(var.cluster_ParamGroup[count.index], "parameter")
    content {
      name  = lookup(parameter.value, "name", null)
      value = lookup(parameter.value, "value", null)
    }
  }
}