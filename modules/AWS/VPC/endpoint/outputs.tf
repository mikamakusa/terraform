output "endpoint_id" {
  value = aws_vpc_endpoint.aws_vpc_endpoint.*.id
}