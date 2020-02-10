output "transfer_user_name" {
  value = aws_transfer_user.transfer_user.*.user_name
}