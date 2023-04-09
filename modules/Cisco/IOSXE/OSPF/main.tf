resource "iosxe_interface_ospf" "ospf" {
  for_each                         = local.ospf
  type                             = lookup(local.ospf, "type")
  name                             = lookup(local.ospf, "name")
  cost                             = lookup(local.ospf, "cost", 1)
  dead_interval                    = lookup(local.ospf, "dead_interval", 1)
  hello_interval                   = lookup(local.ospf, "hello_interval", 1)
  mtu_ignore                       = lookup(local.ospf, "mtu_ignore", false)
  network_type_broadcast           = lookup(local.ospf, "network_type_broadcast", false)
  network_type_non_broadcast       = lookup(local.ospf, "network_type_non_broadcast", false)
  network_type_point_to_multipoint = lookup(local.ospf, "network_type_point_to_multipoint", false)
  network_type_point_to_point      = lookup(local.ospf, "network_type_point_to_point", false)
  priority                         = lookup(local.ospf, "priority", 0)
  device                           = lookup(local.ospf, "device", null)
}

resource "iosxe_interface_ospf_process" "ospf" {
  for_each   = local.ospf
  type       = lookup(local.ospf, "type")
  name       = lookup(local.ospf, "name")
  process_id = lookup(local.ospf, "process_id", 1)
  device     = lookup(local.ospf, "device", null)

  dynamic "area" {
    for_each = lookup(local.ospf, "area", null)
    content {
      area_id = area.value.area_id
    }
  }
}

resource "iosxe_ospf" "ospf" {
  for_each                             = local.ospf
  process_id                           = lookup(local.ospf, "process_id")
  device                               = lookup(local.ospf, "device", null)
  bfd_all_interfaces                   = lookup(local.ospf, "bfd_all_interfaces", true)
  default_information_originate        = lookup(local.ospf, "default_information_originate", true)
  default_information_originate_always = lookup(local.ospf, "default_information_originate_always", true)
  default_metric                       = lookup(local.ospf, "default_metric", 1)
  distance                             = lookup(local.ospf, "distance", 1)
  domain_tag                           = lookup(local.ospf, "domain_tag", 1)
  mpls_ldp_autoconfig                  = lookup(local.ospf, "mpls_ldp_autoconfig", true)
  mpls_ldp_sync                        = lookup(local.ospf, "mpls_ldp_sync", true)
  priority                             = lookup(local.ospf, "priority", 0)
  router_id                            = lookup(local.ospf, "router_id", null)
  shutdown                             = lookup(local.ospf, "shutdown", false)

  dynamic "neighbor" {
    for_each = lookup(local.ospf, "neighbor", null)
    content {
      ip       = neighbor.value.ip
      priority = neighbor.value.priority
      cost     = neighbor.value.cost
    }
  }

  dynamic "network" {
    for_each = lookup(local.ospf, "network", null)
    content {
      ip       = network.value.ip
      wildcard = network.value.wildcard
      area     = network.value.area
    }
  }

  dynamic "summary_address" {
    for_each = lookup(local.ospf, "summary_address", null)
    content {
      ip   = summary_address.value.ip
      mask = summary_address.value.mask
    }
  }
}

resource "iosxe_ospf_vrf" "ospf" {
  for_each                             = local.ospf
  process_id                           = lookup(local.ospf, "process_id", 1)
  device                               = lookup(local.ospf, "device", null)
  vrf                                  = lookup(local.ospf, "vrf")
  bfd_all_interfaces                   = lookup(local.ospf, "bfd_all_interfaces", true)
  default_information_originate        = lookup(local.ospf, "default_information_originate", true)
  default_information_originate_always = lookup(local.ospf, "default_information_originate_always", true)
  default_metric                       = lookup(local.ospf, "default_metric", 1)
  distance                             = lookup(local.ospf, "distance", 1)
  domain_tag                           = lookup(local.ospf, "domain_tag", 1)
  mpls_ldp_autoconfig                  = lookup(local.ospf, "mpls_ldp_autoconfig", true)
  mpls_ldp_sync                        = lookup(local.ospf, "mpls_ldp_sync", true)
  priority                             = lookup(local.ospf, "priority", 0)
  router_id                            = lookup(local.ospf, "router_id", null)
  shutdown                             = lookup(local.ospf, "shutdown", false)

  dynamic "neighbor" {
    for_each = lookup(local.ospf, "neighbor", null)
    content {
      ip       = neighbor.value.ip
      priority = neighbor.value.priority
      cost     = neighbor.value.cost
    }
  }

  dynamic "network" {
    for_each = lookup(local.ospf, "network", null)
    content {
      ip       = network.value.ip
      wildcard = network.value.wildcard
      area     = network.value.area
    }
  }

  dynamic "summary_address" {
    for_each = lookup(local.ospf, "summary_address", null)
    content {
      ip   = summary_address.value.ip
      mask = summary_address.value.mask
    }
  }
}