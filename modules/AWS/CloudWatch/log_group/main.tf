resource "aws_cloudwatch_log_group" "log_group" {
  count             = length(var.log_group)
  name              = lookup(var.log_group[count.index], "name", null)
  retention_in_days = lookup(var.log_group[count.index], "retention_in_days", null)
  kms_key_id        = var.kms_key_id == "" ? "" : element(var.kms_key_id, lookup(var.log_group[count.index], "kms_key_id"))
  tags              = var.tags
}