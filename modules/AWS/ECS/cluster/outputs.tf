output "cluster_id" {
  value = aws_ecs_cluster.cluster.*.id
}