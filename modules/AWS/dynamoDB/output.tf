output "DynamoDB_Global_Table_ID" {
  value = aws_dynamodb_global_table.aws_global_table.id
}

output "DynamoDB_Global_table_Name" {
  value = aws_dynamodb_global_table.aws_global_table.name
}

output "DynamoDB_arn" {
  value = aws_dynamodb_table.aws_dynamodb_table.arn
}