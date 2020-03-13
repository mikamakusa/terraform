resource "aws_lambda_function_event_invoke_config" "lambda_function_event_invoke_config" {
  count                        = length(var.lambda_function_event_invoke_config)
  function_name                = element(var.function_name, lookup(var.lambda_function_event_invoke_config[count.index], "function_id"))
  qualifier                    = "$LATEST"
  maximum_event_age_in_seconds = lookup(var.lambda_function_event_invoke_config[count.index], "maximum_event_age_in_seconds", null)
  maximum_retry_attempts       = lookup(var.lambda_function_event_invoke_config[count.index], "maximum_retry_attempts", null)

  dynamic "destination_config" {
    for_each = lookup(var.lambda_function_event_invoke_config[count.index], "destination_config")
    content {
      on_failure {
        destination = element(var.on_failure_sns_topic_arn, lookup(destination_config.value, "on_failure_sns_topic_id"))
      }
      on_success {
        destination = element(var.on_success_sns_topic_arn, lookup(destination_config.value, "on_success_sns_topic_id"))
      }
    }
  }
}