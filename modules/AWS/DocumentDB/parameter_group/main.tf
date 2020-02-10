resource "aws_docdb_cluster_parameter_group" "parameter_group" {
  count       = length(aws_docdb_cluster_parameter_group)
  family      = lookup(var.parameter_group[count.index], "family")
  name        = lookup(var.parameter_group[count.index], "name", null)
  description = lookup(var.parameter_group[count.index], "description", null)

  dynamic "parameter" {
    for_each = lookup(var.parameter_group[count.index], "parameter")
    content {
      name         = lookup(parameter.value, "name")
      value        = lookup(parameter.value, "value")
      apply_method = lookup(parameter.value, "apply_method", null)
    }
  }
}