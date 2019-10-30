resource "aws_vpc" "aws_vpc" {
  count                          = length(var.aws_vpc)
  cidr_block                     = lookup(var.aws_vpc[count.index], "cidr_block")
  instance_tenancy               = lookup(var.aws_vpc[count.index], "instance_tenancy")
  enable_dns_support             = lookup(var.aws_vpc[count.index], "enable_dns_support")
  enable_dns_hostnames           = lookup(var.aws_vpc[count.index], "enable_dns_hostnames")
  enable_classiclink             = lookup(var.aws_vpc[count.index], "enable_classiclink")
  enable_classiclink_dns_support = lookup(var.aws_vpc[count.index], "enable_classiclink_dns_support")
  tags                           = lookup(var.aws_vpc[count.index], "tags")
}

resource "aws_internet_gateway" "aws_gw" {
  count  = "${ "${length(var.aws_vpc)}" == "0" ? "0" : "${length(var.internet_gateway)}" }"
  vpc_id = element(aws_vpc.aws_vpc.*.id,lookup(var.internet_gateway[count.index], "vpc_id"))
  tags   = lookup(var.internet_gateway[count.index], "tags")
}

resource "aws_route_table" "aws_route_table" {
  count  = "${ "${length(var.aws_vpc)}" == "0" ? "0" : "${length(var.route_table)}" }"
  vpc_id = element(aws_vpc.aws_vpc.*.id,lookup(var.route_table[count.index], "vpc_id"))
}

resource "aws_route" "aws_route" {
  count                     = "${ "${length(var.aws_vpc)}" == "0" ? "0" : "${length(var.route)}" }"
  route_table_id            = element(aws_route_table.aws_route_table.*.id,lookup(var.route[count.index], "route_table_id"))
  destination_cidr_block    = lookup(var.route[count.index],"destination_cidr_block")
}