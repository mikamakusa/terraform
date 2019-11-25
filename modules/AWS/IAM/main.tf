resource "aws_iam_role" "iam_role" {
  count = length(var.iam_role)
  assume_role_policy = lookup(var.iam_role[count.index], "assume_role_policy")
}

resource "aws_iam_role_policy" "iam_role_policy" {
  count = length(var.iam_role) == "0" ? "0" : length(var.iam_role_policy)
  policy = lookup(var.iam_role_policy[count.index], "policy")
  role = "${element(aws_iam_role.iam_role.*.id, lookup(var.iam_role_policy[count.index], "role_id"))}"
}

resource "aws_iam_group" "iam_group" {
  name = ""
}

resource "aws_iam_user" "iam_user" {
  count = length(var.iam_user)
  name = lookup(var.iam_user[count.index], "name")
}

resource "aws_iam_user_group_membership" "" {
  groups = []
  user = ""
}