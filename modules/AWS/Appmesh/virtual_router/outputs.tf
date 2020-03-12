output "id" {
  value = aws_appmesh_virtual_router.virtual_router.*.id
}

output "arn" {
  value = aws_appmesh_virtual_router.virtual_router.*.arn
}

output "created_date" {
  value = aws_appmesh_virtual_router.virtual_router.*.created_date
}

output "last_updated_date" {
  value = aws_appmesh_virtual_router.virtual_router.*.last_updated_date
}