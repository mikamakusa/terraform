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
}