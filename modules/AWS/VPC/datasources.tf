data "aws_vpc_endpoint_service" "s3" {
  count   = length(var.endpoint)
  service = lookup(var.endpoint[count.index],"service")
}