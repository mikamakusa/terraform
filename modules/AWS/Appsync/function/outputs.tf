output "id" {
  value = aws_appsync_function.function.*.id
}

output "arn" {
  value = aws_appsync_function.function.*.arn
}

output "function_id" {
  value = aws_appsync_function.function.*.function_id
}