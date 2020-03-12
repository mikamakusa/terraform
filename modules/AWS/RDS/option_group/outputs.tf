output "name" {
  value = aws_db_option_group.option_group.*.name
}