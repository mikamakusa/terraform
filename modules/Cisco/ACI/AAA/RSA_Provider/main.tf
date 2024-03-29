resource "aci_rsa_provider" "rsa_provider" {
  count                           = length(var.rsa_provider)
  name                            = lookup(var.rsa_provider[count.index], "name")
  annotation                      = lookup(var.rsa_provider[count.index], "annotation", null)
  name_alias                      = lookup(var.rsa_provider[count.index], "name_alias", null)
  description                     = lookup(var.rsa_provider[count.index], "description", null)
  auth_port                       = lookup(var.rsa_provider[count.index], "auth_port", "1812")
  auth_protocol                   = lookup(var.rsa_provider[count.index], "auth_protocol", "pap")
  key                             = lookup(var.rsa_provider[count.index], "key", null)
  monitor_server                  = lookup(var.rsa_provider[count.index], "monitor_server", "disabled")
  monitoring_user                 = lookup(var.rsa_provider[count.index], "monitor_user", "default")
  monitoring_password             = sensitive(lookup(var.rsa_provider[count.index], "monitoring_password", null))
  retries                         = lookup(var.rsa_provider[count.index], "retries", "1")
  timeout                         = lookup(var.rsa_provider[count.index], "timeout", "5")
  relation_aaa_rs_prov_to_epp     = lookup(var.rsa_provider[count.index], "relation_aaa_rs_prov_to_epp", null)
  relation_aaa_rs_sec_prov_to_epg = lookup(var.rsa_provider[count.index], "relation_aaa_rs_sec_prov_to_epg", null)
}