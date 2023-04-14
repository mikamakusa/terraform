resource "iosxe_vrf" "vrf" {
  for_each                           = var.vrf
  name                               = each.key
  description                        = each.value.description
  rd                                 = each.value.rd
  address_family_ipv4                = each.value.address_family_ipv4
  address_family_ipv6                = each.value.address_family_ipv6
  vpn_id                             = each.value.vpn_id
  route_target_import                = each.value.route_target_import
  route_target_export                = each.value.route_target_export
  ipv4_route_target_import           = each.value.ipv4_route_target_import
  ipv4_route_target_import_stitching = each.value.ipv4_route_target_import_stitching
  ipv4_route_target_export           = each.value.ipv4_route_target_export
  ipv4_route_target_export_stitching = each.value.ipv4_route_target_export_stitching
  ipv6_route_target_import           = each.value.ipv6_route_target_import
  ipv6_route_target_import_stitching = each.value.ipv6_route_target_import_stitching
  ipv6_route_target_export           = each.value.ipv6_route_target_export
  ipv6_route_target_export_stitching = each.value.ipv6_route_target_export_stitching
}