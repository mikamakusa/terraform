resource "aws_iam_role" "iam_role" {
  count                 = length(var.iam_role)
  name                  = lookup(var.iam_role[count.index], "name", null)
  assume_role_policy    = file(join(".", [join("/", [path.cwd, "role", lookup(var.iam_role[count.index], "policy")]), "json"]))
  permissions_boundary  = lookup(var.iam_role[count.index], "permissions_boundary", null)
  path                  = lookup(var.iam_role[count.index], "path", null)
  force_detach_policies = lookup(var.iam_role[count.index], "force_detach_policies", true)
  tags                  = lookup(var.iam_role[count.index], "tags", null)
}