output "mesh_id" {
  value = try(
    oci_service_mesh_mesh.this.*.id
  )
}

output "virtual_service_id" {
  value = try(
    oci_service_mesh_virtual_service.this.*.id
  )
}

output "ingress_gateway_id" {
  value = try(
    oci_service_mesh_ingress_gateway.this.*.id
  )
}

output "access_policy_id" {
  value = try(
    oci_service_mesh_access_policy.this.*.id
  )
}

output "access_policy_rules" {
  value = try(
    oci_service_mesh_access_policy.this.*.rules
  )
}

output "virtual_deployment_id" {
  value = try(
    oci_service_mesh_virtual_deployment.this.*.id
  )
}

output "virtual_service_route_table_id" {
  value = try(
    oci_service_mesh_virtual_service_route_table.this.*.id
  )
}

output "ingress_gateway_route_table_id" {
  value = try(
    oci_service_mesh_ingress_gateway_route_table.this.*.id
  )
}