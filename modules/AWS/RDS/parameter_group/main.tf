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

  tags = var.tags
}