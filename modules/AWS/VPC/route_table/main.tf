resource "aws_route_table" "aws_route_table" {
  count  = var.route_table
  vpc_id = var.vpc_id

  dynamic "route" {
    for_each = lookup(var.route_table[count.index], "route")
    content {
      cidr_block     = lookup(route.value, "cidr_block")
      gateway_id     = element(var.gateway_id, lookup(route.value, "gateway_id", null))
      nat_gateway_id = element(var.nat_gateway_id, lookup(route.value, "nat_gateway_id", null))
    }
  }

  tags = var.tags
}