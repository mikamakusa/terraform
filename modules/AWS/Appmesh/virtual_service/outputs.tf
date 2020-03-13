output "id" {
  value = aws_appmesh_virtual_service.virtual_service.*.id
}

output "arn" {
  value = aws_appmesh_virtual_service.virtual_service.*.arn
}

output "created_date" {
  value = aws_appmesh_virtual_service.virtual_service.*.created_date
}

output "last_updated_date" {
  value = aws_appmesh_virtual_service.virtual_service.*.last_updated_date
}