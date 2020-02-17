resource "aws_ecr_repository_policy" "repository_policy" {
  count      = length(var.repository_policy)
  policy     = file(join("/", [path.cwd, "policy", lookup(var.repository_policy[count.index], "policy")]))
  repository = element(var.repository_name, lookup(var.repository_policy[count.index], "repository_id"))
}