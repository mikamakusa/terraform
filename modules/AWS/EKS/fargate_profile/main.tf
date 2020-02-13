resource "aws_eks_fargate_profile" "fargate_profile" {
  count                  = length(var.fargate_profile)
  cluster_name           = element(var.cluster_name, lookup(var.fargate_profile[count.index], "cluster_id"))
  fargate_profile_name   = lookup(var.fargate_profile[count.index], "fargate_profile_name")
  pod_execution_role_arn = element(var.role_arn, lookup(var.fargate_profile[count.index], "role_id"))
  subnet_ids             = element(var.subnet_id, lookup(var.fargate_profile[count.index], "subnet_id"))

  dynamic "selector" {
    for_each = lookup(var.fargate_profile[count.index], "selector")
    content {
      namespace = lookup(selector.value, "namespace")
      labels    = lookup(selector.value, 'labels')
    }
  }
}