resource "aci_attachable_access_entity_profile" "main" {
  for_each    = var.access_generic
  name        = each.key
  annotation  = each.value.annotation
  name_alias  = each.value.name_alias
  description = each.value.description
}

resource "aci_access_generic" "main" {
  for_each                            = var.access_generic
  attachable_access_entity_profile_dn = aci_attachable_access_entity_profile.main[each.key].id
  name                                = each.key
  annotation                          = each.value.annotation
  name_alias                          = each.value.name_alias
  description                         = each.value.description
}

resource "aci_access_switch_policy_group" "main" {
  for_each    = var.access_generic
  name        = each.key
  annotation  = each.value.annotation
  description = each.value.description
  name_alias  = each.value.name_alias
}

resource "aci_cdp_interface_policy" "main" {
  for_each    = var.cdp_interface_policy
  name        = each.key
  admin_st    = each.value.admin_st
  annotation  = each.value.annotation
  description = each.value.description
  name_alias  = each.value.name_alias
}

resource "aci_error_disable_recovery" "main" {
  for_each            = var.error_disable_recovery
  annotation          = each.value.annotation
  err_dis_recov_intvl = each.value.err_dis_recov_intvl
  name_alias          = each.value.name_alias
  description         = each.value.description

  dynamic "edr_event" {
    for_each = each.value.edr_event
    content {
      event = edr_event.value.event
      name  = each.key
    }
  }
}

resource "aci_fabric_if_pol" "main" {
  for_each      = var.fabric_if_pol
  name          = each.key
  annotation    = each.value.annotation
  description   = each.value.description
  auto_neg      = each.value.auto_neg == null ? "on" : each.value.auto_neg
  fec_mode      = each.value.fec_mode == null ? "inherit" : each.value.fec_mode
  link_debounce = tostring(each.value.link_debounce == null ? 100 : each.value.link_debounce)
  name_alias    = each.value.name_alias
  speed         = each.value.speed == null ? "inherit" : each.value.speed
}

resource "aci_l2_interface_policy" "main" {
  for_each    = var.l2_interface_policy
  name        = each.key
  annotation  = each.value.annotation
  description = each.value.description
  name_alias  = each.value.name_alias
  qinq        = each.value.qinq == null ? "disabled" : each.value.qinq
  vepa        = each.value.vepa == null ? "disabled" : each.value.vepa
  vlan_scope  = each.value.vlan_scope == null ? "global" : each.value.vlan_scope
}

resource "aci_l3_domain_profile" "main" {
  for_each   = var.access_generic
  name       = each.key
  annotation = each.value.annotation
  name_alias = each.value.name_alias
}

resource "aci_lacp_policy" "main" {
  for_each    = var.lacp_policy
  name        = each.key
  description = each.value.description
  annotation  = each.value.annotation
  ctrl        = each.value.ctrl == [""] ? ["fast-sel-hot-stdby", "graceful-conv", "susp-individual"] : each.value.ctrl
  max_links   = tostring(each.value.max_links == null ? 16 : each.value.max_links)
  min_links   = tostring(each.value.min_links == null ? 1 : each.value.min_links)
  mode        = each.value.mode == null ? "off" : each.value.mode
  name_alias  = each.value.name_alias
}

resource "aci_leaf_access_bundle_policy_group" "main" {
  for_each    = var.leaf_access_bundle_policy_group
  name        = each.key
  annotation  = each.value.annotation
  description = each.value.description
  name_alias  = each.value.name_alias
  lag_t       = each.value.lag_t == null ? "link" : each.value.lag_t
}

resource "aci_leaf_access_port_policy_group" "main" {
  for_each    = var.access_generic
  name        = each.key
  annotation  = each.value.annotation
  description = each.value.description
  name_alias  = each.value.name_alias
}

resource "aci_leaf_breakout_port_group" "main" {
  for_each    = var.leaf_breakout_port_group
  name        = each.key
  annotation  = each.value.annotation
  brkout_map  = each.value.brkout_map == null ? "none" : each.value.brkout_map
  name_alias  = each.value.name_alias
  description = each.value.description
}

resource "aci_lldp_interface_policy" "main" {
  for_each    = var.lldp_interface_policy
  name        = each.key
  description = each.value.description
  annotation  = each.value.annotation
  name_alias  = each.value.name_alias
  admin_rx_st = each.value.admin_rx_st == null ? "enabled" : each.value.admin_rx_st
  admin_tx_st = each.value.admin_tx_st == null ? "enabled" : each.value.admin_tx_st
}

resource "aci_mcp_instance_policy" "main" {
  for_each         = var.mcp_instance_policy
  key              = each.key
  annotation       = each.value.annotation
  admin_st         = each.value.admin_st == null ? "disable" : each.value.admin_st
  description      = each.value.description
  name_alias       = each.value.name_alias
  ctrl             = each.value.ctrl == [""] ? [""] : each.value.ctrl
  init_delay_time  = tostring(each.value.init_delay_time == null ? 0 : each.value.init_delay_time)
  loop_detect_mult = tostring(each.value.loop_detect_mult == null ? 1 : each.value.loop_detect_mult)
  loop_protect_act = each.value.loop_detect_act == null ? "port-disable" : each.value.loop_detect_act
  tx_freq          = tostring(each.value.tx_freq == null ? 0 : each.value.tx_freq)
  tx_freq_msec     = tostring(each.value.tx_freq_msec == null ? 100 : each.value.tx_freq_msec)
}

resource "aci_miscabling_protocol_interface_policy" "main" {
  for_each    = var.cdp_interface_policy
  name        = each.key
  admin_st    = each.value.admin_st == null ? "enabled" : each.value.admin_st
  description = each.value.description
  annotation  = each.value.annotation
  name_alias  = each.value.name_alias
}

resource "aci_physical_domain" "main" {
  for_each   = var.access_generic
  name       = each.key
  annotation = each.value.annotation
  name_alias = each.value.name_alias
}

resource "aci_port_security_policy" "main" {
  for_each    = var.port_security_policy
  name        = each.key
  annotation  = each.value.annotation
  description = each.value.description
  name_alias  = each.value.name_alias
  maximum     = tostring(each.value.maximum == null ? 0 : each.value.maximum)
  timeout     = tostring(each.value.timeout == null ? 60 : each.value.timeout)
  violation   = "protect"
}

resource "aci_qos_instance_policy" "main" {
  for_each              = var.qos_instance_policy
  name_alias            = each.key
  description           = each.value.description
  etrap_age_timer       = tostring(each.value.etrap_age_timer == null ? 0 : each.value.etrap_age_timer)
  etrap_bw_thresh       = tostring(each.value.etrap_bw_thresh == null ? 0 : each.value.etrap_bw_thresh)
  etrap_byte_ct         = tostring(each.value.etrap_byte_ct == null ? 0 : each.value.etrap_byte_ct)
  etrap_st              = each.value.etrap_st == null ? "no" : each.value.etrap_st
  fabric_flush_interval = tostring(each.value.fabric_flush_interval == null ? 100 : each.value.fabric_flush_interval)
  fabric_flush_st       = each.value.fabric_flush_st == null ? "no" : each.value.fabric_flush_st
  annotation            = each.value.annotation
  ctrl                  = each.value.ctrl == null ? "none" : each.value.ctrl
  uburst_spine_queues   = tostring(each.value.uburst_spine_queues == null ? 0 : each.value.uburst_spine_queues)
  uburst_tor_queues     = tostring(each.value.uburst_tor_queues == null ? 0 : each.value.uburst_tor_queues)
}

resource "aci_vlan_pool" "main" {
  for_each    = var.vlan_pool
  alloc_mode  = each.value.alloc_mode
  name        = each.key
  description = each.value.description
  annotation  = each.value.annotation
  name_alias  = each.value.name_alias
}

resource "aci_ranges" "main" {
  for_each     = var.vlan_pool
  from         = each.value.from
  to           = each.value.to
  vlan_pool_dn = aci_vlan_pool.main[each.key].id
  alloc_mode   = each.value.alloc_mode == null ? "inherit" : each.value.alloc_mode
  annotation   = each.value.annotation
  name_alias   = each.value.name_alias
  role         = each.value.role == null ? "external" : each.value.role
  description  = each.value.description
}

resource "aci_spanning_tree_interface_policy" "main" {
  for_each    = var.spanning_tree_interface_policy
  name        = each.key
  annotation  = each.value.annotation
  description = each.value.description
  name_alias  = each.value.name_alias
  ctrl        = each.value.ctrl == [""] ? ["unspecified"] : each.value.ctrl
}

resource "aci_spine_port_policy_group" "main" {
  for_each    = var.access_generic
  name        = each.key
  description = each.value.description
  annotation  = each.value.annotation
  name_alias  = each.value.name_alias
}

resource "aci_spine_switch_policy_group" "main" {
  for_each    = var.access_generic
  name        = each.key
  description = each.value.description
  annotation  = each.value.annotation
  name_alias  = each.value.name_alias
}

resource "aci_vmm_domain" "main" {
  for_each            = var.vmm_domain
  name                = join("-", [each.key, "domain"])
  provider_profile_dn = join("/", ["uni", join("-", ["vmmp", each.value.provider_profile_dn])])
  access_mode         = each.value.access_mode == null ? "read-write" : each.value.access_mode
  annotation          = each.value.annotation
  arp_learning        = each.value.arp_learning == null ? "disabled" : each.value.arp_learning
  enable_ave          = each.value.enable_ave
  ave_time_out        = tostring(each.value.ave_time_out == null ? 30 : each.value.ave_time_out)
  config_infra_pg     = each.value.config_infra_pg == null ? "no" : each.value.config_infra_pg
  ctrl_knob           = each.value.ctrl_knob == null ? "epDpVerify" : each.value.ctrl_knob
  delimiter           = each.value.delimiter
  enable_tag          = each.value.enable_tag == null ? "no" : each.value.enable_tag
  enable_vm_folder    = each.value.enable_vm_folder == null ? "no" : each.value.enable_vm_folder
  encap_mode          = each.value.encap_mode == null ? "unknown" : each.value.encap_mode
  enf_pref            = each.value.enf_pref == null ? "hw" : each.value.enf_pref
  ep_inventory_type   = each.value.ep_inventory_type == null ? "on-link" : each.value.ep_inventory_type
  ep_ret_time         = tostring(each.value.ep_ret_time == null ? 0 : each.value.ep_ret_time)
  hv_avail_monitor    = each.value.hv_avail_monitor == null ? "no" : each.value.hv_avail_monitor
  mcast_addr          = each.value.mcast_addr
  mode                = each.value.mode == null ? "unspecified" : each.value.mode
  name_alias          = each.value.name_alias
  pref_encap_mode     = each.value.pref_encap_mode == null ? "unspecified" : each.value.pref_encap_mode
}

resource "aci_vmm_controller" "main" {
  for_each            = var.vmm_controller
  host_or_ip          = each.value.host_or_ip
  name                = join("-", [each.key, "controller"])
  root_cont_name      = each.value.root_cont_name
  vmm_domain_dn       = aci_vmm_domain.main[join("-", [each.key, "domain"])].id
  annotation          = each.value.annotation
  dvs_version         = each.value.dvs_version == null ? "unmanaged" : each.value.dvs_version
  inventory_trig_st   = each.value.inventory_trig_st == null ? "untriggered" : each.value.inventory_trig_st
  mode                = each.value.mode == null ? "default" : each.value.mode
  msft_config_err_msg = each.value.msft_config_err_msg
  msft_config_issues  = each.value.msft_config_issues == null ? "not-applicable" : each.value.msft_config_issues
  n1kv_stats_mode     = each.value.n1kv_stats_mode == null ? "enabled" : each.value.n1kv_stats_mode
  port                = tostring(each.value.port == null ? 0 : each.value.port)
  scope               = each.value.scope == null ? "vm" : each.value.scope
  stats_mode          = each.value.stats_mode == null ? "disabled" : each.value.stats_mode
  seq_num             = tostring(each.value.seq_num == null ? 0 : each.value.seq_num)
  vxlan_depl_pref     = each.value.vxlan_depl_pref == null ? "vxlan" : each.value.vxlan_depl_pref
}

resource "aci_vmm_credential" "main" {
  for_each      = var.vmm_credential
  name          = join("-", [each.key, "credential"])
  vmm_domain_dn = aci_vmm_domain.main[join("-", [each.key, "domain"])].id
  annotation    = each.value.annotation
  description   = each.value.description
  name_alias    = each.value.name_alias
  pwd           = sensitive(each.value.pwd)
  usr           = sensitive(each.value.usr)
}

resource "aci_vpc_domain_policy" "main" {
  for_each    = var.vpc_domain_policy
  name        = each.key
  annotation  = each.value.annotation
  dead_intvl  = tostring(each.value.dead_intvl == null ? 200 : each.value.dead_intvl)
  name_alias  = each.value.name_alias
  description = each.value.description
}

resource "aci_vswitch_policy" "main" {
  for_each      = var.vswitch_policy
  vmm_domain_dn = aci_vmm_domain.main[join("-", [each.key, "domain"])].id
  annotation    = each.value.annotation
  description   = each.value.description
  name_alias    = each.value.name_alias
}