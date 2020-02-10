resource "aws_cloudwatch_log_resource_policy" "log_resource_policy" {
  count           = length(var.log_resource_policy)
  policy_document = element(var.policy_document, lookup(var.log_resource_policy[count.index], "policy_document_id"))
  policy_name     = lookup(var.log_resource_policy[count.index], "policy_name")
}