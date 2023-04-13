resource "iosxe_logging" "logging" {
  for_each          = toset(keys({ for k, v in var.logging : k => v }))
  origin_id_name    = var.logging[each.value]["origin_id_name"]
  monitor_severity  = var.logging[each.value]["monitor_severity"]
  buffered_size     = var.logging[each.value]["buffered_size"]
  buffered_severity = var.logging[each.value]["buffered_severity"]
  console_severity  = var.logging[each.value]["console_severity"]
  facility          = var.logging[each.value]["facility"]
  history_size      = var.logging[each.value]["history_size"]
  history_severity  = var.logging[each.value]["history_severity"]
  trap              = var.logging[each.value]["trap"]
  trap_severity     = var.logging[each.value]["trap_severity"]
  origin_id_type    = var.logging[each.value]["origin_id_type"]
  source_interface  = var.logging[each.value]["source_interface"]
  device            = var.logging[each.value]["device"]

  ipv4_hosts = [
    {
      ipv4_host = "2.2.2.2"
    }
  ]
}

resource "iosxe_logging_ipv4_host_transport" "logging" {
  for_each  = toset(keys({ for key, value in var.ipv4_logging : key => value }))
  ipv4_host = var.ipv4_logging[each.value]["ipv4_host"]
  device    = var.ipv4_logging[each.value]["device"]
}

resource "iosxe_logging_ipv4_host_vrf_transport" "logging" {
  for_each  = toset(keys({ for key, value in var.ipv4_vrf_logging : key => value }))
  ipv4_host = var.ipv4_logging[each.value]["ipv4_host"]
  device    = var.ipv4_logging[each.value]["device"]
  vrf       = var.ipv4_vrf_logging[each.value]["vrf"]
}

resource "iosxe_logging_ipv6_host_transport" "logging" {
  for_each  = toset(keys({ for key, value in var.ipv6_logging : key => value }))
  ipv6_host = var.ipv6_logging[each.value]["ipv6_host"]
  device    = var.ipv6_logging[each.value]["device"]
}

resource "iosxe_logging_ipv6_host_vrf_transport" "logging" {
  for_each  = toset(keys({ for key, value in var.ipv6_vrf_logging : key => value }))
  ipv6_host = var.ipv6_vrf_logging[each.value]["ipv6_host"]
  device    = var.ipv6_vrf_logging[each.value]["device"]
  vrf       = var.ipv6_vrf_logging[each.value]["vrf"]
}


resource "iosxe_snmp_server" "snmp" {
  for_each                                         = var.snmp
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
  views                                            = each.value.views
  contexts                                         = each.value.contexts
  snmp_communities                                 = each.value.snmp_communities
}

resource "iosxe_snmp_server_group" "snmp" {
  for_each    = var.group
  name        = each.key
  device      = each.value.device
  v3_security = each.value.v3_security
}

resource "iosxe_snmp_server_user" "snmp" {
  for_each                              = var.user
  username                              = each.key
  grpname                               = each.value.grpname
  device                                = each.value.device
  v3_auth_algorithm                     = each.value.v3_auth_algorithm
  v3_auth_password                      = sensitive(each.value.v3_auth_password)
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