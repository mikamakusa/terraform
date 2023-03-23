resource "netbox_circuit_type" "circuit_type" {
  count = length(var.circuit_type)
  name  = lookup(var.circuit_type[count.index], "name")
  slug  = lookup(var.circuit_type[count.index], "slug")
}