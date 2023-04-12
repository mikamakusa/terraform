resource "iosxe_evpn" "evpn" {
  for_each                  = toset(keys({ for k, v in var.evpn : k => v }))
  device                    = var.evpn[each.value]["device"]
  replication_type_ingress  = var.evpn[each.value]["replication_type_ingress"]
  replication_type_static   = var.evpn[each.value]["replication_type_static"]
  replication_type_p2mp     = var.evpn[each.value]["replication_type_p2mp"]
  replication_type_mp2mp    = var.evpn[each.value]["replication_type_mp2mp"]
  mac_duplication_limit     = var.evpn[each.value]["mac_duplication_limit"]
  mac_duplication_time      = var.evpn[each.value]["mac_duplication_time"]
  ip_duplication_limit      = var.evpn[each.value]["ip_duplication_limit"]
  ip_duplication_time       = var.evpn[each.value]["ip_duplication_time"]
  router_id_loopback        = var.evpn[each.value]["router_id_loopback"]
  default_gateway_advertise = var.evpn[each.value]["default_gateway_advertise"]
  logging_peer_state        = var.evpn[each.value]["logging_peer_state"]
  route_target_auto_vni     = var.evpn[each.value]["route_target_auto_vni"]
}

resource "iosxe_evpn_instance" "evpn" {
  for_each                             = toset(keys({ for k, v in var.evpn_instance : k => v }))
  device                               = var.evpn_instance[each.value]["device"]
  evpn_instance_num                    = var.evpn_instance[each.value]["evpn_instance_num"]
  vlan_based_replication_type_ingress  = var.evpn_instance[each.value]["vlan_based_replication_type_ingress"]
  vlan_based_replication_type_static   = var.evpn_instance[each.value]["vlan_based_replication_type_static"]
  vlan_based_replication_type_p2mp     = var.evpn_instance[each.value]["vlan_based_replication_type_p2mp"]
  vlan_based_replication_type_mp2mp    = var.evpn_instance[each.value]["vlan_based_replication_type_mp2mp"]
  vlan_based_encapsulation             = var.evpn_instance[each.value]["vlan_based_encapsulation"]
  vlan_based_auto_route_target         = var.evpn_instance[each.value]["vlan_based_auto_route_target"]
  vlan_based_rd                        = var.evpn_instance[each.value]["vlan_based_rd"]
  vlan_based_route_target              = var.evpn_instance[each.value]["vlan_based_route_target"]
  vlan_based_route_target_both         = var.evpn_instance[each.value]["vlan_based_route_target_both"]
  vlan_based_route_target_import       = var.evpn_instance[each.value]["vlan_based_route_target_import"]
  vlan_based_route_target_export       = var.evpn_instance[each.value]["vlan_based_route_target_export"]
  vlan_based_ip_local_learning_disable = var.evpn_instance[each.value]["vlan_based_ip_local_learning_disable"]
  vlan_based_ip_local_learning_enable  = var.evpn_instance[each.value]["vlan_based_ip_local_learning_enable"]
  vlan_based_default_gateway_advertise = var.evpn_instance[each.value]["vlan_based_default_gateway_advertise"]
  vlan_based_re_originate_route_type5  = var.evpn_instance[each.value]["vlan_based_re_originate_route_type5"]
}