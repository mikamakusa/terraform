resource "iosxe_interface_pim" "multicast" {
  for_each          = var.interface_pim
  type              = each.value.type
  name              = each.key
  passive           = each.value.passive
  dense_mode        = each.value.dense_mode
  sparse_mode       = each.value.sparse_mode
  sparse_dense_mode = each.value.sparse_dense_mode
  bfd               = each.value.bfd
  border            = each.value.border
  bsr_border        = each.value.bsr_border
  dr_priority       = each.value.dr_priority
  device            = each.value.device
}

resource "iosxe_msdp" "multicast" {
  for_each      = toset(keys({ for key, value in var.msdp : key => value }))
  originator_id = var.msdp[each.value]["originator_id"]
  device        = var.msdp[each.value]["device"]
  peers         = var.msdp[each.value]["peers"]
  passwords     = var.msdp[each.value]["passwords"]
}

resource "iosxe_msdp_vrf" "multicast" {
  for_each      = toset(keys({ for key, value in var.msdp_vrf : key => value }))
  vrf           = var.msdp_vrf[each.value]["vrf"]
  originator_id = var.msdp_vrf[each.value]["originator_id"]
  device        = var.msdp_vrf[each.value]["device"]
  peers         = var.msdp_vrf[each.value]["peers"]
  passwords     = var.msdp_vrf[each.value]["passwords"]
}

resource "iosxe_pim" "multicast" {
  for_each                          = toset(keys({ for key, value in var.pim : key => value }))
  autorp                            = var.pim[each.value]["autorp"]
  autorp_listener                   = var.pim[each.value]["autorp_listener"]
  device                            = var.pim[each.value]["device"]
  bsr_candidate_loopback            = var.pim[each.value]["bsr_candidate_loopback"]
  bsr_candidate_mask                = var.pim[each.value]["bsr_candidate_mask"]
  bsr_candidate_priority            = var.pim[each.value]["bsr_candidate_priority"]
  bsr_candidate_accept_rp_candidate = var.pim[each.value]["bsr_candidate_accept_rp_candidate"]
  ssm_range                         = var.pim[each.value]["ssm_range"]
  ssm_default                       = var.pim[each.value]["ssm_default"]
  rp_address                        = var.pim[each.value]["rp_address"]
  rp_address_override               = var.pim[each.value]["rp_address_override"]
  rp_address_bidir                  = var.pim[each.value]["rp_address_bidir"]
  rp_addresses                      = var.pim[each.value]["rp_addresses"]
  rp_candidates                     = var.pim[each.value]["rp_candidates"]
}

resource "iosxe_pim_vrf" "multicast" {
  for_each                          = toset(keys({ for key, value in var.pim_vrf : key => value }))
  vrf                               = var.pim_vrf[each.value]["vrf"]
  autorp                            = var.pim_vrf[each.value]["autorp"]
  autorp_listener                   = var.pim_vrf[each.value]["autorp_listener"]
  device                            = var.pim_vrf[each.value]["device"]
  bsr_candidate_loopback            = var.pim_vrf[each.value]["bsr_candidate_loopback"]
  bsr_candidate_mask                = var.pim_vrf[each.value]["bsr_candidate_mask"]
  bsr_candidate_priority            = var.pim_vrf[each.value]["bsr_candidate_priority"]
  bsr_candidate_accept_rp_candidate = var.pim_vrf[each.value]["bsr_candidate_accept_rp_candidate"]
  ssm_range                         = var.pim_vrf[each.value]["ssm_range"]
  ssm_default                       = var.pim_vrf[each.value]["ssm_default"]
  rp_address                        = var.pim_vrf[each.value]["rp_address"]
  rp_address_override               = var.pim_vrf[each.value]["rp_address_override"]
  rp_address_bidir                  = var.pim_vrf[each.value]["rp_address_bidir"]
  rp_addresses                      = var.pim_vrf[each.value]["rp_addresses"]
  rp_candidates                     = var.pim_vrf[each.value]["rp_candidates"]
}