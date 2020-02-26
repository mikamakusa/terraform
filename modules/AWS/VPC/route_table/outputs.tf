output "route_table_id" {
  value = aws_route_table.aws_route_table.*.id
}