resource "aci_any" "main" {
  vrf_dn       = data.aci_vrf.data_vrf.id
  description  = var.description
  annotation   = var.annotation
  match_t      = var.match_t
  name_alias   = var.name_alias
  pref_gr_memb = var.pref_gr_memb
}