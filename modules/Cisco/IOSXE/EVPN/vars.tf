variable "evpn" {
  type = list(object({
    device                    = optional(string)
    default_gateway_advertise = optional(bool)
    mac_duplication_limit     = optional(number)
    mac_duplication_time      = optional(number)
    ip_duplication_limit      = optional(number)
    ip_duplication_time       = optional(number)
    logging_peer_state        = optional(bool)
    replication_type_ingress  = optional(bool)
    replication_type_static   = optional(bool)
    replication_type_p2mp     = optional(bool)
    replication_type_mp2mp    = optional(bool)
    route_target_auto_vni     = optional(bool)
    router_id_loopback        = optional(number)
  }))

  default = []
}

variable "evpn_instance" {
  type = list(object({
    evpn_instance_num                    = number
    vlan_based_replication_type_ingress  = optional(bool)
    vlan_based_replication_type_static   = optional(bool)
    vlan_based_replication_type_p2mp     = optional(bool)
    vlan_based_replication_type_mp2mp    = optional(bool)
    vlan_based_encapsulation             = optional(string)
    vlan_based_auto_route_target         = optional(bool)
    vlan_based_rd                        = optional(string)
    vlan_based_route_target              = optional(string)
    vlan_based_route_target_both         = optional(string)
    vlan_based_route_target_import       = optional(string)
    vlan_based_route_target_export       = optional(string)
    vlan_based_ip_local_learning_disable = optional(bool)
    vlan_based_ip_local_learning_enable  = optional(bool)
    vlan_based_default_gateway_advertise = optional(string)
    vlan_based_re_originate_route_type5  = optional(bool)
  }))

  default = []
}

variable "devices" {
  type = map(object({
    replication_type_ingress             = optional(bool)
    replication_type_static              = optional(bool)
    replication_type_p2mp                = optional(bool)
    replication_type_mp2mp               = optional(bool)
    mac_duplication_limit                = optional(number)
    mac_duplication_time                 = optional(number)
    ip_duplication_limit                 = optional(number)
    ip_duplication_time                  = optional(number)
    router_id_loopback                   = optional(number)
    default_gateway_advertise            = optional(bool)
    logging_peer_state                   = optional(bool)
    route_target_auto_vni                = optional(bool)
    evpn_instance_num                    = optional(number)
    vlan_based_replication_type_ingress  = optional(bool)
    vlan_based_replication_type_static   = optional(bool)
    vlan_based_replication_type_p2mp     = optional(bool)
    vlan_based_replication_type_mp2mp    = optional(bool)
    vlan_based_encapsulation             = optional(string)
    vlan_based_auto_route_target         = optional(bool)
    vlan_based_rd                        = optional(string)
    vlan_based_route_target              = optional(string)
    vlan_based_route_target_both         = optional(string)
    vlan_based_route_target_import       = optional(string)
    vlan_based_route_target_export       = optional(string)
    vlan_based_ip_local_learning_disable = optional(bool)
    vlan_based_ip_local_learning_enable  = optional(bool)
    vlan_based_default_gateway_advertise = optional(string)
    vlan_based_re_originate_route_type5  = optional(bool)
  }))
}