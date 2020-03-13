output "lambda_function_event_invoke_config_id" {
  value = aws_lambda_function_event_invoke_config.lambda_function_event_invoke_config.*.id
}