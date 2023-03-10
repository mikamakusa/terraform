variable "vnic" {
  type = object({
    host                    = string
    portgroup               = optional(string)
    distributed_switch_port = optional(string)
    distributed_port_group  = optional(string)
    mac                     = optional(string)
    mtu                     = optional(string)
    netstack                = optional(string)
    ipv4 = optional(object({
      dhcp    = optional(bool)
      ip      = optional(string)
      netmask = optional(string)
      gw      = optional(string)
    }))
    ipv6 = optional(object({
      dhcp       = optional(bool)
      autoconfig = optional(bool)
      addresses  = optional(list(string))
      gw         = optional(string)
    }))
  })
}