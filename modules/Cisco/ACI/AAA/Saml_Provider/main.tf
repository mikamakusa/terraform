resource "aci_saml_provider" "saml_provider" {
  for_each                        = var.saml_provider
  name                            = each.key
  name_alias                      = each.value.name_alias
  description                     = each.value.description
  annotation                      = each.value.annotation
  entity_id                       = each.value.entity_id
  gui_banner_message              = each.value.gui_banner_message
  https_proxy                     = each.value.https_proxy
  id_p                            = each.value.id_p == null ? "adfs" : each.value.id_p
  key                             = each.value.key
  metadata_url                    = each.value.metadata_url
  monitor_server                  = each.value.monitor_server == null ? "disabled" : each.value.monitor_server
  monitoring_user                 = each.value.monitoring_user == null ? "default" : each.value.monitoring_user
  monitoring_password             = sensitive(each.value.monitoring_password)
  retries                         = each.value.retries == null ? "1" : each.value.retries
  sig_alg                         = each.value.sig_alg == null ? "SIG_RSA_SHA256" : each.value.sig_alg
  timeout                         = each.value.timeout == null ? "5" : each.value.timeout
  tp                              = each.value.tp
  want_assertions_encrypted       = each.value.want_assertions_encrypted == null ? "yes" : each.value.want_assertions_encrypted
  want_assertions_signed          = each.value.want_assertions_signed == null ? "yes" : each.value.want_assertions_signed
  want_requests_signed            = each.value.want_requests_signed == null ? "yes" : each.value.want_requests_signed
  want_response_signed            = each.value.want_response_signed == null ? "yes" : each.value.want_response_signed
  relation_aaa_rs_prov_to_epp     = each.value.relation_aaa_rs_prov_to_epp
  relation_aaa_rs_sec_prov_to_epg = each.value.relation_aaa_rs_sec_prov_to_epg
}