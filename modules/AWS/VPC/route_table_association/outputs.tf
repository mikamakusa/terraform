output "route_table_association_id" {
  value = aws_route_table_association.route_table_association.*.id
}