variable "distributed_port_group" {
  type = map(object({
    distributed_virtual_switch_uuid = string
    type = optional(string)
    description = optional(string)
    number_of_ports = optional(number)
    auto_expand = optional(bool)
    port_name_format = optional(string)
    network_resource_pool_key = optional(string)
    custom_attributes = optional(map(string))
  }))
}

variable "port_override" {
  type = object({
    block_override_allowed = optional(bool)
    live_port_moving_allowed = optional(bool)
    netflow_override_allowed = optional(bool)
    network_resource_pool_override_allowed = optional(bool)
    port_config_reset_at_disconnect = optional(bool)
    security_policy_override_allowed = optional(bool)
    shaping_override_allowed = optional(bool)
    traffic_filter_override_allowed = optional(bool)
    uplink_teaming_override_allowed = optional(bool)
    vlan_override_allowed = optional(bool)
  })
  default = {}
}

variable "vlan" {
  type = object({
    vlan_id = optional(string)
    vlan_range = optional(object({
      max_vlan = optional(number)
      min_vlan = optional(number)
    }))
    port_private_secondary_vlan_id = optional(string)
  })
  default = {}
}

variable "ha_policy" {
  type = object({
    active_uplinks  = optional(list(string))
    standby_uplinks = optional(list(string))
    check_beacon    = optional(bool)
    failback        = optional(bool)
    notify_switches = optional(bool)
    teaming_policy  = optional(string)
  })
  default = {}
}

variable "lacp_options" {
  type = object({
    lacp_enabled = optional(bool)
    lacp_mode    = optional(string)
  })
  default = {}
}

variable "security_options" {
  type = object({
    allow_forged_transmits = optional(bool)
    allow_mac_changes      = optional(bool)
    allow_promiscuous      = optional(bool)
  })
  default = {}
}

variable "trafic_shaping" {
  type = object({
    ingress_shaping_average_bandwidth = optional(number)
    ingress_shaping_burst_size        = optional(number)
    ingress_shaping_enabled           = optional(bool)
    ingress_shaping_peak_bandwidth    = optional(number)
    egress_shaping_average_bandwidth  = optional(number)
    egress_shaping_burst_size         = optional(number)
    egress_shaping_enabled            = optional(bool)
    egress_shaping_peak_bandwidth     = optional(number)
  })
  default = {}
}

variable "miscellaneous_options" {
  type = object({
    block_all_ports         = optional(bool)
    netflow_enabled         = optional(bool)
    tx_uplink               = optional(bool)
    directpath_gen2_allowed = optional(bool)
  })
  default = {}
}