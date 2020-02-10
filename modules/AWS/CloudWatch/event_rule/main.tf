resource "aws_cloudwatch_event_rule" "event_rule" {
  count               = length(var.event_rule)
  name                = lookup(var.event_rule[count.index], "name", null)
  schedule_expression = lookup(var.event_rule[count.index], "schedule_expression", null)
  event_pattern       = lookup(var.event_rule[count.index], "schedule_expression") == "" ? lookup(var.event_rule[count.index], "event_pattern", null) : ""
  description         = lookup(var.event_rule[count.index], "description", null)
  role_arn            = element(var.iam_role_id, lookup(var.event_rule[count.index], "role_id", null))
  is_enabled          = lookup(var.event_rule[count.index], "is_enabled", false)
  tags                = lookup(var.event_rule[count.index], "tags", null)
}