variable "interface_pim" {
  type = map(object({
    type              = string
    passive           = optional(bool)
    dense_mode        = optional(bool)
    sparse_mode       = optional(bool)
    sparse_dense_mode = optional(bool)
    bfd               = optional(bool)
    border            = optional(bool)
    bsr_border        = optional(bool)
    dr_priority       = optional(number)
    device            = optional(string)
  }))

  default = {}

  description = "This resource can manage the Interface PIM configuration."
}

variable "msdp" {
  type = list(object({
    device        = optional(string)
    originator_id = optional(string)
    passwords = optional(list(object({
      password   = string
      addr       = optional(string)
      encryption = optional(number)
    })))
    peers = optional(list(object({
      addr                    = optional(string)
      connect_source_loopback = optional(number)
      remote_as               = optional(number)
    })))
  }))

  default = []

  description = "This resource can manage the MSDP configuration."
}

variable "msdp_vrf" {
  type = list(object({
    device        = optional(string)
    originator_id = optional(string)
    vrf           = optional(string)
    passwords = optional(list(object({
      password   = string
      addr       = optional(string)
      encryption = optional(number)
    })))
    peers = optional(list(object({
      addr                    = optional(string)
      connect_source_loopback = optional(number)
      remote_as               = optional(number)
    })))
  }))

  default = []

  description = "This resource can manage the MSDP VRF configuration."
}

variable "pim" {
  type = list(object({
    autorp                            = optional(bool)
    autorp_listener                   = optional(bool)
    device                            = optional(string)
    bsr_candidate_loopback            = optional(number)
    bsr_candidate_mask                = optional(number)
    bsr_candidate_priority            = optional(number)
    bsr_candidate_accept_rp_candidate = optional(string)
    ssm_range                         = optional(string)
    ssm_default                       = optional(bool)
    rp_address                        = optional(string)
    rp_address_override               = optional(bool)
    rp_address_bidir                  = optional(bool)
    rp_addresses = optional(list(object({
      access_list = optional(string)
      bidir       = optional(bool)
      override    = optional(bool)
      rp_address  = optional(string)
    })))
    rp_candidates = optional(list(object({
      bidir      = optional(bool)
      group_list = optional(string)
      interface  = optional(string)
      interval   = optional(number)
      priority   = optional(number)
    })))
  }))

  default = []

  description = "This resource can manage the PIM configuration."
}

variable "pim_vrf" {
  type = list(object({
    vrf                               = optional(string)
    autorp                            = optional(bool)
    autorp_listener                   = optional(bool)
    device                            = optional(string)
    bsr_candidate_loopback            = optional(number)
    bsr_candidate_mask                = optional(number)
    bsr_candidate_priority            = optional(number)
    bsr_candidate_accept_rp_candidate = optional(string)
    ssm_range                         = optional(string)
    ssm_default                       = optional(bool)
    rp_address                        = optional(string)
    rp_address_override               = optional(bool)
    rp_address_bidir                  = optional(bool)
    rp_addresses = optional(list(object({
      access_list = optional(string)
      bidir       = optional(bool)
      override    = optional(bool)
      rp_address  = optional(string)
    })))
    rp_candidates = optional(list(object({
      bidir      = optional(bool)
      group_list = optional(string)
      interface  = optional(string)
      interval   = optional(number)
      priority   = optional(number)
    })))
  }))

  default = []

  description = "This resource can manage the PIM VRF configuration."
}