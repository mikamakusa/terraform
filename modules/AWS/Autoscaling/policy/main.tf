resource "aws_autoscaling_policy" "autoscaling_policy" {
  count                  = length(var.autoscaling_policy)
  autoscaling_group_name = element(var.autoscaling_group_name, lookup(var.autoscaling_policy[count.index], "autoscaling_group_id"))
  name                   = lookup(var.autoscaling_policy[count.index], "name")
  adjustment_type        = lookup(var.autoscaling_policy[count.index], "adjustment_type")
  cooldown               = lookup(var.autoscaling_policy[count.index], "cooldown")
  policy_type            = lookup(var.autoscaling_policy[count.index], "policy_type")

  dynamic "step_adjustment" {
    for_each = lookup(var.autoscaling_policy[count.index], "step_adjustment")
    content {
      scaling_adjustment          = lookup(step_adjustment.value, "scaling_adjustment")
      metric_interval_lower_bound = lookup(step_adjustment.value, "metric_interval_lower_bound")
      metric_interval_upper_bound = lookup(step_adjustment.value, "metric_interval_upper_bound")
    }
  }

  dynamic "target_tracking_configuration" {
    for_each = lookup(var.autoscaling_policy[count.index], "target_tracking_configuration")
    content {
      target_value = lookup(target_tracking_configuration.value, "target_value")
      predefined_metric_specification {
        predefined_metric_type = lookup(target_tracking_configuration.value, "predefined_metric_type")
      }
      customized_metric_specification {
        metric_name = lookup(target_tracking_configuration.value, "metric_name")
        namespace   = lookup(target_tracking_configuration.value, "namespace")
        statistic   = lookup(target_tracking_configuration.value, "statistic")
      }
    }
  }
}