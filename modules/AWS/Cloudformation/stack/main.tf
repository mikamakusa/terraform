resource "aws_cloudformation_stack" "stack" {
  count              = length(var.stack)
  name               = lookup(var.stack[count.index], "name")
  template_body      = file(join(".", [join("/", [path.cwd, "template", lookup(var.stack[count.index], "template_body")]), lookup(var.stack[count.index], "extension")]))
  capabilities       = lookup(var.stack[count.index], "capabilities")
  notification_arns  = [element(var.notifications_arn, lookup(var.stack[count.index], "notification_id"))]
  disable_rollback   = lookup(var.stack[count.index], "disable_rollback")
  on_failure         = lookup(var.stack[count.index], "onfailure")
  policy_body        = file(join("/", [path.cwd, "policy", lookup(var.stack[count.index], "policy_body")]))
  iam_role_arn       = element(var.iam_role_arn, lookup(var.stack[count.index], "iam_role_id"))
  timeout_in_minutes = lookup(var.stack[count.index], "timeout_in_minutes")

  dynamic "parameters" {
    for_each = lookup(var.stack[count.index], "parameters")
    content {
      variables = parameters.value
    }
  }

  tags = var.tags
}