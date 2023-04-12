resource "iosxe_interface_ethernet" "interface" {
  for_each                       = var.ethernet
  type                           = each.value.type
  name                           = each.key
  description                    = each.value.description
  shutdown                       = each.value.shutdown
  ipv4_address                   = each.value.ipv4_address
  ipv4_address_mask              = each.value.ipv4_address_mask
  ip_dhcp_relay_source_interface = each.value.ip_dhcp_relay_source_interface
  ip_access_group_in             = each.value.ip_access_group_in
  ip_access_group_in_enable      = each.value.ip_access_group_in_enable
  ip_access_group_out            = each.value.ip_access_group_out
  ip_access_group_out_enable     = each.value.ip_access_group_out_enable
  channel_group_mode             = each.value.channel_group_mode
  channel_group_number           = each.value.channel_group_number
  encapsulation_dot1q_vlan_id    = each.value.encapsulation_dot1q_vlan_id
  media_type                     = each.value.media_type
  switch_port                    = each.value.switch_port
  unnumbered                     = each.value.unnumbered
  vrf_forwarding                 = each.value.vrf_forwarding

  dynamic "helper_addresses" {
    for_each = each.value.helper_addresses
    content {
      address = helper_addresses.value.address
      global  = helper_addresses.value.global
      vrf     = helper_addresses.value.vrf
    }
  }

  dynamic "source_template" {
    for_each = each.value.source_template
    content {
      template_name = source_template.value.template_name
      merge         = source_template.value.merge
    }
  }
}

resource "iosxe_interface_loopback" "interface" {
  for_each                   = var.loopback
  name                       = each.key
  description                = each.value.description
  shutdown                   = each.value.shutdown
  vrf_forwarding             = each.value.vrf_forwarding
  ipv4_address               = each.value.ipv4_address
  ipv4_address_mask          = each.value.ipv4_address_mask
  ip_access_group_in         = each.value.ip_access_group_in
  ip_access_group_in_enable  = each.value.ip_access_group_in_enable
  ip_access_group_out        = each.value.ip_access_group_out
  ip_access_group_out_enable = each.value.ip_access_group_out_enable
}

resource "iosxe_interface_nve" "interface" {
  for_each                       = var.nve
  name                           = tonumber(each.key)
  description                    = each.value.description
  shutdown                       = each.value.shutdown
  host_reachability_protocol_bgp = each.value.host_reachability_protocol_bgp
  source_interface_loopback      = each.value.source_interface_loopback

  dynamic "vnis" {
    for_each = each.value.vnis
    content {
      ingress_replication  = vnis.value.ingress_replication
      vni_range            = vnis.value.vni_range
      ipv4_multicast_group = vnis.value.ipv4_multicast_group
    }
  }

  dynamic "vni_rfs" {
    for_each = each.value.vni_vrfs
    content {
      vni_range = vni_rfs.value.vni_range
      vrf       = vni_rfs.value.vrf
    }
  }
}

resource "iosxe_interface_port_channel" "interface" {
  for_each                       = var.port_channel
  name                           = each.key
  description                    = each.value.description
  shutdown                       = each.value.shutdown
  vrf_forwarding                 = each.value.vrf_forwarding
  ipv4_address                   = each.value.ipv4_address
  ipv4_address_mask              = each.value.ipv4_address_mask
  ip_access_group_in             = each.value.ip_access_group_in
  ip_access_group_in_enable      = each.value.ip_access_group_in_enable
  ip_access_group_out            = each.value.ip_access_group_out
  ip_access_group_out_enable     = each.value.ip_access_group_out_enable
  ip_dhcp_relay_source_interface = each.value.ip_dhcp_relay_source_interface

  dynamic "helper_addresses" {
    for_each = each.value.helper_addresses
    content {
      address = helper_addresses.value.address
      global  = helper_addresses.value.global
      vrf     = helper_addresses.value.vrf
    }
  }
}

resource "iosxe_interface_port_channel_subinterface" "interface" {
  for_each                       = var.port_channel
  name                           = each.key
  description                    = each.value.description
  shutdown                       = each.value.shutdown
  vrf_forwarding                 = each.value.vrf_forwarding
  ipv4_address                   = each.value.ipv4_address
  ipv4_address_mask              = each.value.ipv4_address_mask
  ip_access_group_in             = each.value.ip_access_group_in
  ip_access_group_in_enable      = each.value.ip_access_group_in_enable
  ip_access_group_out            = each.value.ip_access_group_out
  ip_access_group_out_enable     = each.value.ip_access_group_out_enable
  ip_dhcp_relay_source_interface = each.value.ip_dhcp_relay_source_interface
  encapsulation_dot1q_vlan_id    = each.value.encapsulation_dot1q_vlan_id

  dynamic "helper_addresses" {
    for_each = each.value.helper_addresses
    content {
      address = helper_addresses.value.address
      global  = helper_addresses.value.global
      vrf     = helper_addresses.value.vrf
    }
  }
}

resource "iosxe_interface_vlan" "interface" {
  for_each                       = var.vlan
  autostate                      = each.value.autostate
  name                           = each.key
  description                    = each.value.description
  shutdown                       = each.value.shutdown
  vrf_forwarding                 = each.value.vrf_forwarding
  ipv4_address                   = each.value.ipv4_address
  ipv4_address_mask              = each.value.ipv4_address_mask
  ip_access_group_in             = each.value.ip_access_group_in
  ip_access_group_in_enable      = each.value.ip_access_group_in_enable
  ip_access_group_out            = each.value.ip_access_group_out
  ip_access_group_out_enable     = each.value.ip_access_group_out_enable
  ip_dhcp_relay_source_interface = each.value.ip_dhcp_relay_source_interface

  dynamic "helper_addresses" {
    for_each = each.value.helper_addresses
    content {
      address = helper_addresses.value.address
      global  = helper_addresses.value.global
      vrf     = helper_addresses.value.vrf
    }
  }
}