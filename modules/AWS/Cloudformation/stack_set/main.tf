resource "aws_cloudformation_stack_set" "stack_set" {
  count                   = length(var.stack_set)
  administration_role_arn = element(var.administration_role_arn, lookup(var.stack_set[count.index], "administration_role_id"))
  name                    = lookup(var.stack_set[count.index], "name")
  capabilities            = lookup(var.stack_set[count.index], "capabilities")
  description             = lookup(var.stack_set[count.index], "description")
  execution_role_name     = element(var.execution_role_name, lookup(var.stack_set[count.index], "execution_role_id"))
  template_body           = file(join(".", [join("/", [path.cwd, "template", lookup(var.stack_set[count.index], "template_body")]), lookup(var.stack_set[count.index], "extension")]))

  dynamic "parameters" {
    for_each = lookup(var.stack_set[count.index], "parameters")
    content {
      variables = parameters.value
    }
  }

  tags = var.tags
}