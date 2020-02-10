output "parameter_group_name" {
  value = aws_docdb_cluster_parameter_group.parameter_group.*.name
}