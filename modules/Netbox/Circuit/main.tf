resource "netbox_circuit_provider" "circuit_provider" {
  count = length(var.circuit_provider)
  name  = lookup(var.circuit_provider[count.index], "name")
  slug  = lookup(var.circuit_provider[count.index], "slug")
}

resource "netbox_tenant" "tenant" {
  count = length(var.tenant)
}

resource "netbox_circuit_type" "circuit_type" {
  count = length(var.circuit_type)
  name  = lookup(var.circuit_type[count.index], "name")
  slug  = lookup(var.circuit_type[count.index], "slug")
}

resource "netbox_circuit" "circuit" {
  count       = length(var.circuit)
  provider_id = element(netbox_circuit_provider.circuit_provider.*.id, lookup(var.circuit[count.index], "provider_id"))
  status      = lookup(var.circuit[count.index], "status")
  type_id     = element(netbox_circuit_type.circuit_type.*.id, lookup(var.circuit[count.index], "type_id"))
  tenant_id   = element(netbox_tenant.tenant.*.id, lookup(var.circuit[count.index], "tenant_id"))
}