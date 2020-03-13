output "id" {
  value = aws_appsync_api_key.api_key.*.id
}

output "key" {
  value = aws_appsync_api_key.api_key.*.key
}