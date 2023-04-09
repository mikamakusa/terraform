variable "devices" {
  type = map(object({
    ipv6        = bool
    bgp         = number
    loopback_id = number
    af_name     = string
    loopback = list(object({
      device       = string
      ipv4_address = string
    }))
    vrf = object({
      name                   = string
      advertise_l2vpn_evpn   = optional(bool)
      redistribute_connected = optional(bool)
      redistribute_static    = optional(bool)
    })
  }))

  validation {
    condition     = var.devices.bgp >= 0 && var.devices.bgp <= 4294967295
    error_message = "`Must be a value between `0` and `4294967295`."
  }

  validation {
    condition     = var.devices.loopback_id >= 0 && var.devices.loopback_id <= 2147483647
    error_message = "`Must be a value between `0` and `2147483647`."
  }

  validation {
    condition     = contains(["flowspec", "labeled-unicast", "mdt", "multicast", "mvpn", "sr-policy", "tunnel", "unicast"], var.devices.af_name)
    error_message = "Allowed values : flowspec, labeled-unicast, mdt, multicast, mvpn, sr-policy, tunnel, unicast."
  }

  validation {
    condition = alltrue([
      for v in var.devices.loopback : can(regex("^\\d+\\.\\d+\\.\\d+\\.\\d+$", v.ipv4_address))
    ])
    error_message = "`ipv4_address`: Allowed formats are: `192.168.1.1`."
  }
}