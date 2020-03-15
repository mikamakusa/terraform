resource "aws_codecommit_repository" "repository" {
  count           = length(var.repository)
  repository_name = lookup(var.repository[count.index], "repository_name")
  description     = lookup(var.repository[count.index], "description", null)
  default_branch  = lookup(var.repository[count.index], "default_branch", null)
  tags            = var.tags
}