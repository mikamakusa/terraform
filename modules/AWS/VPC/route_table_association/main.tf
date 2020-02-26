resource "aws_route_table_association" "route_table_association" {
  count          = length(var.route_table_association)
  route_table_id = element(var.route_table_id, lookup(var.route_table_association[count.index], "route_table_id"))
  subnet_id      = element(var.subnet_id, lookup(var.route_table_association[count.index], "subnet_id"))
}