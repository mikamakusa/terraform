resource "aci_login_domain_provider" "login_domain_provider" {
  count       = length(var.login_domain_provider)
  name        = lookup(var.login_domain_provider[count.index], "name")
  parent_dn   = lookup(var.login_domain_provider[count.index], "parent_dn")
  annotation  = lookup(var.login_domain_provider[count.index], "annotation", null)
  name_alias  = lookup(var.login_domain_provider[count.index], "name_alias", null)
  description = lookup(var.login_domain_provider[count.index], "description", null)
  order       = lookup(var.login_domain_provider[count.index], "order", 0)
}