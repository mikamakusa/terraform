resource "aci_login_domain" "login_domain" {
  count          = length(var.login_domain)
  name           = lookup(var.login_domain[count.index], "name")
  annotation     = lookup(var.login_domain[count.index], "annotation", null)
  provider_group = lookup(var.login_domain[count.index], "provider_group", null)
  realm          = lookup(var.login_domain[count.index], "realm", null)
  realm_sub_type = lookup(var.login_domain[count.index], "ream_sub_type", null)
  name_alias     = lookup(var.login_domain[count.index], "name_alias", null)
  description    = lookup(var.login_domain[count.index], "description", null)
}