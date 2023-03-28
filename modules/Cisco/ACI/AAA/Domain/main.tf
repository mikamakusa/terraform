resource "aci_aaa_domain" "domain" {
  for_each    = var.domain
  name        = each.key
  description = each.value.description
  annotation  = each.value.annotation
  name_alias  = each.value.name_alias
}