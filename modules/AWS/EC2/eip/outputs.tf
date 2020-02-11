output "eip_id" {
  value = aws_eip.eip.*.id
}