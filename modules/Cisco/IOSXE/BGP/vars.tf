variable "bgp" {
  type = list(object({
    asn                  = string
    default_ipv4_unicast = optional(bool)
    log_neighbor_changes = optional(bool)
    router_id_loopback   = optional(number)
    devices              = optional(string)
  }))

  default = []

  description = "This resource can manage the BGP configuration."
}

variable "address_family" {
  type = list(object({
    af_name = string
    asn     = string
    ipv4    = bool
    device  = optional(string)
    vrfs = optional(
      object({
        name                   = optional(string)
        advertise_l2vpn_evpn   = optional(bool)
        redistribute_connected = optional(bool)
        redistribute_static    = optional(bool)
    }))
  }))

  default = []

  description = "This resource can manage the BGP Address Family IPv4 / IPv6 VRF configuration."
}

variable "l2vpn" {
  type = list(object({
    af_name = string
    asn     = string
    device  = optional(string)
  }))

  default = []

  description = "This resource can manage the BGP Address Family L2VPN configuration."
}

variable "neighbor" {
  type = list(object({
    asn                    = string
    ip                     = string
    unicast                = optional(bool)
    evpn                   = optional(bool)
    vrf                    = optional(string)
    activate               = optional(bool)
    description            = optional(string)
    device                 = optional(string)
    remote_as              = optional(string)
    route_reflector_client = optional(string)
    shutdown               = optional(bool)
    update_source_loopback = optional(string)
    send_community         = optional(string)
  }))

  default = []

  description = "This resource can manage the BGP IPv4 Unicast VRF  or eVPN Neighbor configuration."
}