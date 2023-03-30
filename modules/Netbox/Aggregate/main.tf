resource "netbox_rir" "rir" {
  count = length(var.rir)
  name  = lookup(var.rir[count.index], "name")
  slug  = lookup(var.rir[count.index], "slug")
}

resource "netbox_aggregate" "aggregate" {
  count       = length(var.aggregate)
  prefix      = lookup(var.aggregate[count.index], "prefix")
  description = lookup(var.aggregate[count.index], "description", null)
  rir_id      = element(netbox_rir.rir.*.id, lookup(var.aggregate[count.index], "rir_id"))
  tags        = lookup(var.aggregate[count.index], "tags", [])
  tenant_id   = data.netbox_tenant.tenant.id != null ? data.netbox_tenant.tenant.id : ""
}