resource "aws_iam_policy" "iam_policy" {
  count       = length(var.iam_policy)
  name        = lookup(var.iam_policy[count.index], "name")
  policy      = "${file(path.cwd)}/policy/${lookup(var.iam_policy[count.index], "name")}.json"
  path        = lookup(var.iam_policy[count.index], "path", null)
}