locals {
  logging = defaults(var.logging, {
    buffered_size  = 16000
    history_size   = 100
    trap           = true
    facility       = "auth"
    file_max_size  = 4294967295
    file_min_size  = 0
    origin_id_type = "ip"
  })
  snmp = defaults(var.snmp, {
    packetsize                            = 484
    queue_length                          = 1
    source_interface_informs_loopback     = 0
    source_interface_informs_port_channel = 0
    source_interface_traps_vlan           = 0
    trap_source_loopback                  = 0
    trap_source_port_channel              = 0
    trap_source_vlan                      = 0
  })
  v3_security = defaults(var.snmp.group.v3_security, {
    access_standard_acl = 1
    match_node          = "exact"
    security_level      = "auth"
  })
  user = defaults(var.snmp.user, {
    v3_auth_access_standard_acl           = 1
    v3_auth_priv_aes_access_standard_acl  = 1
    v3_auth_priv_aes_algorithm            = 128
    v3_auth_priv_des3_access_standard_acl = 1
    v3_auth_priv_des_access_standard_acl  = 1
  })
}