resource "aws_subnet" "subnet" {
  count                   = length(var.subnet)
  cidr_block              = lookup(var.subnet[count.index],"cidr_block")
  vpc_id                  = var.vpc_id
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = lookup(var.subnet[count.index],"map_public_ip_on_launch")
  tags                    = lookup(var.subnet[count.index],"tags")
}