output "circuit_provider_id" {
  value = netbox_circuit_provider.circuit_provider.*.id
}