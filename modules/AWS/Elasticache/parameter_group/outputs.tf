output "parameter_group_name" {
  value = aws_elasticache_parameter_group.parameter_group.*.name
}