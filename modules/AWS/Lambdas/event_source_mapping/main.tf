resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  count                              = length(var.event_source_mapping)
  event_source_arn                   = var.event_source_arn
  function_name                      = var.function_name
  batch_size                         = lookup(var.event_source_mapping[count.index], "batch_size")
  enabled                            = lookup(var.event_source_mapping[count.index], "enabled")
  starting_position_timestamp        = lookup(var.event_source_mapping[count.index], "starting_position_timestamp")
  starting_position                  = lookup(var.event_source_mapping[count.index], "starting_position")
  maximum_batching_window_in_seconds = lookup(var.event_source_mapping[count.index], "maximum_batching_window_in_seconds")
  parallelization_factor             = lookup(var.event_source_mapping[count.index], "parallelization_factor")
  maximum_retry_attempts             = lookup(var.event_source_mapping[count.index], "maximum_retry_attempts")
  bisect_batch_on_function_error     = lookup(var.event_source_mapping[count.index], "bisect_batch_on_function_error")
  maximum_record_age_in_seconds      = lookup(var.event_source_mapping[count.index], "maximum_record_age_in_seconds")

  dynamic "destination_config" {
    for_each = lookup(var.event_source_mapping[count.index], "") == null ? [] : [for i in lookup(var.event_source_mapping[count.index], "") : {
      on_failure = lookup(i, "on_failure", null)
    }]
    content {
      dynamic "on_failure" {
        for_each = destination_config.value.on_failure == null ? [] : [ for i in destination_config.value.on_failure : {
          destination = i.destination_id
        }]
        content {
          destination_arn = element(var.destination_arn, on_failure.value.destination)
        }
      }
    }
  }
}