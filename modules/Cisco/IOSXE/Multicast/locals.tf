/*
locals {
  interface_pim = defaults(var.interface_pim, {
    passive           = false
    dense_mode        = false
    sparse_mode       = true
    sparse_dense_mode = false
    bfd               = false
    border            = false
    bsr_border        = false
  })
  msdp_passwords = defaults(var.msdp.passwords, {
    encryption = 0
  })
  msdp_peers = defaults(var.msdp.peers, {
    connect_source_loopback = 0
    remote_as               = 1
  })
  msdp_vrf_passwords = defaults(var.msdp_vrf.passwords, {
    encryption = 0
  })
  msdp_vrf_peers = defaults(var.msdp_vrf.peers, {
    connect_source_loopback = 0
    remote_as               = 1
  })
  pim = defaults(var.pim, {
    autorp                 = false
    autorp_listener        = false
    bsr_candidate_loopback = 100
    bsr_candidate_mask     = 30
    bsr_candidate_priority = 10
    ssm_default            = false
    rp_address_override    = false
    rp_address_bidir       = false
  })
  pim_rp_addresses = defaults(var.pim.rp_addresses, {
    override = false
    bidir    = false
  })
  pim_rp_candidates = defaults(var.pim.rp_candidates, {
    interval = 100
    priority = 10
    bidir    = false
  })
  pim_vrf = defaults(var.pim_vrf, {
    autorp                 = false
    autorp_listener        = false
    bsr_candidate_loopback = 100
    bsr_candidate_mask     = 30
    bsr_candidate_priority = 10
    ssm_default            = false
    rp_address_override    = false
    rp_address_bidir       = false
  })
  pim_vrf_rp_addresses = defaults(var.pim_vrf.rp_addresses, {
    override = false
    bidir    = false
  })
  pim_vrf_rp_candidates = defaults(var.pim_vrf.rp_candidates, {
    interval = 100
    priority = 10
    bidir    = false
  })
}*/
