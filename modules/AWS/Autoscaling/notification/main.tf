resource "aws_autoscaling_notification" "autoscaling_notification" {
  count         = length(var.autoscaling_notification)
  group_names   = element(var.group_name, lookup(var.autoscaling_notification[count.index], "autoscaling_group_id"))
  notifications = lookup(var.autoscaling_notification[count.index], "notifications")
  topic_arn     = element(var.topic_arn, lookup(var.autoscaling_notification[count.index], "topic_id"))
}