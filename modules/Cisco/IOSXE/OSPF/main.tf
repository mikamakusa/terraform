resource "iosxe_interface_ospf" "ospf" {
  for_each                         = var.interface
  type                             = each.value.type
  name                             = each.key
  cost                             = each.value.cost
  dead_interval                    = each.value.dead_interval
  hello_interval                   = each.value.hello_interval
  mtu_ignore                       = each.value.mtu_ignore
  network_type_broadcast           = each.value.network_type_broadcast
  network_type_non_broadcast       = each.value.network_type_non_broadcast
  network_type_point_to_multipoint = each.value.network_type_point_to_multipoint
  network_type_point_to_point      = each.value.network_type_point_to_point
  priority                         = each.value.priority
  device                           = each.value.device
}

resource "iosxe_interface_ospf_process" "ospf" {
  for_each   = var.ospf_process
  type       = each.value.type
  name       = each.key
  process_id = each.value.process_id
  device     = each.value.device
  area       = each.value.area
}

resource "iosxe_ospf" "ospf" {
  for_each = {
    for key, value in var.ospf : key => value
    if lookup(value, "vrf", null) == false
  }
  process_id                           = tonumber(each.key)
  device                               = each.value.device
  bfd_all_interfaces                   = each.value.bfd_all_interfaces
  default_information_originate        = each.value.default_information_originate
  default_information_originate_always = each.value.default_information_originate_always
  default_metric                       = each.value.default_metric
  distance                             = each.value.distance
  domain_tag                           = each.value.domain_tag
  mpls_ldp_autoconfig                  = each.value.mpls_ldp_autoconfig
  mpls_ldp_sync                        = each.value.mpls_ldp_sync
  priority                             = each.value.priority
  router_id                            = each.value.router_id
  shutdown                             = each.value.shutdown
  neighbor                             = each.value.neighbor
  network                              = each.value.network
  summary_address                      = each.value.summary_address
}

resource "iosxe_ospf_vrf" "ospf" {
  for_each = {
    for key, value in var.ospf : key => value
    if lookup(value, "vrf", null) == true
  }
  vrf                                  = each.value.vrf
  process_id                           = tonumber(each.key)
  device                               = each.value.device
  bfd_all_interfaces                   = each.value.bfd_all_interfaces
  default_information_originate        = each.value.default_information_originate
  default_information_originate_always = each.value.default_information_originate_always
  default_metric                       = each.value.default_metric
  distance                             = each.value.distance
  domain_tag                           = each.value.domain_tag
  mpls_ldp_autoconfig                  = each.value.mpls_ldp_autoconfig
  mpls_ldp_sync                        = each.value.mpls_ldp_sync
  priority                             = each.value.priority
  router_id                            = each.value.router_id
  shutdown                             = each.value.shutdown
  neighbor                             = each.value.neighbor
  network                              = each.value.network
  summary_address                      = each.value.summary_address
}