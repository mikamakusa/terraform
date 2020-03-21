output "id" {
  value = aws_db_cluster_parameter_group.cluster_parameter_group.*.id
}

output "arn" {
  value = aws_db_cluster_parameter_group.cluster_parameter_group.*.arn
}