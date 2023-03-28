resource "aci_console_authentication" "console_authentication" {
  for_each = var.console_authentication
  annotation     = each.value.annotation
  provider_group = each.value.provider_group
  realm          = each.value.realm
  realm_sub_type = each.value.realm_sub_type
  name_alias     = each.value.name_alias
  description    = each.value.description
}