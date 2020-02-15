resource "aws_elasticache_parameter_group" "parameter_group" {
  count  = length(var.parameter_group)
  family = lookup(var.parameter_group[count.index], "family")
  name   = lookup(var.parameter_group[count.index], "name")

  dynamic "parameter" {
    for_each = lookup(var.parameter_group[count.index], "parameter")
    content {
      name  = lookup(parameter.value, "name", null)
      value = lookup(parameter.value, "value", null)
    }
  }
}