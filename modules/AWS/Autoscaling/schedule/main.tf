resource "aws_autoscaling_schedule" "autoscaling_schedule" {
  count                  = length(var.autoscaling_schedule)
  autoscaling_group_name = element(var.autoscaling_group_name, lookup(var.autoscaling_schedule[count.index], "autoscaling_group_id"))
  scheduled_action_name  = lookup(var.autoscaling_schedule[count.index], "scheduled_action_name")
  min_size               = lookup(var.autoscaling_schedule[count.index], "min_size")
  max_size               = lookup(var.autoscaling_schedule[count.index], "max_size")
  desired_capacity       = lookup(var.autoscaling_schedule[count.index], "desired_capacity")
  start_time             = lookup(var.autoscaling_schedule[count.index], "start_time")
  end_time               = lookup(var.autoscaling_schedule[count.index], "end_time")
  recurrence             = lookup(var.autoscaling_schedule[count.index], "recurrence")
}