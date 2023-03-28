resource "aci_default_authentication" "default_authentication" {
  for_each       = var.default_authentication
  annotation     = each.value.annotation
  fallback_check = each.value.fallback_check
  realm          = each.value.realm
  realm_sub_type = each.value.realm_sub_type
  name_alias     = each.value.name_alias
  description    = each.value.description
  provider_group = each.value.provider_group
}