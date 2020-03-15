output "function_arn" {
  value = aws_lambda_event_source_mapping.event_source_mapping.*.function_arn
}

output "state" {
  value = aws_lambda_event_source_mapping.event_source_mapping.*.state
}

output "uuid" {
  value = aws_lambda_event_source_mapping.event_source_mapping.*.uuid
}