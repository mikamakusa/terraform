variable "ethernet" {
  type = map(object({
    type                           = string
    description                    = optional(string)
    shutdown                       = optional(bool)
    ipv4_address                   = optional(string)
    ipv4_address_mask              = optional(string)
    ip_dhcp_relay_source_interface = optional(string)
    ip_access_group_in             = optional(string)
    ip_access_group_in_enable      = optional(string)
    ip_access_group_out            = optional(string)
    ip_access_group_out_enable     = optional(string)
    channel_group_mode             = optional(string)
    channel_group_number           = optional(number)
    encapsulation_dot1q_vlan_id    = optional(string)
    media_type                     = optional(string)
    switch_port                    = optional(bool)
    unnumbered                     = optional(string)
    vrf_forwarding                 = optional(bool)
    helper_addresses = optional(list(object({
      address = optional(string)
      global  = optional(bool)
      vrf     = optional(string)
    })))
    source_template = optional(list(object({
      merge         = optional(bool)
      template_name = optional(string)
    })))
  }))

  default = {}

  description = "This resource can manage the Interface Ethernet configuration."
}

variable "loopback" {
  type = map(object({
    description                = optional(string)
    shutdown                   = optional(bool)
    vrf_forwarding             = optional(bool)
    ipv4_address               = optional(string)
    ipv4_address_mask          = optional(string)
    ip_access_group_in         = optional(string)
    ip_access_group_in_enable  = optional(string)
    ip_access_group_out        = optional(string)
    ip_access_group_out_enable = optional(string)
  }))

  default = {}

  description = "This resource can manage the Interface Loopback configuration."
}

variable "nve" {
  type = map(object({
    description                    = optional(string)
    device                         = optional(string)
    host_reachability_protocol_bgp = optional(bool)
    shutdown                       = optional(bool)
    source_interface_loopback      = optional(number)
    vnis = optional(list(object({
      ingress_replication  = optional(bool)
      ipv4_multicast_group = optional(string)
      vni_range            = optional(string)
    })))
    vni_vrfs = list(object({
      vni_range = optional(string)
      vrf       = optional(string)
    }))
  }))

  default = {}

  description = "This resource can manage the Interface NVE configuration."
}

variable "port_channel" {
  type = map(object({
    description                    = optional(string)
    device                         = optional(string)
    ip_access_group_in             = optional(string)
    ip_access_group_in_enable      = optional(bool)
    ip_access_group_out            = optional(string)
    ip_access_group_out_enable     = optional(bool)
    ip_dhcp_relay_source_interface = optional(string)
    ipv4_address                   = optional(string)
    ipv4_address_mask              = optional(string)
    shutdown                       = optional(bool)
    switchport                     = optional(bool)
    vrf_forwarding                 = optional(string)
    encapsulation_dot1q_vlan_id    = optional(number)
    helper_addresses = optional(list(object({
      address = optional(string)
      global  = optional(bool)
      vrf     = optional(string)
    })))
  }))

  default = {}

  description = "This resource can manage the Interface Port Channel and Subinterface configuration."
}

variable "vlan" {
  type = map(object({
    autostate                      = optional(bool)
    description                    = optional(string)
    shutdown                       = optional(bool)
    vrf_forwarding                 = optional(bool)
    ipv4_address                   = optional(string)
    ipv4_address_mask              = optional(string)
    ip_access_group_in             = optional(string)
    ip_access_group_in_enable      = optional(bool)
    ip_access_group_out            = optional(string)
    ip_access_group_out_enable     = optional(bool)
    ip_dhcp_relay_source_interface = optional(string)
    helper_addresses = optional(list(object({
      address = optional(string)
      global  = optional(bool)
      vrf     = optional(string)
    })))
  }))

  default = {}

  description = "This resource can manage the Interface VLAN configuration."
}