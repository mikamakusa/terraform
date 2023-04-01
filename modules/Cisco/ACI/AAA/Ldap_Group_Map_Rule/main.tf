resource "aci_ldap_group_map_rule" "ldap_group_map_rule" {
  count       = length(var.ldap_group_map_rule)
  name        = lookup(var.ldap_group_map_rule[count.index], "name")
  type        = lookup(var.ldap_group_map_rule[count.index], "type")
  annotation  = lookup(var.ldap_group_map_rule[count.index], "annotation", null)
  description = lookup(var.ldap_group_map_rule[count.index], "annotation", null)
  groupdn     = lookup(var.ldap_group_map_rule[count.index], "annotation", null)
  name_alias  = lookup(var.ldap_group_map_rule[count.index], "annotation", null)
}