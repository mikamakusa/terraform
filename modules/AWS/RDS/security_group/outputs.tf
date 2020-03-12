output "id" {
  value = aws_db_security_group.security_group.*.id
}

output "arn" {
  value = aws_db_security_group.security_group.*.arn
}