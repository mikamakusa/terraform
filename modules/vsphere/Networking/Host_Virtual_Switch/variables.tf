variable "host_virtual_switch" {
  type = map(object({
    host_system_id  = string
    mtu             = optional(number)
    number_of_ports = optional(number)
  }))
}

variable "nic_teaming_options" {
  type = object({
    standby_nics    = optional(list(string))
    active_nics     = list(string)
    check_beacon    = optional(bool)
    teaming_policy  = optional(string)
    notify_switches = optional(bool)
    failback        = optional(bool)
  })
}

variable "security_policy" {
  type = object({
    allow_forged_transmits = optional(bool)
    allow_promiscuous      = optional(bool)
    allow_mac_changes      = optional(bool)
  })
  default = {}
}

variable "traffic_shaping" {
  type = object({
    shaping_enabled           = optional(bool)
    shaping_burst_size        = optional(number)
    shaping_average_bandwidth = optional(number)
    shaping_peak_bandwidth    = optional(number)
  })
  default = {}
}

variable "bridge_options" {
  type = object({
    network_adapters         = list(string)
    beacon_interval          = optional(number)
    link_discovery_operation = optional(string)
    link_discovery_protocol  = optional(string)
  })
}