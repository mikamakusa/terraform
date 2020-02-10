resource "aws_cloudwatch_log_destination" "log_destination" {
  count      = length(var.log_destination)
  name       = lookup(var.log_destination[count.index], "name")
  role_arn   = element(var.iam_role_id, lookup(var.log_destination[count.index], "role_id"))
  target_arn = element(var.arn, lookup(var.log_destination[count.index], "target_id"))
}