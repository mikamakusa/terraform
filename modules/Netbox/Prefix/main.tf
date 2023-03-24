resource "netbox_prefix" "prefix" {
  count         = length(var.prefix)
  prefix        = lookup(var.prefix[count.index], "prefix")
  status        = lookup(var.prefix[count.index], "status")
  description   = lookup(var.prefix[count.index], "description", null)
  is_pool       = tobool(lookup(var.prefix[count.index], "is_pool", null))
  mark_utilized = tobool(lookup(var.prefix[count.index], "mark_utilized", null))
  role_id       = element(var.role_id, lookup(var.prefix[count.index], "role_id", null))
  site_id       = element(var.site_id, lookup(var.prefix[count.index], "site_id", null))
  tags          = lookup(var.prefix[count.index], "tags", [])
  tenant_id     = element(var.tenant_id, lookup(var.prefix[count.index], "tenant_id", null))
  vlan_id       = element(var.vlan_id, lookup(var.prefix[count.index], "vlan_id", null))
  vrf_id        = element(var.vrf_id, lookup(var.prefix[count.index], "vrf_id", null))
}