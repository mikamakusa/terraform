resource "aws_vpc" "aws_vpc" {
  count                          = length(var.aws_vpc)
  cidr_block                     = lookup(var.aws_vpc[count.index], "cidr_block")
  instance_tenancy               = lookup(var.aws_vpc[count.index], "instance_tenancy", null)
  enable_dns_support             = lookup(var.aws_vpc[count.index], "enable_dns_support", null)
  enable_dns_hostnames           = lookup(var.aws_vpc[count.index], "enable_dns_hostnames", null)
  enable_classiclink             = lookup(var.aws_vpc[count.index], "enable_classiclink", null)
  enable_classiclink_dns_support = lookup(var.aws_vpc[count.index], "enable_classiclink_dns_support", null)
  tags                           = lookup(var.aws_vpc[count.index], "tags", null)
}

resource "aws_internet_gateway" "aws_gw" {
  count  = "${length(var.aws_vpc)}" == "0" ? "0" : "${length(var.internet_gateway)}"
  vpc_id = element(aws_vpc.aws_vpc.*.id, lookup(var.internet_gateway[count.index], "vpc_id"))
  tags   = lookup(var.internet_gateway[count.index], "tags", null)
}

resource "aws_route_table" "aws_route_table" {
  count  = "${length(var.aws_vpc)}" == "0" ? "0" : "${length(var.route_table)}"
  vpc_id = element(aws_vpc.aws_vpc.*.id, lookup(var.route_table[count.index], "vpc_id"))
}

resource "aws_route" "aws_route" {
  count                  = "${length(var.aws_vpc)}" == "0" ? "0" : "${length(var.route)}"
  route_table_id         = element(aws_route_table.aws_route_table.*.id, lookup(var.route[count.index], "route_table_id"))
  destination_cidr_block = lookup(var.route[count.index], "destination_cidr_block", null)
  gateway_id             = element(aws_internet_gateway.aws_gw.*.id, lookup(var.route[count.index], "gateway_id", null))
}

resource "aws_default_security_group" "default_security_group" {
  count  = "${length(var.aws_vpc)}" == "0" ? "0" : "${length(var.default_sg)}"
  vpc_id = element(aws_vpc.aws_vpc.*.id, lookup(var.default_sg[count.index], "vpc_id"))

  dynamic "ingress" {
    for_each = lookup(var.default_sg[count.index], "ingress")
    content {
      self      = true
      from_port = lookup(ingress.value, "from_port")
      to_port   = lookup(ingress.value, "to_port")
      protocol  = lookup(ingress.value, "protocol")
    }
  }

  dynamic "egress" {
    for_each = lookup(var.default_sg[count.index], "egress")
    content {
      self        = true
      from_port   = lookup(egress.value, "from_port")
      to_port     = lookup(egress.value, "to_port")
      protocol    = lookup(egress.value, "protocol")
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

resource "aws_vpc_endpoint" "aws_vpc_endpoint" {
  count             = "${length(var.aws_vpc)}" == "0" ? "0" : "${length(var.endpoint)}"
  service_name      = "com.amazonaws.${var.region}.${lookup(var.endpoint[count.index], "service_name")}"
  vpc_id            = element(aws_vpc.aws_vpc.*.id, lookup(var.endpoint[count.index], "vpc_id"))
  vpc_endpoint_type = lookup(var.endpoint[count.index], "vpc_endpoint_type", null)
}

resource "aws_vpc_endpoint_route_table_association" "aws_vpc_endpoint_route_table_association" {
  count           = length(var.route_table_association)
  route_table_id  = element(aws_route_table.aws_route_table.*.id, lookup(var.route_table_association[count.index], "route_table_id"))
  vpc_endpoint_id = element(aws_vpc_endpoint.aws_vpc_endpoint.*.id, lookup(var.route_table_association[count.index], "vpc_endpoint_id"))
}


resource "aws_eip" "aws_eip" {
  count                     = length(var.eip)
  vpc                       = lookup(var.eip[count.index],"vpc", null)
  instance                  = lookup(var.eip[count.index],"instance", null)
  network_interface         = lookup(var.eip[count.index],"network_interface", null)
  associate_with_private_ip = lookup(var.eip[count.index],"associate_with_private_ip", null)
  public_ipv4_pool          = lookup(var.eip[count.index],"public_ipv4_pool", null)
}