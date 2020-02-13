resource "aws_eks_cluster" "eks_cluster" {
  count                     = length(var.eks_cluster)
  name                      = lookup(var.eks_cluster[count.index], "name")
  role_arn                  = element(var.role_arn, lookup(var.eks_cluster[count.index], "iam_role_id"))
  enabled_cluster_log_types = [lookup(var.eks_cluster[count.index], "enabled_cluster_log_types", null)]
  version                   = lookup(var.eks_cluster[count.index], "version", null)

  dynamic "vpc_config" {
    for_each = lookup(var.eks_cluster[count.index], "vpc_config")
    content {
      endpoint_private_access = lookup(vpc_config.value, "endpoint_private_access", null)
      endpoint_public_access  = lookup(vpc_config.value, "endpoint_public_access", null)
      security_group_ids      = [element(var.security_group_id, lookup(var.eks_cluster[count.index], "security_group_id"))]
      subnet_ids              = [element(var.subnet_id, lookup(var.eks_cluster[count.index], "subnet_id"))]
    }
  }

  tags = lookup(var.eks_cluster[count.index], "tags", null)
}
