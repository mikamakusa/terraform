resource "aws_cloudwatch_log_stream" "log_stream" {
  count          = length(var.log_stream)
  log_group_name = element(var.log_group_name, lookup(var.log_stream[count.index], "log_group_id"))
  name           = lookup(var.log_stream[count.index], "name")
}