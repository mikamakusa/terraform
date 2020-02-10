resource "aws_autoscaling_lifecycle_hook" "lifecycle_hook" {
  count                   = length(var.lifecycle_hook)
  autoscaling_group_name  = element(var.autoscaling_group_name, lookup(var.lifecycle_hook[count.index], "autoscaling_group_id"))
  lifecycle_transition    = lookup(var.lifecycle_hook[count.index], "lifecycle_transition")
  name                    = lookup(var.lifecycle_hook[count.index], "name")
  heartbeat_timeout       = lookup(var.lifecycle_hook[count.index], "heartbeat_timeout", null)
  notification_metadata   = var.notification_metadata
  notification_target_arn = element(var.notification_target_arn, lookup(var.lifecycle_hook[count.index], "notification_target_id"))
  role_arn                = element(var.role_arn, lookup(var.lifecycle_hook[count.index], "role_id"))
  default_result          = lookup(var.lifecycle_hook[count.index], "default_result")
}