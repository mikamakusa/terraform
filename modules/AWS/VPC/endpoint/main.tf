resource "aws_vpc_endpoint" "aws_vpc_endpoint" {
  count             = length(var.endpoint)
  service_name      = "com.amazonaws.${var.region}.${lookup(var.endpoint[count.index], "service_name")}"
  vpc_id            = element(var.vpc_id, lookup(var.endpoint[count.index], "vpc_id"))
  vpc_endpoint_type = lookup(var.endpoint[count.index], "vpc_endpoint_type", null)
}