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

  validation {
    condition     = contains(["GigabitEthernet", "TwoGigabitEthernet", "FiveGigabitEthernet", "TenGigabitEthernet", "TwentyFiveGigE", "FortyGigabitEthernet", "HundredGigE", "TwoHundredGigE", "FourHundredGigE"], var.switchport.type)
    error_message = "Allowed values : GigabitEthernet, TwoGigabitEthernet, FiveGigabitEthernet, TenGigabitEthernet, TwentyFiveGigE, FortyGigabitEthernet, HundredGigE, TwoHundredGigE, FourHundredGigE."
  }

  validation {
    condition     = var.switchport.trunk_native_vlan >= 1 && var.switchport.trunk_native_vlan <= 4094
    error_message = "Allowed range value : 1 to 4094."
  }
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

  validation {
    condition     = var.vlan.vlan_id >= 1 && var.vlan.vlan_id <= 4094
    error_message = "Allowed range value : 1 to 4094."
  }

  validation {
    condition     = var.vlan.evpn_instance >= 1 && var.vlan.evpn_instance <= 65535
    error_message = "Allowed range value : 1 to 65535."
  }

  validation {
    condition     = var.vlan.evpn_instance_vni >= 4096 && var.vlan.evpn_instance_vni <= 16777215
    error_message = "Allowed range value : 4096 to 16777215."
  }

  validation {
    condition     = var.vlan.vni >= 4096 && var.vlan.vni <= 16777215
    error_message = "Allowed range value : 4096 to 16777215."
  }
}