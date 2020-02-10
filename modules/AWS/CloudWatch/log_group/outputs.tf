output "clog_group_name" {
  value = aws_cloudwatch_log_group.log_group.*.name
}