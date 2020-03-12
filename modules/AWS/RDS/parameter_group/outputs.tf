output "name" {
  value = aws_db_parameter_group.parameter_group.*.name
}