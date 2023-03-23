resource "netbox_rir" "rir" {
  count = length(var.rir)
  name  = lookup(var.rir[count.index], "name")
  slug  = lookup(var.rir[count.index], "slug")
}

resource "netbox_tenant_group" "tenant_group" {
  count       = length(var.tenant_group)
  name        = lookup(var.tenant_group[count.index], "name")
  description = lookup(var.tenant_group[count.index], "description", null)
  parent_id   = element(netbox_tenant_group.tenant_group.*.id, lookup(var.tenant_group[count.index], "parent_id", null))
  slug        = lookup(var.tenant_group[count.index], "slug", null)
}

resource "netbox_tenant" "tenant" {
  count       = length(var.tenant)
  name        = lookup(var.tenant[count.index], "name")
  description = lookup(var.tenant[count.index], "description", null)
  group_id    = element(netbox_tenant_group.tenant_group.*.id, lookup(var.tenant[count.index], "group_id", null))
  slug        = lookup(var.tenant[count.index], "slug", null)
  tags        = lookup(var.tenant[count.index], "tags", [])
}

resource "netbox_aggregate" "aggregate" {
  count       = length(var.aggregate)
  prefix      = lookup(var.aggregate[count.index], "prefix")
  description = lookup(var.aggregate[count.index], "description", null)
  rir_id      = element(netbox_rir.rir.*.id, lookup(var.aggregate[count.index], "rir_id"))
  tags        = lookup(var.aggregate[count.index], "tags", [])
  tenant_id   = element(netbox_tenant.tenant.*.id, lookup(var.aggregate[count.index], "tenant_id"))
}