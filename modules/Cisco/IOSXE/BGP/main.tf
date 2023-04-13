resource "iosxe_bgp" "bgp" {
  for_each             = toset(keys({ for k, v in var.bgp : k => v }))
  asn                  = var.bgp[each.value]["asn"]
  default_ipv4_unicast = var.bgp[each.value]["default_ipv4_unicast"]
  log_neighbor_changes = var.bgp[each.value]["log_neighbor_changes"]
  router_id_loopback   = var.bgp[each.value]["router_id_loopback"]
  device               = var.bgp[each.value]["devices"]
}

resource "iosxe_bgp_address_family_ipv4_vrf" "address_family" {
  for_each = toset(keys({ for key, value in var.address_family : key => value if each.value.ipv4 == true }))
  asn      = var.address_family[each.value]["asn"]
  af_name  = var.address_family[each.value]["af_name"]
  device   = var.address_family[each.value]["device"]
  vrfs     = var.address_family[each.value]["vrfs"]
}

resource "iosxe_bgp_address_family_ipv6_vrf" "address_family" {
  for_each = toset(keys({ for key, value in var.address_family : key => value if each.value.ipv4 == false }))
  asn      = var.address_family[each.value]["asn"]
  af_name  = var.address_family[each.value]["af_name"]
  device   = var.address_family[each.value]["device"]
  vrfs     = var.address_family[each.value]["vrfs"]
}

resource "iosxe_bgp_address_family_l2vpn" "l2vpn" {
  for_each = toset(keys({ for key, value in var.address_family : key => value if each.value.ipv4 == false }))
  asn      = var.address_family[each.value]["asn"]
  af_name  = var.address_family[each.value]["af_name"]
  device   = var.address_family[each.value]["device"]
}

resource "iosxe_bgp_ipv4_unicast_neighbor" "unicast" {
  for_each               = toset(keys({ for key, value in var.neighbor : key => value if each.value.unicast == true }))
  asn                    = var.neighbor[each.value]["asn"]
  ip                     = var.neighbor[each.value]["ip"]
  remote_as              = var.neighbor[each.value]["remote_as"]
  shutdown               = var.neighbor[each.value]["shutdown"]
  update_source_loopback = var.neighbor[each.value]["update_source_loopback"]
  activate               = var.neighbor[each.value]["each.value.activate"]
  send_community         = var.neighbor[each.value]["send_community"]
  route_reflector_client = var.neighbor[each.value]["route_reflector_client"]
  route_maps             = var.neighbor[each.value][route_maps]
}

resource "iosxe_bgp_ipv4_unicast_vrf_neighbor" "unicast" {
  for_each               = toset(keys({ for key, value in var.neighbor : key => value if each.value.unicast == true }))
  asn                    = var.neighbor[each.value]["asn"]
  vrf                    = var.neighbor[each.value]["vrf"]
  ip                     = var.neighbor[each.value]["ip"]
  remote_as              = var.neighbor[each.value]["remote_as"]
  shutdown               = var.neighbor[each.value]["shutdown"]
  update_source_loopback = var.neighbor[each.value]["update_source_loopback"]
  activate               = var.neighbor[each.value]["each.value.activate"]
  send_community         = var.neighbor[each.value]["send_community"]
  route_reflector_client = var.neighbor[each.value]["route_reflector_client"]
  route_maps             = var.neighbor[each.value][route_maps]
}

resource "iosxe_bgp_l2vpn_evpn_neighbor" "evpn_neighbor" {
  for_each               = toset(keys({ for key, value in var.neighbor : key => value if each.value.evpn == true }))
  asn                    = var.neighbor[each.value]["asn"]
  ip                     = var.neighbor[each.value]["ip"]
  activate               = var.neighbor[each.value]["each.value.activate"]
  send_community         = var.neighbor[each.value]["send_community"]
  route_reflector_client = var.neighbor[each.value]["route_reflector_client"]
}

resource "iosxe_bgp_neighbor" "neighbor" {
  for_each               = toset(keys({ for key, value in var.neighbor : key => value }))
  asn                    = var.neighbor[each.value]["asn"]
  ip                     = var.neighbor[each.value]["ip"]
  remote_as              = var.neighbor[each.value]["remote_as"]
  shutdown               = var.neighbor[each.value]["shutdown"]
  update_source_loopback = var.neighbor[each.value]["update_source_loopback"]
}