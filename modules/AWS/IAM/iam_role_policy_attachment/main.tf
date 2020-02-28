resource "aws_iam_role_policy_attachment" "iam_policy_attachement" {
  count      = length(var.iam_role_policy_attachment)
  policy_arn = lookup(var.iam_role_policy_attachment[count.index], "policy_arn")
  role       = element(var.iam_role, lookup(var.iam_role_policy_attachment[count.index], "iam_role_id"))
}