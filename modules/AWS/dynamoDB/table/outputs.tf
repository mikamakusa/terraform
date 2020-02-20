output "dynamodb_table_name" {
  value = aws_dynamodb_table.aws_dynamodb_table.*.name
}

output "dynamod_table_hash_key" {
  value = aws_dynamodb_table.aws_dynamodb_table.*.hash_key
}