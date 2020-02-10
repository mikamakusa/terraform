resource "aws_cloudwatch_metric_alarm" "metric_alarm" {
  count                                 = length(var.metric_alarm)
  alarm_name                            = lookup(var.metric_alarm[count.index], "alarm_name")
  comparison_operator                   = lookup(var.metric_alarm[count.index], "comparison_operator")
  evaluation_periods                    = lookup(var.metric_alarm[count.index], "evaluation_periods")
  threshold                             = lookup(var.metric_alarm[count.index], "threshold")
  actions_enabled                       = lookup(var.metric_alarm[count.index], "actions_enabled", true)
  alarm_actions                         = [lookup(var.metric_alarm[count.index], "alarm_actions", null)]
  alarm_description                     = lookup(var.metric_alarm[count.index], "alarm_description", null)
  insufficient_data_actions             = [lookup(var.metric_alarm[count.index], "insufficient_data_actions", null)]
  datapoints_to_alarm                   = lookup(var.metric_alarm[count.index], "datapoints_to_alarm", null)
  ok_actions                            = [lookup(var.metric_alarm[count.index], "ok_actions", null)]
  unit                                  = lookup(var.metric_alarm[count.index], "unit", null)
  treat_missing_data                    = lookup(var.metric_alarm[count.index], "unit", null)
  evaluate_low_sample_count_percentiles = lookup(var.metric_alarm[count.index], "evaluate_low_sample_count_percentiles", null)

  dynamic "metric_query" {
    for_each = lookup(var.metric_alarm[count.index], "metric_query")
    content {
      id          = lookup(metric_query.value, "id")
      expression  = lookup(metric_query.value, "expression", null)
      label       = lookup(metric_query.value, "label", null)
      return_data = lookup(metric_query.value, "return_data", null)
    }
  }
}