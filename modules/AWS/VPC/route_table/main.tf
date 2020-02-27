resource "aws_route_table" "aws_route_table" {
  count  = length(var.route_table)
  vpc_id = element(var.vpc_id, lookup(var.route_table[count.index], "vpc_id"))

  dynamic "route" {
    for_each = lookup(var.route_table[count.index], "route")
    content {
      cidr_block     = lookup(route.value, "cidr_block")
      gateway_id     = lookup(route.value, "gateway_id") == "" ? "" : element(var.gateway_id, lookup(route.value, "gateway_id"))
      nat_gateway_id = lookup(route.value, "nat_gateway_id") == "" ? "" : element(var.nat_gateway_id, lookup(route.value, "nat_gateway_id"))
    }
  }

  tags = var.tags
}