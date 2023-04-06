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
  ctrl        = each.value.ctrl == [] ? ["fast-sel-hot-stdby", "graceful-conv", "susp-individual"] : each.value.ctrl
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
  name        = ""
  description = ""
  annotation  = ""
  name_alias  = ""
  admin_rx_st = ""
  admin_tx_st = ""
}

resource "aci_mcp_instance_policy" "main" {
  key              = ""
  annotation       = ""
  admin_st         = ""
  description      = ""
  name_alias       = ""
  ctrl             = []
  init_delay_time  = ""
  loop_detect_mult = ""
  loop_protect_act = ""
  tx_freq          = ""
  tx_freq_msec     = ""
}

resource "aci_miscabling_protocol_interface_policy" "main" {
  name        = ""
  admin_st    = ""
  description = ""
  annotation  = ""
  name_alias  = ""
}

resource "aci_physical_domain" "main" {
  for_each   = var.access_generic
  name       = each.key
  annotation = each.value.annotation
  name_alias = each.value.name_alias
}

resource "aci_ranges" "main" {
  from         = ""
  to           = ""
  vlan_pool_dn = ""
  alloc_mode   = ""
  annotation   = ""
  name_alias   = ""
  role         = ""
  description  = ""
}

resource "aci_rest_managed" "main" {
  class_name = ""
  dn         = ""
}

resource "aci_spanning_tree_interface_policy" "main" {
  name        = ""
  annotation  = ""
  description = ""
  name_alias  = ""
  ctrl        = []
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

resource "aci_vlan_pool" "main" {
  alloc_mode  = ""
  name        = ""
  description = ""
  annotation  = ""
  name_alias  = ""
}

resource "aci_vmm_controller" "main" {
  host_or_ip          = ""
  name                = ""
  root_cont_name      = ""
  vmm_domain_dn       = ""
  annotation          = ""
  dvs_version         = ""
  inventory_trig_st   = ""
  mode                = ""
  msft_config_err_msg = ""
  msft_config_issues  = []
  n1kv_stats_mode     = ""
  port                = ""
  scope               = ""
  stats_mode          = ""
  seq_num             = ""
  vxlan_depl_pref     = ""
}

resource "aci_vmm_credential" "main" {
  name          = ""
  vmm_domain_dn = ""
  annotation    = ""
  description   = ""
  name_alias    = ""
  pwd           = ""
  usr           = ""
}

resource "aci_vmm_domain" "main" {
  name                = ""
  provider_profile_dn = ""
  access_mode         = ""
  annotation          = ""
  arp_learning        = ""
  enable_ave          = ""
  ave_time_out        = ""
  config_infra_pg     = ""
  ctrl_knob           = ""
  delimiter           = ""
  enable_tag          = ""
  enable_vm_folder    = ""
  encap_mode          = ""
  enf_pref            = ""
  ep_inventory_type   = ""
  ep_ret_time         = ""
  hv_avail_monitor    = ""
  mcast_addr          = ""
  mode                = ""
  name_alias          = ""
  pref_encap_mode     = ""
}

resource "aci_vpc_domain_policy" "main" {
  name        = ""
  annotation  = ""
  dead_intvl  = ""
  name_alias  = ""
  description = ""
}

resource "aci_vswitch_policy" "main" {
  vmm_domain_dn = ""
  annotation    = ""
  description   = ""
  name_alias    = ""
}