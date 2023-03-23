output "circuit_type_id" {
  value = netbox_circuit_type.circuit_type.*.id
}