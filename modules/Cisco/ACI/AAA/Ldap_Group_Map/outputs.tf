output "ldap_group_map_id" {
  value = aci_ldap_group_map.ldap_group_map.*.id
}