resource "aws_route_table" "aws_route_table" {
  count  = var.route_table
  vpc_id = var.vpc_id
}