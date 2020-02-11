resource "aws_internet_gateway" "aws_gw" {
  count  = length(var.internet_gateway)
  vpc_id = var.vpc_id
  tags   = lookup(var.internet_gateway[count.index], "tags", null)
}