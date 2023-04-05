resource "aci_access_generic" "main" {
  count                               = length(var.access_generic)
  attachable_access_entity_profile_dn = element(aci_attachable_access_entity_profile.main.*.id, lookup(var.access_generic[count.index], "attachable_access_entity_profile_id"))
  name                                = lookup(var.access_generic[count.index], "name")
  annotation                          = lookup(var.access_generic[count.index], "annotation", null)
  description                         = lookup(var.access_generic[count.index], "description", null)
  name_alias                          = lookup(var.access_generic[count.index], "name_alias")
}

resource "aci_access_switch_policy_group" "main" {
  name = ""
  annotation = ""
  description = ""
  name_alias = ""
}

resource "aci_attachable_access_entity_profile" "main" {
  count       = length(var.attachable_access_entity_profile)
  name        = lookup(var.attachable_access_entity_profile[count.index], "name")
  annotation  = lookup(var.attachable_access_entity_profile[count.index], "annotation", null)
  name_alias  = lookup(var.attachable_access_entity_profile[count.index], "name_alias", null)
  description = lookup(var.attachable_access_entity_profile[count.index], "description", null)
}

resource "aci_cdp_interface_policy" "main" {
  name = ""
}

resource "aci_error_disable_recovery" "main" {}

resource "aci_fabric_if_pol" "main" {
  name = ""
}

resource "aci_l2_interface_policy" "main" {
  name = ""
}

resource "aci_l3_domain_profile" "main" {
  name = ""
}

resource "aci_lacp_policy" "main" {
  name = ""
}

resource "aci_leaf_access_bundle_policy_group" "main" {
  name = ""
}

resource "aci_leaf_access_port_policy_group" "main" {
  name = ""
}

resource "aci_leaf_breakout_port_group" "main" {
  name = ""
}

resource "aci_lldp_interface_policy" "main" {
  name = ""
}

resource "aci_mcp_instance_policy" "main" {
  key = ""
}

resource "aci_miscabling_protocol_interface_policy" "main" {
  name = ""
}

resource "aci_physical_domain" "main" {
  name = ""
}

resource "aci_ranges" "main" {
  from         = ""
  to           = ""
  vlan_pool_dn = ""
}

resource "aci_rest_managed" "main" {
  class_name = ""
  dn         = ""
}

resource "aci_spanning_tree_interface_policy" "main" {
  name = ""
}

resource "aci_spine_port_policy_group" "main" {
  name = ""
}

resource "aci_spine_switch_policy_group" "main" {
  name = ""
}

resource "aci_vlan_pool" "main" {
  alloc_mode = ""
  name       = ""
}

resource "aci_vmm_controller" "main" {
  host_or_ip     = ""
  name           = ""
  root_cont_name = ""
  vmm_domain_dn  = ""
}

resource "aci_vmm_credential" "main" {
  name          = ""
  vmm_domain_dn = ""
}

resource "aci_vmm_domain" "main" {
  name                = ""
  provider_profile_dn = ""
}

resource "aci_vpc_domain_policy" "main" {
  name = ""
}

resource "aci_vswitch_policy" "main" {
  vmm_domain_dn = ""
}