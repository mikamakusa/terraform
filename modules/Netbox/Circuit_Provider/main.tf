resource "netbox_circuit_provider" "circuit_provider" {
  count = length(var.circuit_provider)
  name  = lookup(var.circuit_provider[count.index], "name")
  slug  = lookup(var.circuit_provider[count.index], "slug")
}