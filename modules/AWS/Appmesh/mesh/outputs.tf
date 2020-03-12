output "id" {
  value = aws_appmesh_mesh.mesh.*.id
}

output "arn" {
  value = aws_appmesh_mesh.mesh.*.arn
}

output "created_date" {
  value = aws_appmesh_mesh.mesh.*.created_date
}

output "last_updated_date" {
  value = aws_appmesh_mesh.mesh.*.last_updated_date
}