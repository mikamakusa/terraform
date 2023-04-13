variable "logging" {
  type = list(object({
    origin_id_name    = optional(string)
    monitor_severity  = optional(string)
    buffered_severity = optional(string)
    console_severity  = optional(string)
    history_severity  = optional(string)
    trap_severity     = optional(string)
    buffered_size     = optional(number)
    facility          = optional(string)
    history_size      = optional(number)
    trap              = optional(bool)
    origin_id_type    = optional(string)
    source_interface  = optional(string)
    file_max_size     = optional(number)
    file_min_size     = optional(number)
    device            = optional(string)
    source_interfaces_vrf = optional(map(object({
      vrf = optional(string)
    })))
    ipv4_hosts = optional(object({
      ipv4_host = optional(string)
    }))
    ipv4_vrf_hosts = optional(object({
      ipv4_host = optional(string)
    }))
    ipv6_hosts = optional(object({
      ipv6_host = optional(string)
    }))
    ipv6_vrf_hosts = optional(object({
      ipv6_host = optional(string)
    }))
  }))

  default = []
}

variable "ip_logging" {
  type = map(object({
    ipv4_host = string
    vrf       = bool
    ipv4      = bool
    vrf_name  = optional(string)
    device    = optional(string)
    transport_tcp_ports = optional(object({
      port_number = optional(number)
    }))
    transport_tls_ports = optional(object({
      port_number = optional(number)
      profile     = optional(string)
    }))
    transport_udp_ports = optional(object({
      port_number = optional(number)
    }))
  }))

  default = {}
}

variable "snmp" {
  type = map(object({
    device                                           = optional(string)
    contact                                          = optional(string)
    ifindex_persist                                  = optional(bool)
    location                                         = optional(string)
    packetsize                                       = optional(number)
    queue_length                                     = optional(number)
    enable_informs                                   = optional(bool)
    enable_logging_getop                             = optional(bool)
    enable_logging_setop                             = optional(bool)
    enable_traps                                     = optional(bool)
    enable_traps_snmp_authentication                 = optional(bool)
    enable_traps_snmp_coldstart                      = optional(bool)
    enable_traps_snmp_linkdown                       = optional(bool)
    enable_traps_snmp_linkup                         = optional(bool)
    enable_traps_snmp_warmstart                      = optional(bool)
    ifindex_persist                                  = optional(bool)
    source_interface_informs_forty_gigabit_ethernet  = optional(string)
    source_interface_informs_gigabit_ethernet        = optional(string)
    source_interface_informs_hundred_gig_e           = optional(string)
    source_interface_informs_loopback                = optional(number)
    source_interface_informs_port_channel            = optional(number)
    source_interface_traps_gigabit_ethernet          = optional(string)
    source_interface_traps_port_channel              = optional(number)
    source_interface_traps_port_channel_subinterface = optional(string)
    source_interface_traps_ten_gigabit_ethernet      = optional(string)
    source_interface_traps_vlan                      = optional(number)
    trap_source_forty_gigabit_ethernet               = optional(string)
    trap_source_gigabit_ethernet                     = optional(string)
    trap_source_hundred_gig_e                        = optional(string)
    trap_source_loopback                             = optional(number)
    trap_source_port_channel                         = optional(number)
    trap_source_port_channel_subinterface            = optional(string)
    trap_source_ten_gigabit_ethernet                 = optional(string)
    trap_source_vlan                                 = optional(number)
    views = optional(map(object({
      inc_exl = optional(string)
      mib     = optional(string)
    })))
    context = optional(list(string))
    snmp_communities = optional(map(object({
      access_list_name = optional(string)
      ipv6             = optional(string)
      permission       = optional(string)
      view             = optional(string)
    })))
    group = optional(map(object({
      device = optional(string)
      v3_security = optional(object({
        access_acl_name     = optional(string)
        access_ipv6_acl     = optional(string)
        access_standard_acl = optional(number)
        context_node        = optional(string)
        match_node          = optional(string)
        notify_node         = optional(string)
        read_node           = optional(string)
        security_level      = optional(string)
        write_node          = optional(string)
      }))
    })))
    user = optional(map(object({
      device                                = optional(string)
      grp_name                              = string
      v3_auth_algorithm                     = string
      v3_auth_password                      = string
      v3_auth_access_acl_name               = optional(string)
      v3_auth_access_ipv6_acl               = optional(string)
      v3_auth_access_standard_acl           = optional(number)
      v3_auth_priv_aes_access_acl_name      = optional(string)
      v3_auth_priv_aes_access_ipv6_acl      = optional(string)
      v3_auth_priv_aes_access_standard_acl  = optional(number)
      v3_auth_priv_aes_algorithm            = optional(string)
      v3_auth_priv_aes_password             = optional(string)
      v3_auth_priv_des3_access_acl_name     = optional(string)
      v3_auth_priv_des3_access_ipv6_acl     = optional(string)
      v3_auth_priv_des3_access_standard_acl = optional(number)
      v3_auth_priv_des3_password            = optional(string)
      v3_auth_priv_des_access_acl_name      = optional(string)
      v3_auth_priv_des_access_ipv6_acl      = optional(string)
      v3_auth_priv_des_access_standard_acl  = optional(number)
      v3_auth_priv_des_password             = optional(string)
    })))
  }))

  default = {}
}