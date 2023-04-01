output "aci_ldap_group_map_rule_id" {
  value = aci_ldap_group_map_rule.ldap_group_map_rule.*.id
}