output "composite_alarm" {
  value = try(
    aws_cloudwatch_composite_alarm.this,
    aws_cloudwatch_dashboard.this,
    aws_cloudwatch_metric_alarm.this,
    aws_cloudwatch_metric_stream.this
  )
}

output "application_insights" {
  value = try(
    aws_applicationinsights_application.this
  )
}

output "evidently" {
  value = try(
    aws_evidently_segment.this,
    aws_evidently_project.this,
    aws_evidently_feature.this
  )
}

output "logs" {
  value = try(
    aws_cloudwatch_log_data_protection_policy.this,
    aws_cloudwatch_log_destination.this,
    aws_cloudwatch_log_destination_policy.this,
    aws_cloudwatch_log_group.this,
    aws_cloudwatch_log_metric_filter.this,
    aws_cloudwatch_log_resource_policy.this,
    aws_cloudwatch_log_subscription_filter.this,
    aws_cloudwatch_log_stream.this
  )
}

output "rum" {
  value = try(
    aws_rum_metrics_destination.this,
    aws_rum_app_monitor.this
  )
}

output "synthetics" {
  value = try(
    aws_synthetics_canary.this
  )
}

output "eventbridge" {
  value = try(
    aws_cloudwatch_event_archive.this,
    aws_cloudwatch_event_api_destination.this,
    aws_cloudwatch_event_bus.this,
    aws_cloudwatch_event_bus_policy.this,
    aws_cloudwatch_event_connection.this,
    aws_cloudwatch_event_permission.this,
    aws_cloudwatch_event_rule.this,
    aws_cloudwatch_event_target.this
  )
}