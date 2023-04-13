output "address_family" {
  value = try(
    iosxe_bgp_address_family_ipv4_vrf.address_family,
    iosxe_bgp_address_family_ipv6_vrf.address_family,
    iosxe_bgp_address_family_l2vpn.l2vpn
  )
}

output "bgp" {
  value = iosxe_bgp.bgp
}

output "unicast" {
  value = iosxe_bgp_ipv4_unicast_vrf_neighbor.unicast
}

output "evpn_neighbor" {
  value = iosxe_bgp_l2vpn_evpn_neighbor.evpn_neighbor
}

output "neighbor" {
  value = iosxe_bgp_neighbor.neighbor
}