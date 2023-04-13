resource "iosxe_vrf" "vrf" {
  for_each            = var.vrf
  name                = each.key
  description         = each.value.description
  rd                  = each.value.rd
  address_family_ipv4 = each.value.address_family_ipv4
  address_family_ipv6 = each.value.address_family_ipv6
  vpn_id              = each.value.vpn_id
}