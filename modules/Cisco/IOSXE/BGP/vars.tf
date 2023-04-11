variable "bgp" {
  type = list(object({
    asn                  = string
    default_ipv4_unicast = optional(bool)
    log_neighbor_changes = optional(bool)
    router_id_loopback   = optional(number)
    devices              = optional(string)
  }))
  default = []

  validation {
    condition     = var.bgp.router_id_loopback >= 0 && var.bgp.router_id_loopback <= 2147483647
    error_message = "`Must be a value between `0` and `2147483647`."
  }

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

  validation {
    condition     = contains(["flowspec", "labeled-unicast", "mdt", "multicast", "mvpn", "sr-policy", "tunnel", "unicast"], var.address_family.af_name)
    error_message = "Allowed values : flowspec, labeled-unicast, mdt, multicast, mvpn, sr-policy, tunnel, unicast."
  }
}

variable "l2vpn" {
  type = list(object({
    af_name = string
    asn     = string
    device  = optional(string)
  }))

  default = []

  description = "This resource can manage the BGP Address Family L2VPN configuration."

  validation {
    condition     = contains(["evpn", "vpls"], var.l2vpn.af_name)
    error_message = "Allowed values : evpn, vpls."
  }
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

  validation {
    condition     = contains(["both", "extended", "standard"], var.neighbor.send_community)
    error_message = "Allewd values : both, extended, standard."
  }
}