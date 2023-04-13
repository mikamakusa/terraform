variable "vrf" {
  type = map(object({
    description         = optional(string)
    rd                  = optional(string)
    address_family_ipv4 = optional(bool)
    address_family_ipv6 = optional(bool)
    vpn_id              = optional(bool)
  }))

  description = "This resource can manage the VRF configuration."
}