resource "aws_internet_gateway" "aws_gw" {
  count  = length(var.internet_gateway)
  vpc_id = element(var.vpc_id, lookup(var.internet_gateway[count.index], "vpc_id"))
  tags   = var.tags
}