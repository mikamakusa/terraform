/*
locals {
  interface = defaults(var.interface, {
    type                             = "GigabitEthernet"
    mtu_ignore                       = false
    network_type_broadcast           = false
    network_type_non_broadcast       = false
    network_type_point_to_multipoint = false
    network_type_point_to_point      = true
  })
  ospf_process = defaults(var.ospf_process, {
    type = "GigabitEthernet"
  })
  ospf = defaults(var.ospf, {
    bfd_all_interfaces                   = true
    default_information_originate        = true
    default_information_originate_always = true
    default_metric                       = 1
    distance                             = 1
    priority                             = 0
    shutdown                             = false
  })
  ospf_neighbor = defaults(var.ospf.neighbor, {
    priority = 10
    cost     = 100
  })
}*/
