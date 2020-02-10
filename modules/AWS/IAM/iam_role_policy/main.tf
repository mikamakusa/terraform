resource "aws_iam_role_policy" "iam_role_policy" {
  count  = length(var.iam_role_policy)
  policy = element(var.policy, lookup(var.iam_role_policy[count.index], "policy_id"))
  role   = element(var.role, lookup(var.iam_role_policy[count.index], "role_id"))
}