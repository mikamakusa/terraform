resource "aci_ldap_group_map" "ldap_group_map" {
  count       = length(var.ldap_group_map)
  name        = lookup(var.ldap_group_map[count.index], "name")
  type        = lookup(var.ldap_group_map[count.index], "type")
  annotation  = lookup(var.ldap_group_map[count.index], "annotation", null)
  description = lookup(var.ldap_group_map[count.index], "description", null)
  name_alias  = lookup(var.ldap_group_map[count.index], "name_alias", null)
}