output "cluster_id" {
  value = aws_cluster.cluster.*.id
}