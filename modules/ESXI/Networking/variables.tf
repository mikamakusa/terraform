variable "vswitch" {
  type = map(object({
    port = optional(number)
    mtu = optional(number)
    promiscuous_mode = optional(bool)
    mac_changes = optional(bool)
    forged_transmits = optional(bool)
    uplink = list(string)
    }))
}

variable "portgroup" {
  type = map(object({
    vswitch = string
    vlan = optional(string)
    }))
  default = {}
}