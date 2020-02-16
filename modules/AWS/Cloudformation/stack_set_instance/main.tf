resource "aws_cloudformation_stack_set_instance" "stack_set_instance" {
  count          = length(var.stack_set_instance)
  stack_set_name = element(var.stack_set_name, lookup(var.stack_set_instance[count.index], "stack_set_id"))
  region         = lookup(var.stack_set_instance[count.index], "region")
  retain_stack   = lookup(var.stack_set_instance[count.index], "retain_stack")

  dynamic "parameter_overrides" {
    for_each = lookup(var.stack_set_instance[count.index], "parameter_overrides")
    content {
      variables = parameter_overrides.value
    }
  }
}