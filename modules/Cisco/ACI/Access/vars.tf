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

variable "lldp_interface_policy" {
  type = map(object({
    description = optional(string)
    annotation  = optional(string)
    name_alias  = optional(string)
    admin_tx_st = optional(string)
    admin_rx_st = optional(string)
  }))

  validation {
    condition     = contains(["disabled", "enabled"], var.lldp_interface_policy.admin_rx_st)
    error_message = "Allow values : 'disabled', 'enabled'."
  }

  validation {
    condition     = contains(["disabled", "enabled"], var.lldp_interface_policy.admin_tx_st)
    error_message = "Allow values : 'disabled', 'enabled'."
  }
}

variable "mcp_instance_policy" {
  type = map(object({
    annotation       = optional(string)
    description      = optional(string)
    ctrl             = optional(list(string))
    init_delay_time  = optional(string)
    name_alias       = optional(string)
    loop_detect_mult = optional(string)
    loop_detect_act  = optional(string)
    tx_freq          = optional(string)
    tx_freq_msec     = optional(string)
    admin_st         = optional(string)
  }))

  validation {
    condition     = contains(["disabled", "enabled"], var.mcp_instance_policy.admin_st)
    error_message = "Allow values : 'disabled', 'enabled'."
  }

  validation {
    condition     = contains(["stateful-ha", "pdu-per-vlan"], var.mcp_instance_policy.ctrl)
    error_message = "Allow values : 'stateful-ha', 'pdu-per-vlan'."
  }

  validation {
    condition     = contains(["port-disable", "none"], var.mcp_instance_policy.ctrl)
    error_message = "Allow values : 'port-disable', 'none'."
  }

  validation {
    condition     = var.mcp_instance_policy.init_delay_time >= 0 && var.mcp_instance_policy.init_delay_time <= 1800
    error_message = "Allow range : 0 to 1800."
  }

  validation {
    condition     = var.mcp_instance_policy.loop_detect_mult >= 1 && var.mcp_instance_policy.loop_detect_mult <= 255
    error_message = "Allow range : 1 to 255."
  }

  validation {
    condition     = var.mcp_instance_policy.tx_freq >= 0 && var.mcp_instance_policy.tx_freq <= 300
    error_message = "Allow range : 0 to 300."
  }

  validation {
    condition     = var.mcp_instance_policy.init_delay_time >= 0 && var.mcp_instance_policy.init_delay_time <= 999
    error_message = "Allow range : 0 to 999."
  }
}

variable "vlan_pool" {
  type = map(object({
    alloc_mode  = string
    description = optional(string)
    annotation  = optional(string)
    name_alias  = optional(string)
    role        = optional(string)
    from        = string
    to          = string
  }))

  validation {
    condition     = contains(["dynamic", "static", "inherit"], var.vlan_pool.alloc_mode)
    error_message = "Allowed values : 'dynamic', 'static', inherit."
  }

  validation {
    condition     = contains(["external", "internal"], var.vlan_pool.role)
    error_message = "Allow values : 'external', 'internal'."
  }

  validation {
    condition     = contains(["vlan-1", "vlan-4094"], var.vlan_pool.from)
    error_message = "Allow values : min : 'vlan-1', max : 'vlan-4094'."
  }

  validation {
    condition     = contains(["vlan-1", "vlan-4094"], var.vlan_pool.to)
    error_message = "Allow values : min : 'vlan-1', max : 'vlan-4094'."
  }
}

variable "spanning_tree_interface_policy" {
  type = map(object({
    ctrl        = optional(string)
    description = optional(string)
    annotation  = optional(string)
    name_alias  = optional(string)
  }))

  validation {
    condition     = contains(["bpdu-filter", "bpdu-guard", "unspecified"], var.spanning_tree_interface_policy.ctrl)
    error_message = "Allow values : 'bpdu-filter', 'bpdu-guard', 'unspecified'."
  }
}

variable "vmm_domain" {
  type = map(object({
    provider_profile_dn = string
    access_mode         = optional(string)
    annotation          = optional(string)
    arp_learning        = optional(string)
    enable_ave          = optional(string)
    ave_time_out        = optional(string)
    config_infra_pg     = optional(string)
    ctrl_knob           = optional(string)
    delimiter           = optional(string)
    enable_tag          = optional(string)
    enable_vm_folder    = optional(string)
    encap_mode          = optional(string)
    enf_pref            = optional(string)
    ep_inventory_type   = optional(string)
    ep_ret_time         = optional(string)
    hv_avail_monitor    = optional(string)
    mcast_addr          = optional(string)
    mode                = optional(string)
    name_alias          = optional(string)
    pref_encap_mode     = optional(string)
  }))

  validation {
    condition     = contains(["Microsoft", "CloudFoundry", "Openshift", "Openstack", "VMware", "Kubernetes", "Redhat"], var.vmm_domain.provider_profile_dn)
    error_message = "Allowed values : \"Microsoft\", \"CloudFoundry\", \"Openshift\", \"Openstack\", \"VMware\", \"Kubernetes\", \"Redhat\"."
  }

  validation {
    condition     = contains(["read-write", "read-only"], var.vmm_domain.access_mode)
    error_message = "Allowed values : \"read-write\", \"read-only\"."
  }

  validation {
    condition     = contains(["enabled", "disabled"], var.vmm_domain.arp_learning)
    error_message = "Allowed values : \"enabled\", \"disabled\"."
  }

  validation {
    condition     = contains(["yes", "no"], var.vmm_domain.config_infra_pg)
    error_message = "Allowed values : \"yes\", \"no\"."
  }

  validation {
    condition     = contains(["epDpVerify", "none"], var.vmm_domain.ctrl_knob)
    error_message = "Allowed values : \"epDpVerify\", \"none\"."
  }

  validation {
    condition     = contains(["yes", "no"], var.vmm_domain.enable_tag)
    error_message = "Allowed values : \"yes\", \"no\"."
  }

  validation {
    condition     = contains(["yes", "no"], var.vmm_domain.enable_ave)
    error_message = "Allowed values : \"yes\", \"no\"."
  }

  validation {
    condition     = contains(["yes", "no"], var.vmm_domain.enable_vm_folder)
    error_message = "Allowed values : \"yes\", \"no\"."
  }

  validation {
    condition     = contains(["unknown", "vlan", "vxlan"], var.vmm_domain.encap_mode)
    error_message = "Allowed values : \"unknown\", \"vlan\", \"vxlan\"."
  }

  validation {
    condition     = contains(["hw", "sw", "unknown"], var.vmm_domain.enf_pref)
    error_message = "Allowed values : \"hw\", \"sw\", \"unknown\"."
  }

  validation {
    condition     = contains(["none", "on-link"], var.vmm_domain.ep_inventory_type)
    error_message = "Allowed values : \"none\", \"on-link\"."
  }

  validation {
    condition     = contains(["yes", "no"], var.vmm_domain.hv_avail_monitor)
    error_message = "Allowed values : \"yes\", \"no\"."
  }

  validation {
    condition     = contains(["default", "n1kv", "unknown", "ovs", "k8s", "cf", "openshift"], var.vmm_domain.mode)
    error_message = "Allowed values : \"default\", \"n1kv\", \"unknown\", \"ovs\", \"k8s\", \"cf\", \"openshift\"."
  }

  validation {
    condition     = contains(["unspecified", "vlan", "vxlan"], var.vmm_domain.pref_encap_mode)
    error_message = "Allowed values : \"unspecified\", \"vlan\", \"vxlan\"."
  }

  validation {
    condition     = var.vmm_domain.ave_time_out >= 10 && var.vmm_domain.ave_time_out <= 300
    error_message = "Allowed range value : 10 to 300."
  }

  validation {
    condition     = var.vmm_domain.ep_ret_time >= 0 && var.vmm_domain.ep_ret_time <= 600
    error_message = "Allowed range value : 0 to 600."
  }
}

variable "vmm_controller" {
  type = map(object({
    host_or_ip          = string
    root_cont_name      = string
    annotation          = optional(string)
    dvs_version         = optional(string)
    inventory_trig_st   = optional(string)
    mode                = optional(string)
    msft_config_err_msg = optional(string)
    msft_config_issues  = optional(list(string))
    n1kv_stats_mode     = optional(string)
    port                = optional(string)
    scope               = optional(string)
    stats_mode          = optional(string)
    seq_num             = optional(string)
    vxlan_depl_pref     = optional(string)
  }))

  validation {
    condition     = contains(["5.1", "5.5", "6.0", "6.5", "6.6", "7.0", "unmanaged"], var.vmm_controller.dvs_version)
    error_message = "Allowed values : \"5.1\", \"5.5\", \"6.0\", \"6.5\", \"6.6\", \"7.0\" and \"unmanaged\"."
  }

  validation {
    condition     = contains(["autoTriggered", "triggered", "untriggered"], var.vmm_controller.inventory_trig_st)
    error_message = "Allowed values : \"autoTriggered\", \"triggered\", \"untriggered\"."
  }

  validation {
    condition     = contains(["cf", "default", "k8s", "n1kv", "nsx", "openshift", "ovs", "rancher", "rhev", "unknown"], var.vmm_controller.mode)
    error_message = "Allowed values : \"cf\", \"default\", \"k8s\", \"n1kv\", \"nsx\", \"openshift\", \"ovs\", \"rancher\", \"rhev\", \"unknown\"."
  }

  validation {
    condition     = contains(["aaacert-invalid", "duplicate-mac-in-inventory", "duplicate-rootContName", "invalid-object-in-inventory", "invalid-rootContName", "inventory-failed", "missing-hostGroup-in-cloud", "missing-rootContName", "not-applicable", "zero-mac-in-inventory"], var.vmm_controller.msft_config_issues)
    error_message = "Allowed values : \"aaacert-invalid\", \"duplicate-mac-in-inventory\", \"duplicate-rootContName\", \"invalid-object-in-inventory\", \"invalid-rootContName\", \"inventory-failed\", \"missing-hostGroup-in-cloud\", \"missing-rootContName\", \"not-applicable\", \"zero-mac-in-inventory\"."
  }

  validation {
    condition     = contains(["disabled", "enabled", "unknown"], var.vmm_controller.n1kv_stats_mode)
    error_message = "Allowed values : \"disabled\", \"enabled\", \"unknown\"."
  }

  validation {
    condition     = contains(["MicrosoftSCVMM", "cloudfoundry", "iaas", "kubernetes", "network", "nsx", "openshift", "openstack", "rhev", "unmanaged", "vm"], var.vmm_controller.scope)
    error_message = "Allowed values : \"MicrosoftSCVMM\", \"cloudfoundry\", \"iaas\", \"kubernetes\", \"network\", \"nsx\", \"openshift\", \"openstack\", \"rhev\", \"unmanaged\", \"vm\"."
  }

  validation {
    condition     = contains(["disabled", "enabled", "unknown"], var.vmm_controller.stats_mode)
    error_message = "Allowed values : \"disabled\", \"enabled\", \"unknown\"."
  }

  validation {
    condition     = contains(["nsx", "vxlan"], var.vmm_controller.vxlan_depl_pref)
    error_message = "Allowed values : \"nsx\", \"vxlan\"."
  }
}

variable "vmm_credential" {
  type = map(object({
    annotation    = optional(string)
    description   = optional(string)
    name_alias    = optional(string)
    pwd           = optional(string)
    usr           = optional(string)
  }))
}

variable "vpc_domain_policy" {
  type = map(object({
    annotation  = optional(string)
    dead_intvl  = optional(string)
    name_alias  = optional(string)
    description = optional(string)
  }))

  validation {
    condition     = var.vpc_domain_policy.dead_intvl >= 5 && var.vpc_domain_policy.dead_intvl <= 600
    error_message = "Allowed range value : 5 to 600."
  }
}

variable "vswitch_policy" {
  type = map(object({
    annotation    = optional(string)
    description   = optional(string)
    name_alias    = optional(string)
  }))
}

variable "port_security_policy" {
  type = map(object({
    annotation  = optional(string)
    description = optional(string)
    name_alias  = optional(string)
    maximum     = optional(string)
    timeout     = optional(string)
  }))

  validation {
    condition     = var.port_security_policy.maximum >= 0 && var.port_security_policy.maximum <= 12000
    error_message = "Allowed range value : 0 to 12000."
  }

  validation {
    condition     = var.port_security_policy.timeout >= 60 && var.port_security_policy.timeout <= 3600
    error_message = "Allowed range value : 60 to 3600."
  }
}

variable "qos_instance_policy" {
  type = map(object({
    description           = optional(string)
    etrap_age_timer       = optional(string)
    etrap_bw_thresh       = optional(string)
    etrap_byte_ct         = optional(string)
    etrap_st              = optional(string)
    fabric_flush_interval = optional(string)
    fabric_flush_st       = optional(string)
    annotation            = optional(string)
    ctrl                  = optional(string)
    uburst_spine_queues   = optional(string)
    uburst_tor_queues     = optional(string)
  }))

  validation {
    condition     = var.qos_instance_policy.fabric_flush_interval >= 100 && var.qos_instance_policy.fabric_flush_interval <= 1000
    error_message = "Allowed range value : 100 to 1000."
  }

  validation {
    condition     = var.qos_instance_policy.uburst_spine_queues >= 0 && var.qos_instance_policy.uburst_spine_queues <= 100
    error_message = "Allowed range value : 0 to 100."
  }

  validation {
    condition     = var.qos_instance_policy.uburst_tor_queues >= 0 && var.qos_instance_policy.uburst_tor_queues <= 100
    error_message = "Allowed range value : 0 to 100."
  }

  validation {
    condition     = contains(["dot1p-preserve", "none"], var.qos_instance_policy.ctrl)
    error_message = "Allowed values : \"dot1p-preserve\", \"none\"."
  }

  validation {
    condition     = contains(["no", "yes"], var.qos_instance_policy.fabric_flush_st)
    error_message = "Allowed values : \"yes\", \"no\"."
  }
}