output "circuit_id" {
  value = netbox_circuit.circuit.*.id
}

output "tenant_id" {
  value = netbox_tenant.tenant.*.id
}

output "circuit_type_id" {
  value = netbox_circuit_type.circuit_type.*.id
}

output "circuit_provider_id" {
  value = netbox_circuit_provider.circuit_provider.*.id
}