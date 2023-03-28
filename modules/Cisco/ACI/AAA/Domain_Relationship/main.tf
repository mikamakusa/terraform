resource "aci_aaa_domain_relationship" "domain_relationship" {
  for_each      = var.domain_relationship
  aaa_domain_dn = each.value.aaa_domain_dn
  parent_dn     = each.value.parent_dn
}