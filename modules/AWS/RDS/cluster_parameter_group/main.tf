resource "aws_rds_cluster_parameter_group" "cluster_parameter_group" {
  count       = length(var.cluster_parameter_group)
  name        = lookup(var.cluster_parameter_group[count.index], "name")
  family      = lookup(var.cluster_parameter_group[count.index], "family")
  description = lookup(var.cluster_parameter_group[count.index], "description")

  dynamic "parameter" {
    for_each = lookup(var.cluster_parameter_group[count.index], "parameter") == null ? [] : lookup(var.cluster_parameter_group[count.index], "parameter")
    content {
      name         = lookup(parameter.value, "name")
      value        = lookup(parameter.value, "value")
      apply_method = lookup(parameter.value, "apply_method")
    }
  }

  tags = var.tags
}