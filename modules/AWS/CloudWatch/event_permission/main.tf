resource "aws_cloudwatch_event_permission" "event_permission" {
  count        = length(var.event_permission)
  principal    = lookup(var.event_permission[count.index], "principal")
  statement_id = lookup(var.event_permission[count.index], "statement_id")
  action       = lookup(var.event_permission[count.index], "action", null)

  dynamic "condition" {
    for_each = lookup(var.event_permission[count.index], "condition")
    content {
      key   = lookup(condition.value, "key", null)
      type  = lookup(condition.value, "type", null)
      value = lookup(condition.value, "value", null)
    }
  }
}