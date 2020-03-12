output "name" {
  value = aws_db_subnet_group.db_subnet_group.*.name
}