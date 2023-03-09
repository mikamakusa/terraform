variable "dsitributed_virtual_switch" {
  type = map(object({
    datacenter_id            = string
    folder                   = optional(string)
    description              = optional(string)
    contact_name             = optional(string)
    contact_detail           = optional(string)
    ipv4_address             = optional(string)
    lacp_api_version         = optional(string)
    link_discovery_operation = optional(string)
    link_discovery_protocol  = optional(string)
    max_mtu                  = optional(number)
    multicast_filtering_mode = optional(string)
    version                  = optional(string)
    tags                     = optional(list(string))
    custom_attributes        = optional(map(string))
  }))
}

variable "uplinks" {
  type = list(string)
}

variable "host" {
  type = object({
    host_system_id = string
    devices        = optional(list(string))
  })
}

variable "ignore_other_pvlan_mappings" {
  type = string
  default = false
}

variable "pvlan_mapping" {
  type = object({
    primary_vlan_id   = optional(number)
    pvlan_type        = optional(string)
    secondary_vlan_id = optional(number)
  })
}

variable "vlan" {
  type = object({
      max_vlan = optional(number)
      min_vlan = optional(number)
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

variable "netflow_options" {
  type = object({
    netflow_active_flow_timeout   = optional(number)
    netflow_collector_ip_address  = optional(string)
    netflow_collector_port        = optional(number)
    netflow_idle_flow_timeout     = optional(number)
    netflow_internal_flows_only   = optional(bool)
    netflow_observation_domain_id = optional(string)
    netflow_sampling_rate         = optional(number)
  })
  default = {}
}

variable "network_control" {
  type = object({
    network_resource_control_enabled = optional(bool)
    network_resource_control_version = optional(string)
  })
  default = {}
}

variable "traffic_class" {
  type = object({
    virtualmachine_share_level      = optional(string)
    virtualmachine_share_count      = optional(number)
    virtualmachine_reservation_mbit = optional(number)
    virtualmachine_maximum_mbit     = optional(number)
  })
  default = {}
}