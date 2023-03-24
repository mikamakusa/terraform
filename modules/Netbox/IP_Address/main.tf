resource "netbox_ip_address" "ip_address" {
  count        = length(var.ip_address)
  ip_address   = lookup(var.ip_address[count.index], "ip_address")
  status       = lookup(var.ip_address[count.index], "status")
  dns_name     = lookup(var.ip_address[count.index], "dns_name", null)
  interface_id = element(var.interface_id, lookup(var.ip_address[count.index], "interface_id"))
  object_type  = lookup(var.ip_address[count.index], "object_type", "virtualization.vminterface")
  role         = lookup(var.ip_address[count.index], "role")
  tags         = lookup(var.ip_address[count.index], "tags", [])
  tenant_id    = element(var.tenant_id, lookup(var.ip_address[count.index], "tenant_id"))
  vrf_id       = element(var.vrf_id, lookup(var.ip_address[count.index], "vrf_id"))
}