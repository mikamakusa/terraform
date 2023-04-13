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
  for_each      = var.msdp
  originator_id = each.value.originator_id
  device        = each.value.device

  dynamic "peers" {
    for_each = each.value.peers
    content {
      addr                    = peers.value.addr
      remote_as               = peers.value.remote_as
      connect_source_loopback = peers.value.connect_source_loopback
    }
  }

  dynamic "passwords" {
    for_each = each.value.passwords
    content {
      addr       = passwords.value.addr
      encryption = passwords.value.encryption
      password   = sensitive(passwords.value.password)
    }
  }
}

resource "iosxe_msdp_vrf" "multicast" {
  for_each      = var.msdp_vrf
  vrf           = each.value.vrf
  originator_id = each.value.originator_id
  device        = each.value.device

  dynamic "peers" {
    for_each = each.value.peers
    content {
      addr                    = peers.value.addr
      remote_as               = peers.value.remote_as
      connect_source_loopback = peers.value.connect_source_loopback
    }
  }

  dynamic "passwords" {
    for_each = each.value.passwords
    content {
      addr       = passwords.value.addr
      encryption = passwords.value.encryption
      password   = sensitive(passwords.value.password)
    }
  }
}

resource "iosxe_pim" "multicast" {
  for_each                          = var.pim
  autorp                            = each.value.autorp
  autorp_listener                   = each.value.autorp_listener
  device                            = each.value.device
  bsr_candidate_loopback            = each.value.bsr_candidate_loopback
  bsr_candidate_mask                = each.value.bsr_candidate_mask
  bsr_candidate_priority            = each.value.bsr_candidate_priority
  bsr_candidate_accept_rp_candidate = each.value.bsr_candidate_accept_rp_candidate
  ssm_range                         = each.value.ssm_range
  ssm_default                       = each.value.ssm_default
  rp_address                        = each.value.rp_address
  rp_address_override               = each.value.rp_address_override
  rp_address_bidir                  = each.value.rp_address_bidir

  dynamic "rp_addresses" {
    for_each = each.value.rp_addresses
    iterator = addresses
    content {
      access_list = addresses.value.access_list
      rp_address  = addresses.value.rp_address
      override    = addresses.value.override
      bidir       = addresses.value.bidir
    }
  }

  dynamic "rp_candidates" {
    for_each = each.value.rp_candidates
    iterator = candidates
    content {
      interface  = candidates.value.interface
      group_list = candidates.value.group_list
      interval   = candidates.value.interval
      priority   = candidates.value.priority
      bidir      = candidates.value.bidir
    }
  }
}

resource "iosxe_pim_vrf" "multicast" {
  for_each                          = var.pim_vrf
  vrf                               = each.value.vrf
  autorp                            = each.value.autorp
  autorp_listener                   = each.value.autorp_listener
  device                            = each.value.device
  bsr_candidate_loopback            = each.value.bsr_candidate_loopback
  bsr_candidate_mask                = each.value.bsr_candidate_mask
  bsr_candidate_priority            = each.value.bsr_candidate_priority
  bsr_candidate_accept_rp_candidate = each.value.bsr_candidate_accept_rp_candidate
  ssm_range                         = each.value.ssm_range
  ssm_default                       = each.value.ssm_default
  rp_address                        = each.value.rp_address
  rp_address_override               = each.value.rp_address_override
  rp_address_bidir                  = each.value.rp_address_bidir

  dynamic "rp_addresses" {
    for_each = each.value.rp_addresses
    iterator = addresses
    content {
      access_list = addresses.value.access_list
      rp_address  = addresses.value.rp_address
      override    = addresses.value.override
      bidir       = addresses.value.bidir
    }
  }

  dynamic "rp_candidates" {
    for_each = each.value.rp_candidates
    iterator = candidates
    content {
      interface  = candidates.value.interface
      group_list = candidates.value.group_list
      interval   = candidates.value.interval
      priority   = candidates.value.priority
      bidir      = candidates.value.bidir
    }
  }
}