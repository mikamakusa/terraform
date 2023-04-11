variable "logging" {
  type = map(object({
    severity         = optional(string)
    buffered_size    = optional(number)
    facility         = optional(string)
    history_size     = optional(number)
    trap             = optional(bool)
    origin_id_type   = optional(string)
    source_interface = optional(string)
    file_max_size    = optional(number)
    file_min_size    = optional(number)
    device           = optional(string)
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

  validation {
    condition     = contains(["auth", "cron", "daemon", "kern", "local0", "local1", "local2", "local3", "local4", "local5", "local6", "local7", "lpr", "mail", "news", "sys10", "sys11", "sys12", "sys13", "sys14", "sys9", "syslog", "user", "uucp"], var.logging.facility)
    error_message = "Allowed values : auth, cron, daemon, kern, local0, local1, local2, local3, local4, local5, local6, local7, lpr, mail, news, sys10, sys11, sys12, sys13, sys14, sys9, syslog, user, uucp."
  }

  validation {
    condition     = var.logging.buffered_size >= 4096 && var.logging.buffered_size <= 2147483647
    error_message = "Allowed range value : 4096 to 2147483647."
  }

  validation {
    condition     = var.logging.file_max_size >= 0 && var.logging.file_max_size <= 4294967295
    error_message = "Allowed range value : 0 to 4294967295."
  }

  validation {
    condition     = var.logging.file_min_size >= 0 && var.logging.file_min_size <= 4294967295
    error_message = "Allowed range value : 0 to 4294967295."
  }
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

  validation {
    condition     = var.ip_logging.transport_tls_ports.port_number >= 1025 && var.ip_logging.transport_tls_ports.port_number <= 65535
    error_message = "Allowed range value : 1025 to 65535."
  }

  validation {
    condition     = var.ip_logging.transport_tcp_ports.port_number >= 1 && var.ip_logging.transport_tcp_ports.port_number <= 65535
    error_message = "Allowed range value : 1 to 65535."
  }

  validation {
    condition     = var.ip_logging.transport_udp_ports.port_number >= 1 && var.ip_logging.transport_udp_ports.port_number <= 65535
    error_message = "Allowed range value : 1 to 65535."
  }
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

  validation {
    condition     = var.snmp.packetsize >= 484 && var.snmp.packetsize <= 17892
    error_message = "Allowed range value : 484 to 17892."
  }

  validation {
    condition     = var.snmp.queue_length >= 1 && var.snmp.queue_length <= 5000
    error_message = "Allowed range value = 1 to 5000."
  }

  validation {
    condition     = var.snmp.source_interface_informs_loopback >= 0 && var.snmp.source_interface_informs_loopback <= 2147483647
    error_message = "Allowed range value : 0 to 2147483647."
  }

  validation {
    condition     = var.snmp.source_interface_informs_port_channel >= 0 && var.snmp.source_interface_informs_port_channel <= 4294967295
    error_message = "Allowed range value : 0 to 4294967295."
  }

  validation {
    condition     = var.snmp.source_interface_traps_vlan >= 0 && var.snmp.source_interface_traps_vlan <= 65535
    error_message = "Allowed range value : 0 to 65535."
  }

  validation {
    condition     = var.snmp.trap_source_loopback >= 0 && var.snmp.trap_source_loopback <= 2147483647
    error_message = "Allowed range value : 0 to 2147483647."
  }

  validation {
    condition     = var.snmp.trap_source_port_channel >= 0 && var.snmp.trap_source_port_channel <= 4294967295
    error_message = "Allowed range value : 0 to 4294967295."
  }

  validation {
    condition     = var.snmp.trap_source_vlan >= 0 && var.snmp.trap_source_vlan <= 65535
    error_message = "Allowed range value : 0 to 65535."
  }

  validation {
    condition     = var.snmp.group.v3_security.access_standard_acl >= 1 && var.snmp.group.v3_security.access_standard_acl <= 99
    error_message = "Allowed range value : 1 to 99."
  }

  validation {
    condition     = contains(["exact", "prefix"], var.snmp.group.v3_security.match_node)
    error_message = "Allowed values : exact or prefix."
  }

  validation {
    condition     = contains(["auth", "noauth", "priv"], var.snmp.group.v3_security.security_level)
    error_message = "Allowed values : auth, noauth, priv."
  }

  validation {
    condition     = contains(["md5", "sha"], var.snmp.user.v3_auth_algoritm)
    error_message = "Allowed values : md5 or sha."
  }

  validation {
    condition     = var.snmp.user.v3_auth_access_standard_acl >= 1 && var.snmp.user.v3_auth_access_standard_acl <= 99
    error_message = "Allowed range values : 1 to 99."
  }

  validation {
    condition     = var.snmp.user.v3_auth_priv_aes_access_standard_acl >= 1 && var.snmp.user.v3_auth_priv_aes_access_standard_acl <= 99
    error_message = "Allowed range values : 1 to 99."
  }

  validation {
    condition     = contains([128, 192, 256], var.snmp.user.v3_auth_priv_aes_algorithm)
    error_message = "allowed values : 128, 192, 256."
  }

  validation {
    condition     = var.snmp.user.v3_auth_priv_des3_access_standard_acl >= 1 && var.snmp.user.v3_auth_priv_des3_access_standard_acl <= 99
    error_message = "Allowed range values : 1 to 99."
  }

  validation {
    condition     = var.snmp.user.v3_auth_priv_des_access_standard_acl >= 1 && var.snmp.user.v3_auth_priv_des_access_standard_acl <= 99
    error_message = "Allowed range values : 1 to 99."
  }
}