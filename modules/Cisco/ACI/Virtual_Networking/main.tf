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

resource "aci_vswitch_policy" "main" {
  for_each      = var.vswitch_policy
  vmm_domain_dn = aci_vmm_domain.main[join("-", [each.key, "domain"])].id
  annotation    = each.value.annotation
  description   = each.value.description
  name_alias    = each.value.name_alias

  dynamic "relation_vmm_rs_vswitch_exporter_pol" {
    for_each = var.relation_vmm_rs_vswitch_exporter_pol
    content {
      active_flow_time_out = relation_vmm_rs_vswitch_exporter_pol.value.active_flow_time_out
      idle_flow_time_out   = relation_vmm_rs_vswitch_exporter_pol.value.idle_flow_time_out
      sampling_rate        = relation_vmm_rs_vswitch_exporter_pol.value.sampling_rate
      target_dn            = join("-", ["uni/infra/vmmexporterpol", relation_vmm_rs_vswitch_exporter_pol.value.target_dn])
    }
  }
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

resource "aci_rest_managed" "domain_uplinks" {
  for_each   = var.vmm_domain
  class_name = "vmmUplinkPCont"
  dn         = join("-", ["uni/vmmp", aci_vmm_domain.main[join("-", [each.key, "domain"])].provider_profile_dn, "/dom", each.key, "/uplinkcont"])

  content = {
    numOfUplinks = length(var.uplink_names)
  }
}

resource "aci_rest_managed" "vmm_uplinks" {
  for_each   = var.vmm_domain
  class_name = "vmmUplinkP"
  dn         = join("-", ["uni/vmmp", aci_vmm_domain.main[join("-", [each.key, "domain"])].provider_profile_dn, "/dom", aci_vmm_controller.main[join("-", [each.key, "controller"])].dvs_version, "/uplinkcont/uplinkp", length(var.uplink_names)])

  content = {
    uplinkId   = length(var.uplink_names)
    uplinkName = var.uplink_names
  }
}