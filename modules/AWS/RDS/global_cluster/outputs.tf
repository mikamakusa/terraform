output "arn" {
  value = aws_rds_global_cluster.global_cluster.*.arn
}

output "global_cluster_resource_id" {
  value = aws_rds_global_cluster.global_cluster.*.global_cluster_resource_id
}

output "id" {
  value = aws_rds_global_cluster.global_cluster.*.id
}