resource "aws_cloudwatch_log_metric_filter" "metric_filter" {
  count          = length(var.metric_filter)
  log_group_name = element(var.log_group_name, lookup(var.metric_filter[count.index], "log_group_id"))
  name           = lookup(var.metric_filter[count.index], "name")
  pattern        = lookup(var.metric_filter[count.index], "pattern")

  dynamic "metric_transformation" {
    for_each = lookup(var.metric_filter[count.index], "metric_transformation")
    content {
      name          = lookup(metric_transformation.value, "name")
      namespace     = lookup(metric_transformation.value, "namespace")
      value         = lookup(metric_transformation.value, "value")
      default_value = lookup(metric_transformation.value, "default_value", null)
    }
  }
}