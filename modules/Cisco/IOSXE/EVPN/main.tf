resource "iosxe_evpn" "evpn" {
  for_each = { for key, value in var.devices : key => value
    if lookup(value, "instance", null) == false
  }
  device                    = each.key
  replication_type_ingress  = each.value.replication_type_ingress
  replication_type_static   = each.value.replication_type_static
  replication_type_p2mp     = each.value.replication_type_p2mp
  replication_type_mp2mp    = each.value.replication_type_mp2mp
  mac_duplication_limit     = each.value.mac_duplication_limit
  mac_duplication_time      = each.value.mac_duplication_time
  ip_duplication_limit      = each.value.ip_duplication_limit
  ip_duplication_time       = each.value.ip_duplication_time
  router_id_loopback        = each.value.router_id_loopback
  default_gateway_advertise = each.value.default_gateway_advertise
  logging_peer_state        = each.value.logging_peer_state
  route_target_auto_vni     = each.value.route_target_auto_vni
}

resource "iosxe_evpn_instance" "evpn" {
  for_each = { for key, value in var.devices : key => value
    if lookup(value, "instance", null) == true
  }
  device                               = each.key
  evpn_instance_num                    = each.value.evpn_instance_num
  vlan_based_replication_type_ingress  = each.value.vlan_based_replication_type_ingress
  vlan_based_replication_type_static   = each.value.vlan_based_replication_type_static
  vlan_based_replication_type_p2mp     = each.value.vlan_based_replication_type_p2mp
  vlan_based_replication_type_mp2mp    = each.value.vlan_based_replication_type_mp2mp
  vlan_based_encapsulation             = each.value.vlan_based_encapsulation
  vlan_based_auto_route_target         = each.value.vlan_based_auto_route_target
  vlan_based_rd                        = each.value.vlan_based_rd
  vlan_based_route_target              = each.value.vlan_based_route_target
  vlan_based_route_target_both         = each.value.vlan_based_route_target_both
  vlan_based_route_target_import       = each.value.vlan_based_route_target_import
  vlan_based_route_target_export       = each.value.vlan_based_route_target_export
  vlan_based_ip_local_learning_disable = each.value.vlan_based_ip_local_learning_disable
  vlan_based_ip_local_learning_enable  = each.value.vlan_based_ip_local_learning_enable
  vlan_based_default_gateway_advertise = each.value.vlan_based_default_gateway_advertise
  vlan_based_re_originate_route_type5  = each.value.vlan_based_re_originate_route_type5
}