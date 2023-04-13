variable "switchport" {
  type = map(object({
    type                          = string
    mode_access                   = optional(bool)
    mode_dot1q_tunnel             = optional(bool)
    mode_private_vlan_trunk       = optional(bool)
    mode_private_vlan_host        = optional(bool)
    mode_private_vlan_promiscuous = optional(bool)
    mode_trunk                    = optional(bool)
    nonegotiate                   = optional(bool)
    access_vlan                   = optional(string)
    trunk_allowed_vlans           = optional(string)
    trunk_native_vlan_tag         = optional(bool)
    trunk_native_vlan             = optional(number)
    host                          = optional(bool)
    device                        = optional(string)
  }))

  default = {}

  description = "This data source can read the Interface Switchport configuration."
}

variable "vlan" {
  type = map(object({
    vlan_id                  = number
    shutdown                 = optional(bool)
    private_vlan_association = optional(string)
    private_vlan_community   = optional(string)
    private_vlan_isolated    = optional(string)
    private_vlan_primary     = optional(string)
    remote_span              = optional(string)
    device                   = optional(string)
    access_vfi               = optional(string)
    vni                      = optional(number)
    evpn_instance            = optional(number)
    evpn_instance_vni        = optional(number)
  }))

  default = {}

  description = "This data source can read the VLAN configuration."
}