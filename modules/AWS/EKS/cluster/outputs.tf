output "eks_cluster_name" {
  value = aws_eks_cluster.eks_cluster.*.name
}