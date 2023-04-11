resource "aci_leaf_interface_profile" "main" {
  for_each    = var.configuration
  name        = join("-", [each.key, "leaf-interface"])
  description = each.value.description
  annotation  = var.annotations
  name_alias  = each.value.name_alias
}

resource "aci_access_port_selector" "main" {
  for_each                  = var.configuration
  access_port_selector_type = each.value.access_port_selector_type == null ? "ALL" : each.value.access_port_selector_type
  leaf_interface_profile_dn = aci_leaf_interface_profile.main[join("-", [each.key, "leaf-interface"])].id
  name                      = join("-", [each.key, "access-port-selector"])
  annotation                = var.annotations
  description               = each.value.description
  name_alias                = each.value.name_alias
}

resource "aci_access_port_block" "main" {
  for_each                = var.configuration
  access_port_selector_dn = aci_access_port_selector.main[join("-", [each.key, "access-port-selector"])].id
  name                    = join("-", [each.key, "access-port-block"])
  description             = each.value.description
  annotation              = var.annotations
  from_card               = each.value.from_card
  to_card                 = each.value.to_card
  from_port               = each.value.from_port
  to_port                 = each.value.to_port
}

resource "aci_access_sub_port_block" "main" {
  for_each                = var.configuration
  access_port_selector_dn = aci_access_port_selector.main[join("-", [each.key, "access-port-selector"])].id
  name                    = join("-", [each.key, "access-port-block"])
  description             = each.value.description
  annotation              = var.annotations
  from_card               = each.value.from_card
  to_card                 = each.value.to_card
  from_port               = each.value.from_port
  to_port                 = each.value.to_port
  from_sub_port           = each.value.from_sub_port
  to_sub_port             = each.value.to_sub_port
}

resource "aci_leaf_profile" "main" {
  for_each    = var.configuration
  name        = join("-", [each.key, "leaf-profile"])
  description = each.value.description
  annotation  = var.annotations
  name_alias  = each.value.name_alias

  dynamic "leaf_selector" {
    for_each = ""
    content {
      name                    = ""
      switch_association_type = ""

      dynamic "node_block" {
        for_each = ""
        content {
          name  = ""
          from_ = ""
          to_   = ""
        }
      }
    }
  }
}

resource "aci_leaf_selector" "main" {
  for_each                = var.configuration
  leaf_profile_dn         = aci_leaf_profile.main[join("-", [each.key, "leaf-profile"])].id
  name                    = join("-", [each.key, "leaf-selector"])
  switch_association_type = each.value.spine_switch_association_type
  annotation              = var.annotations
  description             = each.value.description
  name_alias              = each.value.name_alias
}

resource "aci_node_block" "main" {
  for_each              = var.configuration
  name                  = join("-", [each.key, "node-block"])
  switch_association_dn = aci_leaf_selector.main[join("-", [each.key, "leaf-selector"])].id
  annotation            = var.annotations
  description           = each.value.description
  name_alias            = each.value.name_alias
  from_                 = each.value.from_
  to_                   = each.value.to_
}

resource "aci_rest_managed" "main" {
  class_name = ""
  dn         = ""
}

resource "aci_spine_interface_profile" "main" {
  for_each    = var.configuration
  name        = join("-", [each.key, "spine-interface-profile"])
  description = each.value.description
  annotation  = var.annotations
  name_alias  = each.value.name_alias
}

resource "aci_spine_profile" "main" {
  for_each    = var.configuration
  name        = join("-", [each.key, "spine-profile"])
  description = each.value.description
  annotation  = var.annotations
  name_alias  = each.value.name_alias
}

resource "aci_spine_switch_association" "main" {
  for_each                      = var.configuration
  name                          = join("-", [each.key, "spine-switch-association"])
  spine_profile_dn              = aci_spine_profile.main[join("-", [each.key, "spine-profile"])].id
  spine_switch_association_type = each.value.spine_switch_association_type
  description                   = each.value.description
  annotation                    = var.annotations
}

resource "aci_static_node_mgmt_address" "main" {
  for_each          = var.configuration
  management_epg_dn = data.aci_node_mgmt_epg.main.id
  t_dn              = each.value.t_dn
  type              = each.value.node_mgmt_epg_type
  addr              = each.value.addr
  gw                = each.value.gw
  v6_addr           = each.value.v6_addr
  v6_gw             = each.value.v6_gw
}

resource "aci_vpc_explicit_protection_group" "main" {
  for_each                         = var.configuration
  name                             = join("-", [each.key, "vpc-explicit-protection-group"])
  switch1                          = each.value.switches[0]
  switch2                          = each.value.switches[1]
  vpc_domain_policy                = data.aci_vpc_domain_policy.main.id
  vpc_explicit_protection_group_id = join("-", [each.key, "spine-switch-association"])
  annotation                       = var.annotations
}