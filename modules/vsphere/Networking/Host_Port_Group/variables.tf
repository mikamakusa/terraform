variable "host_port_group" {
  type = map(object({
    host_system_id      = string
    virtual_switch_name = string
    vlan_id             = optional(number)
  }))
}

variable "nic_teaming" {
  type = object({
    standby_nics    = optional(list(string))
    active_nics     = optional(list(string))
    teaming_policy  = optional(string)
    notify_switches = optional(string)
    failback        = optional(string)
  })
  default = {}
}

variable "security_policy" {
  type = object({
    allow_promiscuous      = optional(bool)
    allow_forged_transmits = optional(bool)
    allow_mac_changes      = optional(bool)
  })
  default = {}
}

variable "traffic_shaping" {
  type = object({
    shaping_average_bandwidth = optional(number)
    shaping_burst_size        = optional(number)
    shaping_enabled           = optional(bool)
    shaping_peak_bandwidth    = optional(number)
  })
  default = {}
}