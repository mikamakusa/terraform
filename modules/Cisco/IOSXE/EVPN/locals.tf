locals {
  evpn = defaults(var.evpn, {
    ip_duplication_limit      = 10
    ip_duplication_time       = 100
    mac_duplication_limit     = 10
    mac_duplication_time      = 100
    router_id_loopback        = 100
    default_gateway_advertise = true
    logging_peer_state        = true
    replication_type_ingress  = false
    replication_type_static   = true
    replication_type_p2mp     = false
    replication_type_mp2mp    = false
  })
  evpn_instance = defaults(var.evpn_instance, {
    evpn_instance_num                    = 10
    vlan_based_replication_type_ingress  = false
    vlan_based_replication_type_static   = true
    vlan_based_replication_type_p2mp     = false
    vlan_based_replication_type_mp2mp    = false
    vlan_based_encapsulation             = "vxlan"
    vlan_based_auto_route_target         = false
    vlan_based_rd                        = "10:10"
    vlan_based_route_target              = "10:10"
    vlan_based_route_target_both         = "10:10"
    vlan_based_route_target_import       = "10:10"
    vlan_based_route_target_export       = "10:10"
    vlan_based_ip_local_learning_disable = false
    vlan_based_ip_local_learning_enable  = true
    vlan_based_default_gateway_advertise = "enable"
    vlan_based_re_originate_route_type5  = true
  })
}