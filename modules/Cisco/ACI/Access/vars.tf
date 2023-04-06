variable "access_generic" {
  type = map(object({
    annotation  = optional(string)
    description = optional(string)
    name_alias  = optional(string)
  }))
}

variable "cdp_interface_policy" {
  type = map(object({
    admin_st    = optional(string)
    annotation  = optional(string)
    description = optional(string)
    name_alias  = optional(string)
  }))

  validation {
    condition     = contains(["enabled", "disabled"], var.cdp_interface_policy.admin_st)
    error_message = "Allowed values: 'enabled', 'disabled'."
  }
}

variable "error_disable_recovery" {
  type = map(object({
    annotation          = optional(string)
    description         = optional(string)
    name_alias          = optional(string)
    err_dis_recov_intvl = optional(string)
    edr_event = optional(object({
      event = string
    }))
  }))

  validation {
    condition     = var.error_disable_recovery.err_dis_recov_intvl >= 30 && var.error_disable_recovery.err_dis_recov_intvl <= 65535
    error_message = "Allowed range is '30' - '65535'."
  }

  validation {
    condition     = contains(["event-arp-inspection", "event-bpduguard", "event-debug-1", "event-debug-2", "event-debug-3", "event-debug-4", "event-debug-5", "event-dhcp-rate-lim", "event-ep-move", "event-ethpm", "event-ip-addr-conflict", "event-ipqos-dcbxp-compat-failure", "event-ipqos-mgr-error", "event-link-flap", "event-loopback", "event-mcp-loop", "event-psec-violation", "event-sec-violation", "event-set-port-state-failed", "event-storm-ctrl", "event-stp-inconsist-vpc-peerlink", "event-syserr-based", "event-udld", "unknown"], var.error_disable_recovery.edr_event.event)
    error_message = "Allowed values are 'event-arp-inspection', 'event-bpduguard', 'event-debug-1', 'event-debug-2', 'event-debug-3', 'event-debug-4', 'event-debug-5', 'event-dhcp-rate-lim', 'event-ep-move', 'event-ethpm', 'event-ip-addr-conflict', 'event-ipqos-dcbxp-compat-failure', 'event-ipqos-mgr-error', 'event-link-flap', 'event-loopback', 'event-mcp-loop', 'event-psec-violation', 'event-sec-violation', 'event-set-port-state-failed', 'event-storm-ctrl', 'event-stp-inconsist-vpc-peerlink', 'event-syserr-based', 'event-udld', 'unknown'."
  }
}

variable "fabric_if_pol" {
  type = map(object({
    annotation    = optional(string)
    description   = optional(string)
    name_alias    = optional(string)
    auto_neg      = optional(string)
    fec_mode      = optional(string)
    link_debounce = optional(number)
    speed         = optional(string)
  }))

  validation {
    condition     = contains(["on", "off"], var.fabric_if_pol.auto_neg)
    error_message = "Allowed values: 'on', 'off'."
  }

  validation {
    condition     = contains(["inherit", "cl91-rs-fec", "cl74-fc-fec", "ieee-rs-fec", "cons16-rs-fec", "kp-fec", "disable-fec"], var.fabric_if_pol.fec_mode)
    error_message = "Allowed values: 'inherit', 'cl91-rs-fec', 'cl74-fc-fec', 'ieee-rs-fec', 'cons16-rs-fec', 'kp-fec', 'disable-fec'."
  }

  validation {
    condition     = var.fabric_if_pol.link_debounce >= 0 && var.fabric_if_pol.link_debounce <= 5000
    error_message = "Range of allowed values: '0' to '5000'."
  }

  validation {
    condition     = contains(["unknown", "100M", "1G", "10G", "25G", "40G", "50G", "100G", "200G", "400G", "inherit"], var.fabric_if_pol.speed)
    error_message = "Allowed values : 'unknown', '100M', '1G', '10G', '25G', '40G', '50G', '100G', '200G', '400G', 'inherit'."
  }
}

variable "l2_interface_policy" {
  type = map(object({
    annotation  = optional(string)
    description = optional(string)
    name_alias  = optional(string)
    qinq        = optional(string)
    vepa        = optional(string)
    vlan_scope  = optional(string)
  }))

  validation {
    condition     = contains(["disabled", "edgePort", "corePort", "doubleQtagPort"], var.l2_interface_policy.qinq)
    error_message = "Allowed values are 'disabled', 'edgePort', 'corePort' and 'doubleQtagPort'."
  }

  validation {
    condition     = contains(["enabled", "disabled"], var.l2_interface_policy.vepa)
    error_message = "Allowed values: 'enabled', 'disabled'."
  }

  validation {
    condition     = contains(["global", "portlocal"], var.l2_interface_policy.vlan_scope)
    error_message = "Allowed values: 'global', 'portlocal'."
  }
}

variable "lacp_policy" {
  type = map(object({
    description = optional(string)
    annotation  = optional(string)
    name_alias  = optional(string)
    ctrl        = optional(list(string))
    max_links   = optional(string)
    min_links   = optional(string)
    mode        = optional(string)
  }))

  validation {
    condition     = contains(["symmetric-hash", "susp-individual", "graceful-conv", "load-defer", "fast-sel-hot-stdby"], var.lacp_policy.ctrl)
    error_message = "Allowed values : 'symmetric-hash', 'susp-individual', 'graceful-conv', 'load-defer' and 'fast-sel-hot-stdby'."
  }

  validation {
    condition     = contains(["off", "active", "passive", "mac-pin", "mac-pin-unload"], var.lacp_policy.mode)
    error_message = "Allowed values : 'off', 'active', 'passive', 'mac-pin' and 'mac-pin-unload'."
  }

  validation {
    condition     = var.lacp_policy.max_links >= 1 && var.lacp_policy.max_links <= 16
    error_message = "Allowed range : 1 to 16."
  }

  validation {
    condition     = var.lacp_policy.min_links >= 1 && var.lacp_policy.min_links <= 16
    error_message = "Allowed range : 1 to 16."
  }
}

variable "leaf_access_bundle_policy_group" {
  type = map(object({
    annotation  = optional(string)
    description = optional(string)
    name_alias  = optional(string)
    lag_t       = optional(string)
  }))

  validation {
    condition     = contains(["not-aggregated", "node", "link"], var.leaf_access_bundle_policy_group.lag_t)
    error_message = "Allowed values : 'not-aggregated', 'node', 'link'."
  }
}

variable "leaf_breakout_port_group" {
  type = map(object({
    annotation  = optional(string)
    description = optional(string)
    name_alias  = optional(string)
    brkout_map  = optional(string)
  }))

  validation {
    condition     = contains(["100g-2x", "100g-4x", "10g-4x", "25g-4x", "50g-8x", "none"], var.leaf_breakout_port_group.brkout_map)
    error_message = "Allowed values : '100g-2x', '100g-4x', '10g-4x', '25g-4x', '50g-8x' and 'none'."
  }
}