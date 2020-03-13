output "id" {
  value = aws_appmesh_route.route.*.id
}

output "arn" {
  value = aws_appmesh_route.route.*.arn
}

output "created_date" {
  value = aws_appmesh_route.route.*.created_date
}

output "last_updated_date" {
  value = aws_appmesh_route.route.*.last_updated_date
}