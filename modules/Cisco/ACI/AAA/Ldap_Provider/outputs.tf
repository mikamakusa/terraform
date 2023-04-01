output "aci_ldap_provider_id" {
  value = aci_ldap_provider.ldap_provider.*.id
}