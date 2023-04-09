resource "iosxe_interface_pim" "multicast" {
  for_each          = local.interfaces == "interface_pim" ? 1 : 0
  type              = lookup(local.interfaces, "type")
  name              = lookup(local.interfaces, "name")
  passive           = lookup(local.interfaces, "passive", false)
  dense_mode        = lookup(local.interfaces, "dense_mode", false)
  sparse_mode       = lookup(local.interfaces, "sparse_mode", true)
  sparse_dense_mode = lookup(local.interfaces, "sparse_dense_mode", false)
  bfd               = lookup(local.interfaces, "bfp", false)
  border            = lookup(local.interfaces, "border", false)
  bsr_border        = lookup(local.interfaces, "bsr_border", false)
  dr_priority       = lookup(local.interfaces, "dr_priority", 0)
  device            = [for device in local.devices : lookup(local.interfaces, "device") if local.devices == lookup(local.interfaces, "device")]
}

resource "iosxe_msdp" "multicast" {
  for_each      = local.interfaces == "msdp" ? 1 : 0
  originator_id = lookup(local.interfaces, "originator_id", null)
  device        = [for device in local.devices : lookup(local.interfaces, "device") if local.devices == lookup(local.interfaces, "device")]

  dynamic "peers" {
    for_each = lookup(local.interfaces, "peers", null) == null ? [] : lookup(local.interfaces, "peers", null)
    content {
      addr                    = peers.value.addr
      remote_as               = peers.value.remote_as
      connect_source_loopback = peers.value.connect_source_loopback
    }
  }

  dynamic "passwords" {
    for_each = lookup(local.interfaces, "passwords", null) == null ? [] : lookup(local.interfaces, "passwords", null)
    content {
      addr       = passwords.value.addr
      encryption = passwords.value.encryption
      password   = sensitive(passwords.value.password)
    }
  }
}

resource "iosxe_msdp_vrf" "multicast" {
  for_each      = local.interfaces == "msdp_vrf" ? 1 : 0
  vrf           = lookup(local.interfaces, "vrf")
  originator_id = lookup(local.interfaces, "orginator_id", null)
  device        = [for device in local.devices : lookup(local.interfaces, "device") if local.devices == lookup(local.interfaces, "device")]

  dynamic "peers" {
    for_each = lookup(local.interfaces, "peers", null) == null ? [] : lookup(local.interfaces, "peers", null)
    content {
      addr                    = peers.value.addr
      remote_as               = peers.value.remote_as
      connect_source_loopback = peers.value.connect_source_loopback
    }
  }

  dynamic "passwords" {
    for_each = lookup(local.interfaces, "passwords", null) == null ? [] : lookup(local.interfaces, "passwords", null)
    content {
      addr       = passwords.value.addr
      encryption = passwords.value.encryption
      password   = sensitive(passwords.value.password)
    }
  }
}

resource "iosxe_pim" "multicast" {
  for_each                          = local.interfaces == "pim" ? 1 : 0
  autorp                            = lookup(local.interfaces, "autorp", false)
  autorp_listener                   = lookup(local.interfaces, "autorp_listener", false)
  device                            = [for device in local.devices : lookup(local.interfaces, "device") if local.devices == lookup(local.interfaces, "device")]
  bsr_candidate_loopback            = lookup(local.interfaces, "bsr_candidate_loopback", 100)
  bsr_candidate_mask                = lookup(local.interfaces, "bsr_candidate_mask", 30)
  bsr_candidate_priority            = lookup(local.interfaces, "bsr_candidate_priority", 0)
  bsr_candidate_accept_rp_candidate = lookup(local.interfaces, "bsr_candidate_accept_rp_candidate", null)
  ssm_range                         = lookup(local.interfaces, "ssm_range", null)
  ssm_default                       = lookup(local.interfaces, "ssm_default", false)
  rp_address                        = lookup(local.interfaces, "rp_address", null)
  rp_address_override               = lookup(local.interfaces, "rp_address_override", false)
  rp_address_bidir                  = lookup(local.interfaces, "rp_address_bidir", false)

  dynamic "rp_addresses" {
    for_each = lookup(local.interfaces, "rp_addresses", null) == null ? [] : lookup(local.interfaces, "rp_addresses", null)
    iterator = addresses
    content {
      access_list = addresses.value.access_list
      rp_address  = addresses.value.rp_address
      override    = addresses.value.override
      bidir       = addresses.value.bidir
    }
  }

  dynamic "rp_candidates" {
    for_each = lookup(local.interfaces, "rp_candidates", null) == null ? [] : lookup(local.interfaces, "rp_candidates", null)
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
  for_each                          = local.interfaces == "pim_vrf" ? 1 : 0
  vrf                               = lookup(local.interfaces, "vrf")
  autorp                            = lookup(local.interfaces, "autorp", false)
  autorp_listener                   = lookup(local.interfaces, "autorp_listener", false)
  device                            = [for device in local.devices : lookup(local.interfaces, "device") if local.devices == lookup(local.interfaces, "device")]
  bsr_candidate_loopback            = lookup(local.interfaces, "bsr_candidate_loopback", 100)
  bsr_candidate_mask                = lookup(local.interfaces, "bsr_candidate_mask", 30)
  bsr_candidate_priority            = lookup(local.interfaces, "bsr_candidate_priority", 0)
  bsr_candidate_accept_rp_candidate = lookup(local.interfaces, "bsr_candidate_accept_rp_candidate", null)
  ssm_range                         = lookup(local.interfaces, "ssm_range", null)
  ssm_default                       = lookup(local.interfaces, "ssm_default", false)
  rp_address                        = lookup(local.interfaces, "rp_address", null)
  rp_address_override               = lookup(local.interfaces, "rp_address_override", false)
  rp_address_bidir                  = lookup(local.interfaces, "rp_address_bidir", false)

  dynamic "rp_addresses" {
    for_each = lookup(local.interfaces, "rp_addresses", null) == null ? [] : lookup(local.interfaces, "rp_addresses", null)
    iterator = addresses
    content {
      access_list = addresses.value.access_list
      rp_address  = addresses.value.rp_address
      override    = addresses.value.override
      bidir       = addresses.value.bidir
    }
  }

  dynamic "rp_candidates" {
    for_each = lookup(local.interfaces, "rp_candidates", null) == null ? [] : lookup(local.interfaces, "rp_candidates", null)
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