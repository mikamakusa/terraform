resource "aws_iam_role_policy" "iam_role_policy" {
  count  = length(var.iam_role_policy)
  policy = file(join(".", [join("/", [path.cwd, "policy", lookup(var.iam_role_policy[count.index], "name")]), "json"]))
  role   = element(var.role, lookup(var.iam_role_policy[count.index], "role_id"))
}