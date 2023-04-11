resource "iosxe_bgp" "bgp" {
  for_each             = var.bgp
  asn                  = each.value.asn
  default_ipv4_unicast = each.value.default_ipv4_unicast
  log_neighbor_changes = each.value.log_neighbor_changes
  router_id_loopback   = each.value.router_id_loopback
  device               = each.value.devices
}

resource "iosxe_bgp_address_family_ipv4_vrf" "address_family" {
  for_each = { for key, value in var.address_family : key => value if each.value.ipv4 == true }
  asn      = each.value.asn == null ? iosxe_bgp.bgp[each.key].asn : each.value.asn
  af_name  = each.value.af_name
  device   = each.value.device

  dynamic "vrfs" {
    for_each = each.value.vrfs
    content {
      name                   = vrfs.value.name
      advertise_l2vpn_evpn   = vrfs.value.advertise_l2vpn_evpn
      redistribute_connected = vrfs.value.redistribute_connected
      redistribute_static    = vrfs.value.redistribute_static
    }
  }
}

resource "iosxe_bgp_address_family_ipv6_vrf" "address_family" {
  for_each = { for key, value in var.address_family : key => value if each.value.ipv4 == false }
  asn      = each.value.asn == null ? iosxe_bgp.bgp[each.key].asn : each.value.asn
  af_name  = each.value.af_name
  device   = each.value.device

  dynamic "vrfs" {
    for_each = each.value.vrfs
    content {
      name                   = vrfs.value.name
      advertise_l2vpn_evpn   = vrfs.value.advertise_l2vpn_evpn
      redistribute_connected = vrfs.value.redistribute_connected
      redistribute_static    = vrfs.value.redistribute_static
    }
  }
}

resource "iosxe_bgp_address_family_l2vpn" "l2vpn" {
  for_each = var.address_family
  asn      = each.value.asn == null ? iosxe_bgp.bgp[each.key].asn : each.value.asn
  af_name  = each.value.af_name
  device   = each.value.device
}

resource "iosxe_bgp_ipv4_unicast_vrf_neighbor" "unicast" {
  for_each               = { for key, value in var.neighbor : key => value if each.value.unicast == true }
  asn                    = each.value.asn == null ? iosxe_bgp.bgp[each.key].asn : each.value.asn
  vrf                    = each.value.vrf
  ip                     = each.value.ip
  remote_as              = each.value.remote_as
  shutdown               = each.value.shutdown
  update_source_loopback = each.value.update_source_loopback
  activate               = each.value.activate
  send_community         = each.value.send_community
  route_reflector_client = each.value.route_reflector_client
}

resource "iosxe_bgp_l2vpn_evpn_neighbor" "evpn_neighbor" {
  for_each               = { for key, value in var.neighbor : key => value if each.value.evpn == true }
  asn                    = each.value.asn == null ? iosxe_bgp.bgp[each.key].asn : each.value.asn
  ip                     = each.value.ip
  activate               = each.value.activate
  send_community         = each.value.send_community
  route_reflector_client = each.value.route_reflector_client
}

resource "iosxe_bgp_neighbor" "neighbor" {
  for_each               = var.neighbor
  asn                    = each.value.asn == null ? iosxe_bgp.bgp[each.key].asn : each.value.asn
  ip                     = each.value.ip
  remote_as              = each.value.remote_as
  shutdown               = each.value.shutdown
  update_source_loopback = each.value.update_source_loopback
}