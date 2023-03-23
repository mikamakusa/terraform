resource "netbox_circuit_provider" "circuit_provider" {
  count = length(var.circuit_provider)
  name  = lookup(var.circuit_provider[count.index], "name")
  slug  = lookup(var.circuit_provider[count.index], "slug")
}

resource "netbox_tenant" "tenant" {
  count = length(var.tenant)
  name  = lookup(var.tenant[count.index], "name")
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

resource "netbox_site" "site" {
  count  = length(var.site)
  name   = lookup(var.site[count.index], "name")
  slug   = lookup(var.site[count.index], "slug")
  status = lookup(var.site[count.index], "status")
}

resource "netbox_circuit_termination" "circuit_termination" {
  count          = length(var.circuit_termination)
  circuit_id     = element(netbox_circuit.circuit.*.id, lookup(var.circuit_termination[count.index], "circuit_id"))
  site_id        = element(netbox_site.site.*.id, lookup(var.circuit_termination[count.index], "site_id"))
  term_side      = lookup(var.circuit_termination[count.index], "term_side")
  custom_fields  = lookup(var.circuit_termination[count.index], "custom_fields")
  port_seed      = lookup(var.circuit_termination[count.index], "port_seed")
  tags           = lookup(var.circuit_termination[count.index], "tags")
  upstream_speed = lookup(var.circuit_termination[count.index], "upstream_speed")
}