resource "aws_ecr_lifecycle_policy" "lifecycle_policy" {
  count      = length(var.lifecycle_policy)
  policy     = file(join("/", [path.cwd, "policy", lookup(var.lifecycle_policy[count.index], "policy")]))
  repository = element(var.repository_name, lookup(var.lifecycle_policy[count.index], "repository_id"))
}