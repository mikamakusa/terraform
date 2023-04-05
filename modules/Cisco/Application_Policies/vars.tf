variable "tenant" {
  type = map(object({
    annotation  = optional(string)
    name_alias  = optional(string)
    description = optional(string)
  }))
  description = "Manages ACI tenant"
}

variable "vrf" {
  type = map(object({
    tenant_dn              = string
    annotation             = optional(string)
    description            = optional(string)
    bd_enforced_enable     = optional(string)
    ip_data_plane_learning = optional(string)
    knw_mcast_act          = optional(string)
    name_alias             = optional(string)
    pc_enf_dir             = optional(string)
    pc_enf_pref            = optional(string)
  }))

  validation {
    condition     = contains(["yes", "no"], var.vrf.bd_enforced_enable)
    error_message = "Allowed values are 'yes' and 'no'."
  }

  validation {
    condition     = contains(["enabled", "disabled"], var.vrf.ip_data_plane_learning)
    error_message = "Allowed values are 'enabled' and 'disabled'."
  }

  validation {
    condition     = contains(["permit", "deny"], var.vrf.knw_mcast_act)
    error_message = "Allowed values are 'permit' and 'deny'."
  }

  validation {
    condition     = contains(["egress", "ingress"], var.vrf.pc_enf_dir)
    error_message = "Allowed values are 'egress' and 'ingress'."
  }

  validation {
    condition     = contains(["enforced", "unenforced"], var.vrf.pc_enf_pref)
    error_message = "Allowed values are 'enforced' and 'unenforced'."
  }

  description = <<EOF
    Manages ACI VRF :
      - bd_enforced_enabled is a flag used to enable or disable bridge domain for VRF.
      - ip_data_plane_learning specifies if known multicast is forwarded or not.
      - pc_enf_dir is about Policy Control Direction Enforcement, allowed values are 'egress' and 'ingress'
      - pc_enf_pref determines if the fabric should enforce contract policies to allow routing and packet forwarding
EOF
}

variable "bridge_domain" {
  type = map(object({
    tenant_dn                   = string
    optimize_wan_bandwidth      = optional(string)
    annotation                  = optional(string)
    description                 = optional(string)
    arp_flood                   = optional(string)
    ep_clear                    = optional(string)
    ep_move_detect_mode         = optional(string)
    host_based_routing          = optional(string)
    intersite_bum_traffic_allow = optional(string)
    intersite_l2_stretch        = optional(string)
    ip_learning                 = optional(string)
    ipv6_mcast_allow            = optional(string)
    limit_ip_learn_to_subnets   = optional(string)
    ll_addr                     = optional(string)
    mac                         = optional(string)
    mcast_allow                 = optional(string)
    multi_dst_pkt_act           = optional(string)
    name_alias                  = optional(string)
    bridge_domain_type          = optional(string)
    unicast_route               = optional(string)
    unk_mac_ucast_act           = optional(string)
    unk_mcast_act               = optional(string)
    v6unk_mcast_act             = optional(string)
  }))

  validation {
    condition     = contains(["yes", "no"], var.bridge_domain.optimize_wan_bandwidth)
    error_message = "Allowed values are 'yes' and 'no'."
  }

  validation {
    condition     = contains(["yes", "no"], var.bridge_domain.arp_flood)
    error_message = "Allowed values are 'yes' and 'no'."
  }

  validation {
    condition     = contains(["yes", "no"], var.bridge_domain.ep_clear)
    error_message = "Allowed values are 'yes' and 'no'."
  }

  validation {
    condition     = contains(["garp", "disable"], var.bridge_domain.ep_move_detect_mode)
    error_message = "Allowed values are 'garp' and 'disable'."
  }

  validation {
    condition     = contains(["yes", "no"], var.bridge_domain.host_based_routing)
    error_message = "Allowed values are 'yes' and 'no'."
  }

  validation {
    condition     = contains(["yes", "no"], var.bridge_domain.intersite_bum_traffic_allow)
    error_message = "Allowed values are 'yes' and 'no'."
  }

  validation {
    condition     = contains(["yes", "no"], var.bridge_domain.intersite_l2_stretch)
    error_message = "Allowed values are 'yes' and 'no'."
  }

  validation {
    condition     = contains(["yes", "no"], var.bridge_domain.ip_learning)
    error_message = "Allowed values are 'yes' and 'no'."
  }

  validation {
    condition     = contains(["yes", "no"], var.bridge_domain.ipv6_mcast_allow)
    error_message = "Allowed values are 'yes' and 'no'."
  }

  validation {
    condition     = contains(["yes", "no"], var.bridge_domain.limit_ip_learn_to_subnets)
    error_message = "Allowed values are 'yes' and 'no'."
  }

  validation {
    condition     = contains(["yes", "no"], var.bridge_domain.mcast_allow)
    error_message = "Allowed values are 'yes' and 'no'."
  }

  validation {
    condition     = contains(["bd-flood", "encap-flood"], var.bridge_domain.multi_dst_pkt_act)
    error_message = "Allowed values are 'bd-flood' and 'encap-flood'."
  }

  validation {
    condition     = contains(["regular", "fc"], var.bridge_domain.bridge_domain_type)
    error_message = "Allowed values are 'regular' and 'fc'."
  }

  validation {
    condition     = contains(["yes", "no"], var.bridge_domain.unicast_route)
    error_message = "Allowed values are 'yes' and 'no'."
  }

  validation {
    condition     = contains(["flood", "proxy"], var.bridge_domain.unk_mac_ucast_act)
    error_message = "Allowed values are 'flood' and 'proxy'."
  }

  validation {
    condition     = contains(["flood", "opt-flood"], var.bridge_domain.v6unk_mcast_act)
    error_message = "Allowed values are 'flood' and 'opt-flood'."
  }

  description = <<EOF
    Manages ACI Bridge Domain with following flags :
      - optimize_wan_bandwidth which enable it or not.
      - arp_fllod is a property to specify if arp flooding is enabled.
      - ep_clear represents the parameter used by the node (i.e. Leaf) to clear all EPs in all leaves for this BD
      - host_based_routing enables advertising host routes
      - mcast_allow which enable or not multicast
EOF
}

variable "subnet" {
  type = map(object({
    parent_dn   = string
    annotation  = optional(string)
    description = optional(string)
    ctrl        = optional(list(string))
    name_alias  = optional(string)
    preferred   = optional(string)
    scope       = optional(list(string))
    virtual     = optional(string)
  }))

  validation {
    condition     = contains(["unspecified", "querier", "nd", "no-default-gateway"], var.subnet.ctrl)
    error_message = "Allowed values are 'unspecified', 'querier', 'nd' and 'no-default-gateway'."
  }

  validation {
    condition     = contains(["yes", "no"], var.subnet.preferred)
    error_message = "Allowed values are 'yes' and 'no'."
  }

  validation {
    condition     = contains(["yes", "no"], var.subnet.virtual)
    error_message = "Allowed values are 'yes' and 'no'."
  }

  description = <<EOF
    Manages ACI Subnets with the following flags :
      - *ctrl* is an optional flag which control subnet state with allowed values such as 'unspecified', 'querier', 'nd' and 'no-default-gateway'.
      - *scope* indicate the subnet visibility with multiple values,
      - *preferred* indicate if the subnet is prefered over every available alternatives
EOF
}

variable "filter" {
  type = map(object({
    tenant_dn     = string
    description   = optional(string)
    annotation    = optional(string)
    name_alias    = optional(string)
    apply_to_frag = optional(string)
    arp_opc       = optional(string)
    d_from_port   = optional(string)
    d_to_port     = optional(string)
    ether_t       = optional(string)
    icmpv4_t      = optional(string)
    icmpv6_t      = optional(string)
    match_dscp    = optional(string)
    name_alias    = optional(string)
    prot          = optional(string)
    s_from_port   = optional(string)
    s_to_port     = optional(string)
    stateful      = optional(string)
    tcp_rules     = optional(list(string))
  }))

  validation {
    condition     = contains(["yes", "no"], var.filter.apply_to_frag)
    error_message = "Allowed values are 'yes' and 'no'."
  }

  validation {
    condition     = contains(["unspecified", "req", "reply"], var.filter.arp_opc)
    error_message = "Allowed values are 'unspecified', 'req' and 'reply'."
  }

  validation {
    condition     = contains(["unspecified", "ftpData", "smtp", "dns", "http", "pop3", "https", "rtsp"], var.filter.d_from_port)
    error_message = "Allowed values are 'unspecified', 'ftpData', 'smtp', 'dns', 'http', 'pop3', 'https' and 'rtsp'."
  }

  validation {
    condition     = contains(["unspecified", "ftpData", "smtp", "dns", "http", "pop3", "https", "rtsp"], var.filter.d_to_port)
    error_message = "Allowed values are 'unspecified', 'ftpData', 'smtp', 'dns', 'http', 'pop3', 'https' and 'rtsp'."
  }

  validation {
    condition     = contains(["echo-rep", "dst-unreach", "src-quench", "echo", "time-exceeded", "unspecified"], var.filter.icmpv4_t)
    error_message = "Allowed values are 'echo-rep', 'dst-unreach', 'src-quench', 'echo', 'time-exceeded' and 'unspecified'."
  }

  validation {
    condition     = contains(["echo-rep", "dst-unreach", "src-quench", "echo", "time-exceeded", "unspecified"], var.filter.icmpv6_t)
    error_message = "Allowed values are 'echo-rep', 'dst-unreach', 'src-quench', 'echo', 'time-exceeded' and 'unspecified'."
  }

  validation {
    condition     = contains(["unspecified", "ipv4", "trill", "arp", "ipv6", "mpls_ucast", "mac_security", "fcoe", "ip"], var.filter.ether_t)
    error_message = "Allowed values are 'unspecified', 'ipv4', 'trill', 'arp', 'ipv6', 'mpls_ucast', 'mac_security', 'fcoe' and 'ip'."
  }

  validation {
    condition     = contains(["CS0", "CS1", "AF11", "AF12", "AF13", "CS2", "AF21", "AF22", "AF23", "CS3", "AF31", "AF32", "AF33", "CS4", "AF41", "AF42", "AF43", "CS5", "VA", "EF", "CS6", "CS7", "unspecified"], var.filter.match_dscp)
    error_message = "Allowed values are 'CS0', 'CS1', 'AF11', 'AF12', 'AF13', 'CS2', 'AF21', 'AF22', 'AF23', 'CS3', 'AF31', 'AF32', 'AF33', 'CS4', 'AF41', 'AF42', 'AF43', 'CS5', 'VA', 'EF', 'CS6', 'CS7', 'unspecified'."
  }

  validation {
    condition     = contains(["unspecified", "ftpData", "smtp", "dns", "http", "pop3", "https", "rtsp"], var.filter.s_from_port)
    error_message = "Allowed values are 'unspecified', 'ftpData', 'smtp', 'dns', 'http','pop3', 'https', 'rtsp'."
  }

  validation {
    condition     = contains(["unspecified", "ftpData", "smtp", "dns", "http", "pop3", "https", "rtsp"], var.filter.s_to_port)
    error_message = "Allowed values are 'unspecified', 'ftpData', 'smtp', 'dns', 'http','pop3', 'https', 'rtsp'."
  }

  validation {
    condition     = contains(["yes", "no"], var.filter.stateful)
    error_message = "Allowed values are 'yes', 'no'."
  }

  validation {
    condition     = contains(["ack", "est", "fin", "rst", "syn", "unspecified"], var.filter.tcp_rules)
    error_message = "Allowed values are 'ack', 'est', 'fin', 'rst', 'syn' and 'unspecified'."
  }
}

variable "contract" {
  type = map(object({
    tenant_dn     = string
    description   = optional(string)
    annotation    = optional(string)
    name_alias    = optional(string)
    prio          = optional(string)
    scope         = optional(string)
    target_dscp   = optional(string)
    cons_match_t  = optional(string)
    prov_match_t  = optional(string)
    rev_flt_ports = optional(string)
    target_dscp   = optional(string)
  }))

  validation {
    condition     = contains(["unspecified", "level1", "level2", "level3", "level4", "level5", "level6"], var.contract.prio)
    error_message = "Allowed values are 'unspecified', 'level1', 'level2', 'level3', 'level4', 'level5' and 'level6'."
  }

  validation {
    condition     = contains(["global", "tenant", "application-profile", "context"], var.contract.scope)
    error_message = "Allowed values are 'global', 'tenant', 'application-profile' and 'context'."
  }

  validation {
    condition     = contains(["CS0", "CS1", "AF11", "AF12", "AF13", "CS2", "AF21", "AF22", "AF23", "CS3", "AF31", "AF32", "AF33", "CS4", "AF41", "AF42", "AF43", "CS5", "VA", "EF", "CS6", "CS7", "unspecified"], var.contract.target_dscp)
    error_message = "Allowed values are 'CS0', 'CS1', 'AF11', 'AF12', 'AF13', 'CS2', 'AF21', 'AF22', 'AF23', 'CS3', 'AF31', 'AF32', 'AF33', 'CS4', 'AF41', 'AF42', 'AF43', 'CS5', 'VA', 'EF', 'CS6', 'CS7', 'unspecified'."
  }

  validation {
    condition     = contains(["All", "None", "AtmostOne", "AtleastOne"], var.contract.cons_match_t)
    error_message = "Allowed values are 'All', 'None', 'AtmostOne' and 'AtleastOne'."
  }

  validation {
    condition     = contains(["All", "None", "AtmostOne", "AtleastOne"], var.contract.prov_match_t)
    error_message = "Allowed values are 'All', 'None', 'AtmostOne' and 'AtleastOne'."
  }

  validation {
    condition     = contains(["yes", "no"], var.contract.rev_flt_ports)
    error_message = "Allowed values are 'yes', 'no'."
  }

  description = <<EOF
    Manages ACI Contract with priority level, scope that allows communication with epgs with the same application profile and the target differentiated service code point.
EOF
}

variable "application_profile" {
  type = map(object({
    tenant_dn             = string
    annotation            = optional(string)
    description           = optional(string)
    name_alias            = optional(string)
    prio                  = optional(string)
    tdn                   = string
    annotation            = optional(string)
    binding_type          = optional(string)
    allow_micro_seg       = optional(string)
    custom_epg_name       = optional(string)
    enhanced_lag_policy   = optional(string)
    delimiter             = optional(string)
    encap                 = optional(string)
    encap_mode            = optional(string)
    epg_cos               = optional(string)
    epg_cos_pref          = optional(string)
    instr_imedcy          = optional(string)
    netflow_dir           = optional(string)
    netflow_pref          = optional(string)
    num_ports             = optional(string)
    port_allocation       = optional(string)
    primary_encap         = optional(string)
    primary_encap_inner   = optional(string)
    res_imedcy            = optional(string)
    secondary_encap_inner = optional(string)
    switching_mode        = optional(string)
    vmm_allow_promiscuous = optional(string)
    vmm_forged_transmits  = optional(string)
    vmm_mac_changes       = optional(string)
    match_t               = optional(string)
    contract_type         = string
    contract              = string
  }))

  validation {
    condition     = contains(["unspecified", "level1", "level2", "level3", "level4", "level5", "level6"], var.application_profile.prio)
    error_message = "Allowed values are 'unspecified', 'level1', 'level2', 'level3', 'level4', 'level5' and 'level6'."
  }

  validation {
    condition     = contains(["none", "staticBinding", "dynamicBinding", "ephemeral"], var.application_profile.binding_type)
    error_message = "Allowed values are 'none', 'staticBinding', 'dynamicBinding' and 'ephemeral'."
  }

  validation {
    condition     = contains(["true", "false"], var.application_profile.allow_micro_seg)
    error_message = "Allowed values are 'true', 'false'."
  }

  validation {
    condition     = contains(["auto", "vlan", "vxlan"], var.application_profile.encap_mode)
    error_message = "Allowed values are 'auto', 'vlan', 'vxlan'."
  }

  validation {
    condition     = contains(["Cos0", "Cos1", "Cos2", "Cos3", "Cos4", "Cos5", "Cos6", "Cos7"], var.application_profile.epg_cos)
    error_message = "Allowed values are 'Cos0', 'Cos1', 'Cos2', 'Cos3', 'Cos4', 'Cos5', 'Cos6' and 'Cos7'."
  }

  validation {
    condition     = contains(["disabled", "enabled"], var.application_profile.epg_cos_pref)
    error_message = "Allowed values are 'disabled', 'enabled."
  }

  validation {
    condition     = contains(["immediate", "lazy"], var.application_profile.instr_imedcy)
    error_message = "Allowed values are 'immediate', 'lazy'."
  }

  validation {
    condition     = contains(["ingress", "egress", "both"], var.application_profile.netflow_dir)
    error_message = "Allowed values are 'ingress', 'egress', 'both'."
  }

  validation {
    condition     = contains(["enabled", "disabled"], var.application_profile.netflow_pref)
    error_message = "Allowed values are 'enabled', 'disabled'."
  }

  validation {
    condition     = contains(["none", "elastic", "fixed"], var.application_profile.port_allocation)
    error_message = "Allowed values are 'none', 'elastic' and 'fixed'."
  }

  validation {
    condition     = contains(["lazy", "preprovisioned"], var.application_profile.res_imedcy)
    error_message = "Allowed values are 'lazy', 'preprovisioned'."
  }

  validation {
    condition     = contains(["native", "AVE"], var.application_profile.switching_mode)
    error_message = "Allowed values are 'native', 'AVE'."
  }

  validation {
    condition     = contains(["All", "AtleastOne", "AtmostOne"], var.application_profile.match_t)
    error_message = "Allowed values are 'All', 'AtleastOne' and 'AtmostOne'."
  }

  validation {
    condition     = contains(["consumer", "provider"], var.application_profile.contract_type)
    error_message = "Allowed values are 'consumer', 'provider'."
  }
}