output "transfer_server_arn" {
  value = aws_transfer_server.transfer_server.*.arn
}

output "transfer_server_endpoint" {
  value = aws_transfer_server.transfer_server.*.endpoint
}

output "transfer_server_id" {
  value = aws_transfer_server.transfer_server.*.id
}