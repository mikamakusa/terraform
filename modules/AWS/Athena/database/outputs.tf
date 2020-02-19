output "athena_database_name" {
  value = aws_athena_database.athena_database.*.name
}