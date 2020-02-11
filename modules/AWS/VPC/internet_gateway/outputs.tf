output "intenet_gateway_id" {
  value = aws_internet_gateway.aws_gw.*.id
}