resource "netbox_prefix" "prefix" {
  count         = length(var.prefix)
  prefix        = lookup(var.prefix[count.index], "prefix")
  status        = lookup(var.prefix[count.index], "status")
  description   = lookup(var.prefix[count.index], "description", null)
  is_pool       = tobool(lookup(var.prefix[count.index], "is_pool", null))
  mark_utilized = tobool(lookup(var.prefix[count.index], "mark_utilized", null))
  role_id       = element(netbox_ipam_role.ipam_role.*.id, lookup(var.prefix[count.index], "role_id"))
  #site_id       = ""
  tags          = lookup(var.prefix[count.index], "tags", [])
  tenant_id     = element(var.tenant, lookup(var.prefix[count.index], "tenant_id", null))
  vlan_id       = element(netbox_vlan.vlan.*.id, lookup(var.prefix[count.index], "vlan_id"))
  vrf_id        = element(netbox_vrf.vrf.*.id, lookup(var.prefix[count.index], "vrf_id", null))
}

resource "netbox_vlan" "vlan" {
  count       = length(var.vlan)
  name        = lookup(var.vlan[count.index], "name")
  vid         = tonumber(lookup(var.vlan[count.index], "vid"))
  description = lookup(var.vlan[count.index], "description", null)
  role_id     = element(netbox_ipam_role.ipam_role.*.id, lookup(var.vlan[count.index], "role_id", null))
  #site_id     = ""
  status      = lookup(var.vlan[count.index], "status", "active")
  tags        = lookup(var.vlan[count.index], "tags", [])
  tenant_id   = element(var.tenant, lookup(var.vlan[count.index], "tenant_id", null))
}

resource "netbox_ipam_role" "ipam_role" {
  count      = length(var.ipam_role)
  name       = lookup(var.ipam_role[count.index], "name")
  decription = lookup(var.ipam_role[count.index], "description", null)
  slug       = lookup(var.ipam_role[count.index], "slug", null)
  weight     = tonumber(lookup(var.ipam_role[count.index], "weight", null))
}

resource "netbox_ip_range" "ip_range" {
  count         = length(var.ip_range)
  start_address = lookup(var.ip_range[count.index], "start_address")
  end_address   = lookup(var.ip_range[count.index], "end_address")
  description   = lookup(var.ip_range[count.index], "decription", null)
  role_id       = element(netbox_ipam_role.ipam_role.*.id, lookup(var.ip_range[count.index], "role_id"))
  status        = lookup(var.ip_range[count.index], "status", "active")
  tags          = lookup(var.ip_range[count.index], "tags", [])
  tenant_id     = element(var.tenant, lookup(var.ip_range[count.index], "tenant_id", null))
  vrf_id        = element(netbox_vrf.vrf.*.id, lookup(var.ip_range[count.index], "vrf_id", null))
}

resource "netbox_interface" "interface" {
  count              = length(var.interface)
  name               = lookup(var.interface[count.index], "name")
  virtual_machine_id = element(var.virtual_machine, lookup(var.interface[count.index], "virtual_machine_id"))
  description        = lookup(var.interface[count.index], "description", null)
  enabled            = tobool(lookup(var.interface[count.index], "enabled", true))
  mac_address        = lookup(var.interface[count.index], "mac_address", null)
  mode               = lookup(var.interface[count.index], "mode", null)
  mtu                = tonumber(lookup(var.interface[count.index], "mtu", null))
  tagged_vlans       = tonumber(lookup(var.interface[count.index], "tagged_vlans", []))
  tags               = lookup(var.interface[count.index], "tags", [])
  untagged_vlans     = tonumber(lookup(var.interface[count.index], "untagged_vlans", []))
}

resource "netbox_vrf" "vrf" {
  count     = length(var.vrf)
  name      = lookup(var.vrf[count.index], "name")
  tenant_id = element(var.tenant, lookup(var.vrf[count.index], "tenant_id"))
}

resource "netbox_available_ip_address" "available_ip_address" {
  count        = length(var.available_ip_address)
  prefix_id    = element(netbox_prefix.prefix.*.id, lookup(var.available_ip_address[count.index], "prefix_id", null))
  ip_range_id  = element(netbox_ip_range.ip_range.*.id, lookup(var.available_ip_address[count.index], "ip_range_id", null))
  description  = lookup(var.available_ip_address[count.index], "description", null)
  dns_name     = lookup(var.available_ip_address[count.index], "dns_name", null)
  interface_id = element(netbox_interface.interface.*.id, lookup(var.available_ip_address[count.index], "interface_id", null))
  status       = lookup(var.available_ip_address[count.index], "status", "active")
  tags         = lookup(var.available_ip_address[count.index], "tags", [])
  tenant_id    = element(var.tenant, lookup(var.available_ip_address[count.index], "tenant_id", null))
  vrf_id       = element(netbox_vrf.vrf.*.id, lookup(var.available_ip_address[count.index], "vrf_id", null))
}