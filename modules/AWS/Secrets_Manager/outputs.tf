output "secrets_id" {
  value = aws_secretsmanager_secret.secret.*.id
}

output "secrets_arn" {
  value = aws_secretsmanager_secret.secret.*.arn
}

