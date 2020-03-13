output "arn" {
  value = aws_appsync_datasource.datasource.*.arn
}