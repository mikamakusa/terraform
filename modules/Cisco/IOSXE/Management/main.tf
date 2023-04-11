resource "iosxe_logging" "logging" {
  for_each          = var.logging
  origin_id_name    = each.key
  monitor_severity  = each.value.severity
  buffered_size     = each.value.buffered_size
  buffered_severity = each.value.severity
  console_severity  = each.value.severity
  facility          = each.value.facility
  history_size      = each.value.history_size
  history_severity  = each.value.severity
  trap              = each.value.trap
  trap_severity     = each.value.severity
  origin_id_type    = each.value.origin_id_type
  source_interface  = each.value.source_interface
  device            = each.value.device

  dynamic "source_interfaces_vrf" {
    for_each = each.value.source_interfaces_vrf
    content {
      vrf            = source_interfaces_vrf.value.vrf
      interface_name = source_interfaces_vrf.key
    }
  }

  dynamic "ipv4_hosts" {
    for_each = each.value.ipv4_hosts
    content {
      ipv4_host = ipv4_hosts.value.ipv4_host
    }
  }

  dynamic "ipv4_hosts_vrf" {
    for_each = each.value.ipv4_vrf_hosts
    content {
      ipv4_host = ipv4_hosts_vrf.value.ipv4_host
    }
  }

  dynamic "ipv6_hosts" {
    for_each = each.value.ipv6_hosts
    content {
      ipv4_host = ipv6_hosts.value.ipv6_host
    }
  }

  dynamic "ipv6_hosts_vrf" {
    for_each = each.value.ipv6_vrf_hosts
    content {
      ipv4_host = ipv6_hosts_vrf.value.ipv6_host
    }
  }
}

resource "iosxe_logging_ipv4_host_transport" "logging" {
  for_each = { for key, value in var.ip_logging : key => value
    if lookup(value, "vrf", null) == false && lookup(value, "ipv4") == true
  }
  ipv4_host = each.value.ipv4_host
  device    = each.value.device

  dynamic "transport_udp_ports" {
    for_each = each.value.transport_udp_ports
    content {
      port_number = transport_udp_ports.value.port_number
    }
  }

  dynamic "transport_tcp_ports" {
    for_each = each.value.transport_tcp_ports
    content {
      port_number = transport_tcp_ports.value.port_number
    }
  }

  dynamic "transport_tls_ports" {
    for_each = each.value.transport_tls_ports
    content {
      profile     = transport_tls_ports.value.profile
      port_number = transport_tls_ports.value.port_number
    }
  }
}

resource "iosxe_logging_ipv4_host_vrf_transport" "logging" {
  for_each = { for key, value in var.ip_logging : key => value
    if lookup(value, "vrf", null) == true && lookup(value, "ipv4") == true
  }
  ipv4_host = each.value.ipv4_host
  device    = each.value.device
  vrf       = each.value.vrf_name

  dynamic "transport_udp_ports" {
    for_each = each.value.transport_udp_ports
    content {
      port_number = transport_udp_ports.value.port_number
    }
  }

  dynamic "transport_tcp_ports" {
    for_each = each.value.transport_tcp_ports
    content {
      port_number = transport_tcp_ports.value.port_number
    }
  }

  dynamic "transport_tls_ports" {
    for_each = each.value.transport_tls_ports
    content {
      profile     = transport_tls_ports.value.profile
      port_number = transport_tls_ports.value.port_number
    }
  }
}

resource "iosxe_logging_ipv6_host_transport" "logging" {
  for_each = { for key, value in var.ip_logging : key => value
    if lookup(value, "vrf", null) == false && lookup(value, "ipv4") == false
  }
  ipv4_host = each.value.ipv4_host
  device    = each.value.device

  dynamic "transport_udp_ports" {
    for_each = each.value.transport_udp_ports
    content {
      port_number = transport_udp_ports.value.port_number
    }
  }

  dynamic "transport_tcp_ports" {
    for_each = each.value.transport_tcp_ports
    content {
      port_number = transport_tcp_ports.value.port_number
    }
  }

  dynamic "transport_tls_ports" {
    for_each = each.value.transport_tls_ports
    content {
      profile     = transport_tls_ports.value.profile
      port_number = transport_tls_ports.value.port_number
    }
  }
}

resource "iosxe_logging_ipv6_host_vrf_transport" "logging" {
  for_each = { for key, value in var.ip_logging : key => value
    if lookup(value, "vrf", null) == true && lookup(value, "ipv4") == false
  }
  ipv4_host = each.value.ipv4_host
  device    = each.value.device
  vrf       = each.value.vrf_name

  dynamic "transport_udp_ports" {
    for_each = each.value.transport_udp_ports
    content {
      port_number = transport_udp_ports.value.port_number
    }
  }

  dynamic "transport_tcp_ports" {
    for_each = each.value.transport_tcp_ports
    content {
      port_number = transport_tcp_ports.value.port_number
    }
  }

  dynamic "transport_tls_ports" {
    for_each = each.value.transport_tls_ports
    content {
      profile     = transport_tls_ports.value.profile
      port_number = transport_tls_ports.value.port_number
    }
  }
}

resource "iosxe_snmp_server" "snmp" {
  for_each = { for key, value in var.snmp : key => value
    if lookup(value, "group", null) == false && lookup(value, "user") == false
  }
  chassis_id                                       = each.key
  device                                           = each.value.device
  contact                                          = each.value.contact
  ifindex_persist                                  = each.value.ifindex_persist
  location                                         = each.value.location
  packetsize                                       = each.value.packetsize
  queue_length                                     = each.value.queue_length
  enable_logging_getop                             = each.value.enable_logging_getop
  enable_logging_setop                             = each.value.enable_logging_setop
  enable_traps                                     = each.value.enable_traps
  enable_traps_snmp_authentication                 = each.value.enable_traps_snmp_authentication
  enable_traps_snmp_coldstart                      = each.value.enable_traps_snmp_coldstart
  enable_traps_snmp_linkdown                       = each.value.enable_traps_snmp_linkdown
  enable_traps_snmp_linkup                         = each.value.enable_traps_snmp_linkup
  enable_traps_snmp_warmstart                      = each.value.enable_traps_snmp_warmstart
  source_interface_informs_forty_gigabit_ethernet  = each.value.source_interface_informs_forty_gigabit_ethernet
  source_interface_informs_gigabit_ethernet        = each.value.source_interface_informs_gigabit_ethernet
  source_interface_informs_hundred_gig_e           = each.value.source_interface_informs_hundred_gig_e
  source_interface_informs_loopback                = each.value.source_interface_informs_loopback
  source_interface_informs_port_channel            = each.value.source_interface_informs_port_channel
  source_interface_traps_gigabit_ethernet          = each.value.source_interface_traps_gigabit_ethernet
  source_interface_traps_port_channel              = each.value.source_interface_traps_port_channel
  source_interface_traps_port_channel_subinterface = each.value.source_interface_traps_port_channel_subinterface
  source_interface_traps_ten_gigabit_ethernet      = each.value.source_interface_traps_ten_gigabit_ethernet
  source_interface_traps_vlan                      = each.value.source_interface_traps_vlan
  trap_source_forty_gigabit_ethernet               = each.value.trap_source_forty_gigabit_ethernet
  trap_source_gigabit_ethernet                     = each.value.trap_source_gigabit_ethernet
  trap_source_hundred_gig_e                        = each.value.trap_source_hundred_gig_e
  trap_source_loopback                             = each.value.trap_source_loopback
  trap_source_port_channel                         = each.value.trap_source_port_channel
  trap_source_port_channel_subinterface            = each.value.trap_source_port_channel_subinterface
  trap_source_ten_gigabit_ethernet                 = each.value.trap_source_ten_gigabit_ethernet
  trap_source_vlan                                 = each.value.trap_source_vlan

  dynamic "views" {
    for_each = each.value.views
    content {
      name    = views.key
      inc_exl = views.value.inc_exl
      mib     = views.value.mib
    }
  }

  dynamic "context" {
    for_each = each.value.context
    content {
      name = context.value
    }
  }

  dynamic "snmp_communities" {
    for_each = each.value.snmp_communities
    content {
      name             = snmp_communities.key
      access_list_name = snmp_communities.value.access_list_name
      ipv6             = snmp_communities.value.ipv6
      permission       = snmp_communities.value.permission
      view             = snmp_communities.value.view
    }
  }
}

resource "iosxe_snmp_server_group" "snmp" {
  for_each = var.snmp.group
  name     = each.key
  device   = each.value.device

  dynamic "v3_security" {
    for_each = each.value.v3_security
    content {
      access_acl_name     = v3_security.value.access_acl_name
      access_ipv6_acl     = v3_security.value.access_ipv6_acl
      access_standard_acl = v3_security.value.access_standard_acl
      context_node        = v3_security.value.context_node
      match_node          = v3_security.value.match_node
      notify_node         = v3_security.value.notify_node
      read_node           = v3_security.value.read_node
      security_level      = v3_security.value.security_level
      write_node          = v3_security.value.write_node
    }
  }
}

resource "iosxe_snmp_server_user" "snmp" {
  for_each                              = var.snmp.user
  username                              = each.key
  grpname                               = iosxe_snmp_server_group.snmp[each.value.group].name
  device                                = each.value.device
  v3_auth_algorithm                     = each.value.v3_auth_algorithm
  v3_auth_password                      = each.value.v3_auth_password
  v3_auth_priv_aes_algorithm            = each.value.v3_auth_priv_aes_algorithm
  v3_auth_priv_aes_password             = each.value.v3_auth_priv_aes_password
  v3_auth_priv_aes_access_ipv6_acl      = each.value.v3_auth_priv_aes_access_ipv6_acl
  v3_auth_priv_aes_access_acl_name      = each.value.v3_auth_priv_aes_access_acl_name
  v3_auth_access_acl_name               = each.value.v3_auth_access_acl_name
  v3_auth_access_ipv6_acl               = each.value.v3_auth_access_ipv6_acl
  v3_auth_access_standard_acl           = each.value.v3_auth_access_standard_acl
  v3_auth_priv_aes_access_standard_acl  = each.value.v3_auth_priv_aes_access_standard_acl
  v3_auth_priv_des3_access_acl_name     = each.value.v3_auth_priv_des3_access_acl_name
  v3_auth_priv_des3_access_ipv6_acl     = each.value.v3_auth_priv_des3_access_ipv6_acl
  v3_auth_priv_des3_access_standard_acl = each.value.v3_auth_priv_des3_access_standard_acl
  v3_auth_priv_des3_password            = each.value.v3_auth_priv_des3_password
  v3_auth_priv_des_access_acl_name      = each.value.v3_auth_priv_des_access_acl_name
  v3_auth_priv_des_access_ipv6_acl      = each.value.v3_auth_priv_des_access_ipv6_acl
  v3_auth_priv_des_access_standard_acl  = each.value.v3_auth_priv_des_access_standard_acl
  v3_auth_priv_des_password             = each.value.v3_auth_priv_des_password
}