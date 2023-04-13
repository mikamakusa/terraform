/*
locals {
  ethernet = defaults(var.ethernet, {
    type                        = "GigabitEthernet"
    shutdown                    = false
    ip_access_group_in_enable   = true
    ip_access_group_out_enable  = true
    channel_group_mode          = "active"
    encapsulation_dot1q_vlan_id = 1
    media_type                  = "auto-select"
  })
  loopback = defaults(var.loopback, {
    shutdown                   = false
    ip_access_group_in_enable  = true
    ip_access_group_out_enable = true
  })
  nve = defaults(var.nve, {
    shutdown                       = false
    host_reachability_protocol_bgp = true
  })
  port_channel = defaults(var.port_channel, {
    shutdown                       = false
    ip_access_group_in_enable      = true
    ip_access_group_out_enable     = true
  })
  vlan = defaults(var.vlan, {
    autostate                      = false
    shutdown                       = false
    ip_access_group_in_enable      = true
    ip_access_group_out_enable     = true
  })
}*/
