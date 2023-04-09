resource "iosxe_bgp" "bgp" {
  for_each             = var.devices
  asn                  = each.value.bgp
  default_ipv4_unicast = false
  log_neighbor_changes = true
  router_id_loopback   = each.value.loopback_id
  device               = each.key
}

resource "iosxe_bgp_address_family_ipv4_vrf" "address_family" {
  for_each = { for key, value in var.devices : key => value
    if lookup(value, "ipv6", null) == false
  }
  asn     = iosxe_bgp.bgp[each.key].asn
  af_name = each.value.af_name
  device  = each.key

  dynamic "vrfs" {
    for_each = each.value.vrf
    content {
      name                   = vrfs.value.name
      advertise_l2vpn_evpn   = vrfs.value.advertise_l2vpn_evpn
      redistribute_connected = vrfs.value.redistribute_connected
      redistribute_static    = vrfs.value.redistribute_static
    }
  }
}

resource "iosxe_bgp_address_family_ipv6_vrf" "address_family" {
  for_each = { for key, value in var.devices : key => value
    if lookup(value, "ipv6", null) == true
  }
  asn     = each.value.bgp
  af_name = each.value.af_name
  device  = each.key

  dynamic "vrfs" {
    for_each = each.value.vrf
    content {
      name                   = vrfs.value.name
      advertise_l2vpn_evpn   = vrfs.value.advertise_l2vpn_evpn
      redistribute_connected = vrfs.value.redistribute_connected
      redistribute_static    = vrfs.value.redistribute_static
    }
  }
}

resource "iosxe_bgp_address_family_l2vpn" "address_family" {
  for_each = var.devices
  asn      = iosxe_bgp.bgp[each.value].asn
  af_name  = each.value.af_name
  device   = each.key
}

resource "iosxe_bgp_ipv4_unicast_vrf_neighbor" "unicast" {
  for_each               = var.devices
  asn                    = iosxe_bgp.bgp[each.key].asn
  vrf                    = each.value.vrf[each.key].name
  ip                     = [for l in each.value.loopback : l.ipv4_address if each.value[1] == each.key]
  remote_as              = iosxe_bgp.bgp[each.key].asn
  shutdown               = false
  update_source_loopback = each.value.loopback_id
  activate               = true
  send_community         = "both"
  route_reflector_client = false
}

resource "iosxe_bgp_l2vpn_evpn_neighbor" "evpn_neighbor" {
  for_each               = var.devices
  asn                    = iosxe_bgp.bgp[each.key].asn
  ip                     = [for l in each.value.loopback : l.ipv4_address if each.value[1] == each.key]
  activate               = true
  send_community         = "both"
  route_reflector_client = false
}

resource "iosxe_bgp_neighbor" "neighbor" {
  for_each               = var.devices
  asn                    = iosxe_bgp.bgp[each.key].asn
  ip                     = [for l in each.value.loopback : l.ipv4_address if each.key == l.device]
  remote_as              = iosxe_bgp.bgp[each.key].asn
  shutdown               = false
  update_source_loopback = each.value.loopback_id
}