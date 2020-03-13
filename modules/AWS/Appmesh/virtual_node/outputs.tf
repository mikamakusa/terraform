output "id" {
  value = aws_appmesh_virtual_node.virtual_node.*.id
}

output "arn" {
  value = aws_appmesh_virtual_node.virtual_node.*.arn
}

output "created_date" {
  value = aws_appmesh_virtual_node.virtual_node.*.created_date
}

output "last_updated_date" {
  value = aws_appmesh_virtual_node.virtual_node.*.last_updated_date
}