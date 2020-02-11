resource "aws_nat_gateway" "nat_gateway" {
  count         = length(var.nat_gateway)
  allocation_id = element(var.eip_id, lookup(var.nat_gateway[count.index], "allocation_id"))
  subnet_id     = element(var.subnet_id, lookup(var.nat_gateway[count.index], "subnet_id"))
}