data "aws_eks_cluster" "this" {
  count = var.aks_cluster_name ? 1 : 0
  name  = var.aks_cluster_name
}

data "aws_cloudwatch_log_group" "this" {
  count = var.cloudwatch_log_group ? 1 : 0
  name  = var.cloudwatch_log_group
}