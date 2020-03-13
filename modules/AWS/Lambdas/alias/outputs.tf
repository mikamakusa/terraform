output "arn" {
  value = aws_lambda_alias.alias.*.arn
}

output "invoke_arn" {
  value = aws_lambda_alias.alias.*.invoke_arn
}