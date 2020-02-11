resource "aws_route" "route" {
  count                     = length(var.route)
  route_table_id            = element(var.route_table_id, lookup(var.route[count.index], "route_table_id"))
  destination_cidr_block    = lookup(var.route[count.index], "destination_cidr_block")
  gateway_id                = element(var.gateway_id, lookup(var.route[count.index], "gateway_id"))
  nat_gateway_id            = element(var.nat_gateway_id, lookup(var.route[count.index], "nat_gateway_id"))
  network_interface_id      = element(var.network_interface_id, lookup(var.route[count.index], "network_interface_id"))
  transit_gateway_id        = element(var.transit_gateway_id, lookup(var.route[count.index], "transit_gateway_id"))
  vpc_peering_connection_id = element(var.vpc_peering_connection_id, lookup(var.route[count.index], "vpc_peering_connection_id"))
  egress_only_gateway_id    = element(var.egress_only_gateway_id, lookup(var.route[count.index], "egress_only_gateway_id"))
}