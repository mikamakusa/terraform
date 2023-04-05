resource "aci_tenant" "tenant" {
  for_each    = var.tenant
  name        = each.key
  annotation  = each.value.annotation
  name_alias  = each.value.name_alias
  description = each.value.description
}

resource "aci_vrf" "vrf" {
  for_each               = var.vrf
  name                   = join("_", [each.key, "vrf"])
  tenant_dn              = aci_tenant.tenant[each.value.tenant_dn].id
  annotation             = each.value.annotation
  description            = each.value.description
  bd_enforced_enable     = each.value.bd_enforced_enable == null ? "no" : each.value.bd_enforced_enable
  ip_data_plane_learning = each.value.ip_data_plane_learning == null ? "enabled" : each.value.ip_data_plane_learning
  knw_mcast_act          = each.value.knw_mcast_act == null ? "permit" : each.value.knw_mcast_act
  name_alias             = each.value.name_alias
  pc_enf_dir             = each.value.pc_enf_dir == null ? "ingress" : each.value.pc_enf_dir
  pc_enf_pref            = each.value.pc_enf_pref == null ? "enforced" : each.value.pc_enf_pref
}

resource "aci_bridge_domain" "bridge_domain" {
  for_each                    = var.bridge_domain
  name                        = join("_",[each.key, "bd"])
  tenant_dn                   = aci_tenant.tenant[each.value.tenant_dn].id
  optimize_wan_bandwidth      = each.value.optimize_wan_bandwidth == null ? "no" : each.value.optimize_wan_bandwidth
  annotation                  = each.value.annotation
  description                 = each.value.description
  arp_flood                   = each.value.arp_flood == null ? "no" : each.value.arp_flood
  ep_clear                    = each.value.ep_clear == null ? "no" : each.value.ep_clear
  ep_move_detect_mode         = each.value.ep_move_detect_mode == null ? "disable" : each.value.ep_move_detect_mode
  host_based_routing          = each.value.host_based_routing == null ? "no" : each.value.host_based_routing
  intersite_bum_traffic_allow = each.value.intersite_bum_traffic_allow == null ? "no" : each.value.intersite_bum_traffic_allow
  intersite_l2_stretch        = each.value.intersite_l2_stretch == null ? "no" : each.value.intersite_l2_stretch
  ip_learning                 = each.value.ip_learning == null ? "yes" : each.value.ip_learning
  ipv6_mcast_allow            = each.value.ipv6_mcast_allow == null ? "no" : each.value.ipv6_mcast_allow
  limit_ip_learn_to_subnets   = each.value.limit_ip_learn_to_subnets == null ? "no" : each.value.limit_ip_learn_to_subnets
  ll_addr                     = each.value.ll_addr == null ? "::" : each.value.ll_addr
  mac                         = each.value.mac == null ? "00:22:BD:F8:19:FF" : each.value.mac
  mcast_allow                 = each.value.mcast_allow == null ? "no" : each.value.mcast_allow
  multi_dst_pkt_act           = each.value.multi_dst_pkt_act == null ? "bd-flood" : each.value.multi_dst_pkt_act
  name_alias                  = each.value.name_alias
  bridge_domain_type          = each.value.bridge_domain_type == null ? "regular" : each.value.bridge_domain_type
  unicast_route               = each.value.unicast_route == null ? "yes" : each.value.unicast_route
  unk_mac_ucast_act           = each.value.unk_mac_ucast_act == null ? "proxy" : each.value.unk_mac_ucast_act
  unk_mcast_act               = each.value.unk_mcast_act == null ? "flood" : each.value.unk_mcast_act
  v6unk_mcast_act             = each.value.v6unk_mcast_act == null ? "flood" : each.value.v6unk_mcast_act
  vmac                        = "not-applicable"
  relation_fv_rs_ctx          = aci_vrf.vrf[join("_", [each.key, "vrf"].id
}

resource "aci_subnet" "subnet" {
  for_each    = var.subnet
  ip          = each.key
  parent_dn   = aci_bridge_domain.bridge_domain[each.value.parent_dn].id
  annotation  = each.value.annotation
  description = each.value.description
  ctrl        = each.value.ctrl == [] ? ["unspecified"] : each.value.ctrl
  name_alias  = each.value.name_alias
  preferred   = each.value.preferred == null ? "no" : each.value.preferred
  scope       = each.value.scope == [] ? ["private"] : each.value.scope
  virtual     = each.value.virtual == null ? "no" : each.value.virtual
}

resource "aci_filter" "filter" {
  for_each    = var.filter
  name        = each.key
  tenant_dn   = each.value.tenant_dn
  description = each.value.description
  annotation  = each.value.annotation
  name_alias  = each.value.name_alias
}

resource "aci_filter_entry" "filter_entry" {
  for_each      = var.filter
  filter_dn     = aci_filter.filter[each.key].id
  name          = each.key
  description   = each.value.description
  annotation    = each.value.annotation
  apply_to_frag = each.value.apply_to_frag == null ? "no" : each.value.apply_to_frag
  arp_opc       = each.value.arp_opc == null ? "unspecified" : each.value.arp_opc
  d_from_port   = each.value.d_from_port == null ? "unspecified" : each.value.d_from_port
  d_to_port     = each.value.d_to_port == null ? "unspecified" : each.value.d_to_port
  ether_t       = each.value.ether_t == null ? "unspecified" : each.value.ether_t
  icmpv4_t      = each.value.icmpv4_t == null ? "unspecified" : each.value.icmpv4_t
  icmpv6_t      = each.value.icmpv6_t == null ? "unspecified" : each.value.icmpv6_t
  match_dscp    = each.value.match_dscp == null ? "unspecified" : each.value.match_dscp
  name_alias    = each.value.name_alias
  prot          = each.value.prot == null ? "unspecified" : each.value.prot
  s_from_port   = each.value.s_from_port == null ? "unspecified" : each.value.s_from_port
  s_to_port     = each.value.s_to_port == null ? "unspecified" : each.value.s_to_port
  stateful      = each.value.stateful == null ? "no" : each.value.stateful
  tcp_rules     = each.value.tcp_rules == [] ? ["unspecified"] : each.value.tcp_rules
}

resource "aci_contract" "contract" {
  for_each    = var.contract
  name        = each.key
  tenant_dn   = each.value.tenant_dn
  description = each.value.description
  annotation  = each.value.annotation
  name_alias  = each.value.name_alias
  prio        = each.value.prio == null ? "unspecified" : var.contract.prio
  scope       = each.value.scope == null ? "context" : var.contract.scope
  target_dscp = each.value.target_dscp == null ? "CS0" : var.contract.target_dscp
}

resource "aci_contract_subject" "contract_subject" {
  for_each      = var.contract
  contract_dn   = aci_contract.contract[each.key].id
  name          = each.key
  annotation    = each.value.annotation
  description   = each.value.description
  cons_match_t  = each.value.cons_match_t == null ? "AtleastOne" : each.value.cons_match_t
  name_alias    = each.value.name_alias
  prio          = each.value.prio == null ? "unspecified" : each.value.prio
  prov_match_t  = each.value.prov_match_t == null ? "AtleastOne" : each.value.prov_match_t
  rev_flt_ports = each.value.rev_flt_ports == null ? "yes" : each.value.rev_flt_ports
  target_dscp   = each.value.target_dscp == null ? "unspecified" : each.value.target_dscp
}

resource "aci_application_profile" "application_profile" {
  for_each    = var.application_profile
  name        = each.key
  tenant_dn   = each.value.tenant_dn
  annotation  = each.value.annotation
  description = each.value.description
  name_alias  = each.value.name_alias
  prio        = each.value.prio
}

resource "aci_epg_to_domain" "epg_to_domain" {
  for_each              = var.application_profile
  application_epg_dn    = aci_application_profile.application_profile[each.key].id
  tdn                   = each.value.tdn
  annotation            = each.value.annotation
  binding_type          = each.value.binding_type == null ? "none" : each.value.binding_type
  allow_micro_seg       = each.value.allow_micro_seg == null ? "false" : each.value.allow_micro_seg
  custom_epg_name       = each.value.custom_epg_name
  enhanced_lag_policy   = each.value.enhanced_lag_policy
  delimiter             = each.value.delimiter
  encap                 = each.value.encap
  encap_mode            = each.value.encap_mode == null ? "auto" : each.value.encap_mode
  epg_cos               = each.value.epg_cos == null ? "Cos0" : each.value.epg_cos
  epg_cos_pref          = each.value.epg_cos_pref == null ? "disabled" : each.value.epg_cos_pref
  instr_imedcy          = each.value.instr_imedcy == null ? "lazy" : each.value.instr_imedcy
  netflow_dir           = each.value.netflow_dir == null ? "both" : each.value.netflow_dir
  netflow_pref          = each.value.netflow_pref == null ? "disabled" : each.value.netflow_pref
  num_ports             = each.value.num_ports == null ? "0" : each.value.num_ports
  port_allocation       = each.value.port_allocation == null ? "none" : each.value.port_allocation
  primary_encap         = each.value.primary_encap == null ? "unknown" : each.value.primary_encap
  primary_encap_inner   = each.value.primary_encap_inner == null ? "unknown" : each.value.primary_encap_inner
  res_imedcy            = each.value.res_imedcy == null ? "lazy" : each.value.res_imedcy
  secondary_encap_inner = each.value.secondary_encap_inner == null ? "unknown" : each.value.secondary_encap_inner
  switching_mode        = each.value.switching_mode == null ? "native" : each.value.switching_mode
  vmm_allow_promiscuous = each.value.vmm_allow_promiscuous
  vmm_forged_transmits  = each.value.vmm_forged_transmits
  vmm_mac_changes       = each.value.vmm_mac_changes
}

resource "aci_epg_to_contract" "epg_to_contract" {
  for_each           = var.application_profile
  application_epg_dn = aci_application_profile.application_profile[each.key].id
  contract_dn        = aci_contract.contract[each.value.contract].id
  contract_type      = each.value.contract_type
  annotation         = each.value.annotation
  description        = each.value.description
  match_t            = each.value.match_t
  prio               = each.value.prio
}