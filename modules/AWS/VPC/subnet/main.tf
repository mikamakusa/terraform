resource "aws_subnet" "subnet" {
  count                   = length(var.subnet)
  cidr_block              = lookup(var.subnet[count.index], "cidr_block")
  vpc_id                  = element(var.vpc_id, lookup(var.subnet[count.index], "vpc_id"))
  availability_zone       = lookup(var.subnet[count.index], "availability_zone")
  map_public_ip_on_launch = lookup(var.subnet[count.index], "map_public_ip_on_launch", false)
  tags                    = var.tags
}