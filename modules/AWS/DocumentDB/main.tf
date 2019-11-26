resource "aws_subnet" "aws_subnet" {
  count                   = length(var.subnet)
  cidr_block              = lookup(var.subnet[count.index], "cidr_block")
  vpc_id                  = data.terraform_remote_state.vpc.id
  availability_zone       = lookup(var.subnet[count.index], "availability_zone")
  map_public_ip_on_launch = lookup(var.subnet[count.index], "map_public_ip_on_launch")

  dynamic "lifecycle" {
    for_each = lookup(var.subnet[count.index], "lifecycle")
    content {
      create_before_destroy = lookup(lifecycle.value, "create_before_destroy", null)
      prevent_destroy       = lookup(lifecycle.value, "prevent_destory", null)
    }
  }
}

resource "aws_security_group" "security_group" {
  count       = length(var.security_group)
  name        = lookup(var.security_group[count.index], "name")
  description = lookup(var.security_group[count.index], "description")
  vpc_id      = data.terraform_remote_state.vpc.id
  tags        = lookup(var.security_group[count.index], "tags")
}

resource "aws_security_group_rule" "security_group_rules" {
  count             = length(var.security_group) == "0" ? "0" : length(var.security_rule)
  from_port         = lookup(var.security_rule[count.index], "from_port")
  protocol          = lookup(var.security_rule[count.index], "protocol")
  security_group_id = element(aws_security_group.security_group.*.id, lookup(var.security_rule[count.index], "security_group_id"))
  to_port           = lookup(var.security_rule[count.index], "to_port")
  type              = lookup(var.security_rule[count.index], "type")
}

resource "aws_docdb_cluster_parameter_group" "docdb_param_group" {
  count       = length(aws_docdb_cluster_parameter_group)
  family      = lookup(var.docdb_ParamGroup[count.index], "family")
  name        = lookup(var.docdb_ParamGroup[count.index], "name", null)
  description = lookup(var.docdb_ParamGroup[count.index], "description", null)

  dynamic "parameter" {
    for_each = lookup(var.docdb_ParamGroup[count.index], "parameter")
    content {
      name         = lookup(parameter.value, "name")
      value        = lookup(parameter.value, "value")
      apply_method = lookup(parameter.value, "apply_method", null)
    }
  }
}

resource "aws_docdb_subnet_group" "docdb_subnet_group" {
  name       = "docdb_subnet_group"
  subnet_ids = [aws_subnet.aws_subnet.*.id]
}

resource "aws_docdb_cluster" "docdb_cluster" {
  count                           = length(var.docdb_cluster)
  cluster_identifier              = lookup(var.docdb_cluster[count.index], "cluster_identifier", null)
  engine                          = lookup(var.docdb_cluster[count.index], "engine", null)
  availability_zones              = [lookup(var.docdb_cluster[count.index], "availability_zones", null)]
  apply_immediately               = lookup(var.docdb_cluster[count.index], "apply_immediately", null)
  master_username                 = lookup(var.docdb_cluster[count.index], "master_username", null)
  master_password                 = lookup(var.docdb_cluster[count.index], "master_password", null)
  port                            = lookup(var.docdb_cluster[count.index], "port", null)
  backup_retention_period         = lookup(var.docdb_cluster[count.index], "backup_retention_period", null)
  preferred_backup_window         = lookup(var.docdb_cluster[count.index], "preferred_backup_window", null)
  preferred_maintenance_window    = lookup(var.docdb_cluster[count.index], "preferred_maintenance_window", null)
  skip_final_snapshot             = lookup(var.docdb_cluster[count.index], "skip_final_snapshot", true)
  snapshot_identifier             = lookup(var.docdb_cluster[count.index], "snapshot_identifier", null)
  storage_encrypted               = lookup(var.docdb_cluster[count.index], "storage_encrypted", null)
  db_cluster_parameter_group_name = element(aws_docdb_cluster_parameter_group.docdb_param_group.*.name, lookup(var.docdb_cluster[count.index], "parameter_group_id"), null)
  db_subnet_group_name            = element(aws_docdb_subnet_group.docdb_subnet_group.name, lookup(var.docdb_cluster[count.index], "subnet_group_id"), null)
  vpc_security_group_ids          = [aws_security_group.security_group.id, null]
}

resource "aws_docdb_cluster_instance" "docdb_instance" {
  count                        = length(var.docdb_cluster) == "0" ? "0" : length(var.instance)
  cluster_identifier           = element(aws_docdb_cluster.docdb_cluster.*.id, lookup(var.instance[count.index], "cluster_id"))
  instance_class               = lookup(var.instance[count.index], "instance_class")
  engine                       = lookup(var.instance[count.index], "engine", null)
  auto_minor_version_upgrade   = lookup(var.instance[count.index], "auto_minor_version_upgrade", null)
  apply_immediately            = lookup(var.instance[count.index], "apply_immediately", null)
  preferred_maintenance_window = lookup(var.instance[count.index], "preferred_maintenace_window", null)
  promotion_tier               = lookup(var.instance[count.index], "promotion_tier", null)
}

resource "aws_docdb_cluster_snapshot" "docdb_snapshot" {
  count                          = length(var.docdb_cluster) == "0" ? "0" : length(var.snapshot)
  db_cluster_identifier          = element(aws_docdb_cluster.docdb_cluster.*.id, lookup(var.snapshot[count.index], "cluster_id"))
  db_cluster_snapshot_identifier = lookup(var.snapshot[count.index], "db_cluster_snapshot_identifier")
}