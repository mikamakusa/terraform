/*
locals {
  switchport = defaults(var.switchport, {
    type                          = "GigabitEthernet"
    mode_access                   = false
    mode_dot1q_tunnel             = false
    mode_private_vlan_trunk       = false
    mode_private_vlan_host        = false
    mode_private_vlan_promiscuous = false
    mode_trunk                    = false
    nonegotiate                   = false
    trunk_native_vlan_tag         = false
    trunk_native_vlan             = 1
    host                          = false
  })
  vlan = defaults(var.vlan, {
    private_vlan_community = false
    private_vlan_isolated  = false
    private_vlan_primary   = false
    remote_span            = false
    shutdown               = false
    evpn_instance          = 4096
    evpn_instance_vni      = 4096
    vni                    = 4096
  })
}*/
