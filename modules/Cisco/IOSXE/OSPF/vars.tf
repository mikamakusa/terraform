variable "interface" {
  type = map(object({
    type                             = string
    cost                             = optional(number)
    dead_interval                    = optional(number)
    hello_interval                   = optional(number)
    mtu_ignore                       = optional(bool)
    network_type_broadcast           = optional(bool)
    network_type_non_broadcast       = optional(bool)
    network_type_point_to_multipoint = optional(bool)
    network_type_point_to_point      = optional(bool)
    priority                         = optional(number)
    device                           = optional(string)
  }))

  validation {
    condition     = contains(["GigabitEthernet", "TwoGigabitEthernet", "FiveGigabitEthernet", "TenGigabitEthernet", "TwentyFiveGigE", "FortyGigabitEthernet", "HundredGigE", "TwoHundredGigE", "FourHundredGigE", "Loopback", "Vlan"], var.interface.type)
    error_message = "Allowed values : GigabitEthernet, TwoGigabitEthernet, FiveGigabitEthernet, TenGigabitEthernet, TwentyFiveGigE, FortyGigabitEthernet, HundredGigE, TwoHundredGigE, FourHundredGigE, Loopback, Vlan."
  }

  validation {
    condition     = var.interface.dead_interval >= 1 && var.interface.dead_interval <= 65535
    error_message = "Allowed range values : 1 to 65535."
  }

  validation {
    condition     = var.interface.hello_interval >= 1 && var.interface.hello_interval <= 65535
    error_message = "Allowed range values : 1 to 65535"
  }

  validation {
    condition     = var.interface.priority >= 0 && var.interface.priority <= 255
    error_message = "Allowed range values : 0 to 255"
  }
}

variable "ospf_process" {
  type = map(object({
    type       = string
    process_id = optional(number)
    device     = optional(string)
    area = optional(object({
      area_id = optional(string)
    }))
  }))

  validation {
    condition     = contains(["GigabitEthernet", "TwoGigabitEthernet", "FiveGigabitEthernet", "TenGigabitEthernet", "TwentyFiveGigE", "FortyGigabitEthernet", "HundredGigE", "TwoHundredGigE", "FourHundredGigE", "Loopback", "Vlan"], var.ospf_process.type)
    error_message = "Allowed values : GigabitEthernet, TwoGigabitEthernet, FiveGigabitEthernet, TenGigabitEthernet, TwentyFiveGigE, FortyGigabitEthernet, HundredGigE, TwoHundredGigE, FourHundredGigE, Loopback, Vlan."
  }

  validation {
    condition     = var.ospf_process.process_id >= 1 && var.ospf_process.process_id <= 65535
    error_message = "Allowed range values : 1 to 65535."
  }
}

variable "ospf" {
  type = map(object({
    device                               = optional(string)
    bfd_all_interfaces                   = optional(bool)
    default_information_originate        = optional(bool)
    default_information_originate_always = optional(bool)
    default_metric                       = optional(number)
    distance                             = optional(number)
    domain_tag                           = optional(number)
    mpls_ldp_autoconfig                  = optional(bool)
    mpls_ldp_sync                        = optional(bool)
    priority                             = optional(number)
    router_id                            = optional(string)
    shutdown                             = optional(bool)
    vrf                                  = optional(bool)
    neighbor = optional(object({
      ip       = optional(string)
      cost     = optional(number)
      priority = optional(number)
    }))
    network = optional(object({
      area     = optional(string)
      ip       = optional(string)
      wildcard = optional(string)
    }))
    summary_address = optional(object({
      ip   = optional(string)
      mask = optional(string)
    }))
  }))

  validation {
    condition     = var.ospf.process_id >= 1 && var.ospf.process_id <= 65535
    error_message = "Allowed range values : 1 to 65535."
  }

  validation {
    condition     = var.ospf.default_metric >= 1 && var.ospf.default_metric <= 16777214
    error_message = "Allowed range values : 1 to 16777214."
  }

  validation {
    condition     = var.ospf.distance >= 1 && var.ospf.distance <= 255
    error_message = "Allowed range values : 1 to 255."
  }

  validation {
    condition     = var.ospf.domain_tag >= 1 && var.ospf.domain_tag <= 4294967295
    error_message = "Allowed range values : 1 to 4294967295."
  }

  validation {
    condition     = var.ospf.priority >= 1 && var.ospf.priority <= 127
    error_message = "Allowed range values : 1 to 127."
  }

  validation {
    condition     = var.ospf.neighbor.cost >= 1 && var.ospf.neighbor.cost <= 65535
    error_message = "Allowed range values : 1 to 65535."
  }

  validation {
    condition     = var.ospf.neighbor.priority >= 0 && var.ospf.neighbor.priority <= 255
    error_message = "Allowed range values : 0 to 255."
  }
}