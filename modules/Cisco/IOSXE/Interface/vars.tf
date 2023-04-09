variable "interface" {
  type = map(object({
    type                           = string
    description                    = string
    shutdown                       = optional(bool)
    ipv4_address                   = optional(string)
    ipv4_address_mask              = optional(string)
    ip_dhcp_relay_source_interface = optional(string)
    ip_access_group_in             = optional(string)
    ip_access_group_in_enable      = optional(bool)
    ip_access_group_out            = optional(string)
    ip_access_group_out_enable     = optional(bool)
    channel_group_mode             = optional(string)
    channel_group_number           = optional(number)
    encapsulation_dot1q_vlan_id    = optional(number)
    media_type                     = optional(string)
    switch_port                    = optional(bool)
    unnumbered                     = optional(string)
    vrf_forwarding                 = optional(string)
    host_reachability_protocol_bgp = optional(string)
    source_interface_loopback      = optional(number)
    autostate                      = bool
    vni_rfs = optional(list(object({
      vni_range = optional(string)
      vrf       = optional(string)
    })))
    vnis = optional(list(object({
      ingress_replication  = optional(bool)
      ipv4_multicast_group = optional(string)
      vni_range            = optional(number)
    })))
    helper_addresses = optional(list(object({
      address = optional(string)
      global  = optional(bool)
      vrf     = optional(string)
    })))
    source_template = optional(list(object({
      template_name = optional(string)
      merge         = optional(bool)
    })))
  }))

  validation {
    condition     = contains(["GigabitEthernet", "TwoGigabitEthernet", "FiveGigabitEthernet", "TenGigabitEthernet", "TwentyFiveGigE", "FortyGigabitEthernet", "HundredGigE", "TwoHundredGigE", "FourHundredGigE"], var.interface.type)
    error_message = "Allowed values : GigabitEthernet, TwoGigabitEthernet, FiveGigabitEthernet, TenGigabitEthernet, TwentyFiveGigE, FortyGigabitEthernet, HundredGigE, TwoHundredGigE, FourHundredGigE."
  }

  validation {
    condition     = contains(["active", "auto", "desirable", "on", "passive"], var.interface.channel_group_mode)
    error_message = "Allowed values : active, auto, desirable, on, passive."
  }

  validation {
    condition     = contains(["ethernet", "loopback", "nve", "port_channel", "subinterface", "vlan"], var.interface.description)
    error_message = "Allowed values : ethernet, loopback, nve, port-channel, subinterface, vlan."
  }

  validation {
    condition     = contains(["auto-select", "rj45", "sfp"], var.interface.media_type)
    error_message = "Allowed values : auto-select, rj45, sfp."
  }

  validation {
    condition     = var.interface.channel_group_number >= 1 && var.interface.channel_group_number <= 512
    error_message = "Allowed range values : 1 to 512."
  }

  validation {
    condition     = var.interface.encapsulation_dot1q_vlan_id >= 1 && var.interface.encapsulation_dot1q_vlan_id <= 4094
    error_message = "Allowed range values : 1 to 4094."
  }

  validation {
    condition     = var.interface.source_interface_loopback >= 0 && var.interface.source_interface_loopback <= 2147483647
    error_message = "Allowed range value : 0 to 2147483647."
  }
}