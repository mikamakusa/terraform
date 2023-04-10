resource "iosxe_interface_switchport" "switchport" {
  for_each                      = var.switchport
  type                          = each.value.type
  name                          = each.key
  mode_access                   = each.value.mode_access
  mode_dot1q_tunnel             = each.value.mode_dot1q_tunnel
  mode_private_vlan_trunk       = each.value.mode_private_vlan_trunk
  mode_private_vlan_host        = each.value.mode_private_vlan_host
  mode_private_vlan_promiscuous = each.value.mode_private_vlan_promiscuous
  mode_trunk                    = each.value.mode_trunk
  nonegotiate                   = each.value.nonegotiate
  access_vlan                   = each.value.access_vlan
  trunk_allowed_vlans           = each.value.trunk_allowed_vlans
  trunk_native_vlan_tag         = each.value.trunk_native_vlan_tag
  trunk_native_vlan             = each.value.trunk_native_vlan
  host                          = each.value.host
  device                        = each.value.device
}

resource "iosxe_vlan" "vlan" {
  for_each                 = var.vlan
  vlan_id                  = each.value.vlan_id
  name                     = each.key
  shutdown                 = each.value.shutdown
  device                   = each.value.device
  private_vlan_association = each.value.private_vlan_association
  private_vlan_community   = each.value.private_vlan_community
  private_vlan_isolated    = each.value.private_vlan_isolated
  private_vlan_primary     = each.value.private_vlan_primary
  remote_span              = each.value.remote_span
}

resource "iosxe_vlan_configuration" "vlan_configuration" {
  for_each          = var.vlan
  vlan_id           = each.value.vlan_id
  access_vfi        = each.value.access_vfi
  device            = each.value.device
  vni               = each.value.vni
  evpn_instance     = each.value.evpn_instance
  evpn_instance_vni = each.value.evpn_instance_vni
}