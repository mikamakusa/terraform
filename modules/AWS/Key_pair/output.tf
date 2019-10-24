output "aws_keypay_id" {
  value = aws_key_pair.aws_keypair.id
}

output "aws_key_name" {
  value = aws_key_pair.aws_keypair.key_name
}