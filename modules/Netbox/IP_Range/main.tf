resource "netbox_ip_range" "ip_range" {
  count         = length(var.ip_range)
  start_address = lookup(var.ip_range[count.index], "start_address")
  end_address   = lookup(var.ip_range[count.index], "end_address")
  tags          = lookup(var.ip_range[count.index], "tags", [])
  role_id       = element(var.role_id, lookup(var.ip_range[count.index], "role_id", null))
  status        = lookup(var.ip_range[count.index], "status", "active")
  tenant_id     = element(var.tenant_id, lookup(var.ip_range[count.index], "tenant_id", null))
  vrf_id        = element(var.vrf_id, lookup(var.ip_range[count.index], "vrf_id", null))
}