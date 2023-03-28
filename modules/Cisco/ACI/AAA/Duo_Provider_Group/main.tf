resource "aci_duo_provider_group" "duo_provider_group" {
  for_each             = var.duo_provider_group
  name                 = each.key
  annotation           = each.value.annotation
  auth_choice          = each.value.auth_choice
  provider_type        = each.value.provider_type
  ldap_group_map_ref   = each.value.ldap_group_map_ref
  sec_fac_auth_methods = each.value.sec_fac_auth_methods
  name_alias           = each.value.name_alias
  description          = each.value.description
}