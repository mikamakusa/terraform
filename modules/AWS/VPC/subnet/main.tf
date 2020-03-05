data "aws_availability_zones" "az" {
  state = "available"
}

resource "aws_subnet" "subnet" {
  count                   = length(var.subnet)
  cidr_block              = lookup(var.subnet[count.index], "cidr_block")
  vpc_id                  = element(var.vpc_id, lookup(var.subnet[count.index], "vpc_id"))
  map_public_ip_on_launch = lookup(var.subnet[count.index], "map_public_ip_on_launch", false)
  availability_zone       = data.aws_availability_zones.az.names[lookup(var.subnet[count.index], "availability_zone_id")]
  tags                    = var.tags
}