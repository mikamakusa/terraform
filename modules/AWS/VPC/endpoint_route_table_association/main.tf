resource "aws_vpc_endpoint_route_table_association" "endpoint_route_table_association" {
  count           = length(var.endpoint_route_table_association)
  route_table_id  = element(var.route_table_id, lookup(var.endpoint_route_table_association[count.index], "route_table_id"))
  vpc_endpoint_id = element(var.vpc_endpoint_id, lookup(var.endpoint_route_table_association[count.index], "vpc_endpoint_id"))
}