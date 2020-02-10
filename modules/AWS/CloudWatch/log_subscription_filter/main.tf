resource "aws_cloudwatch_log_subscription_filter" "subscription_filter" {
  count           = length(var.subscription_filter)
  destination_arn = element(var.arn, lookup(var.subscription_filter[count.index], "arn_id"))
  filter_pattern  = lookup(var.subscription_filter[count.index], "filter_pattern")
  log_group_name  = element(var.log_group_name, lookup(var.subscription_filter[count.index], "log_group_id"))
  name            = lookup(var.subscription_filter[count.index], "name")
  role_arn        = element(var.iam_role_id, lookup(var.subscription_filter[count.index], "role_id", null))
  distribution    = lookup(var.subscription_filter[count.index], "distribution", null)
}