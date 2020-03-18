resource "aws_codedeploy_app" "app" {
  count            = length(var.app)
  name             = lookup(var.app[count.index], "name")
  compute_platform = lookup(var.app[count.index], "compute_platform")
}