module "ACL" {
  source = "./ACL"
  acl    = {}
}

module "BGP" {
  source         = "./BGP"
  address_family = []
  bgp            = []
  l2vpn          = []
  neighbor       = []
}

module "EVPN" {
  source        = "./EVPN"
  evpn          = []
  evpn_instance = []
}

module "Interface" {
  source       = "./Interface"
  ethernet     = {}
  loopback     = {}
  nve          = {}
  port_channel = {}
  vlan         = {}
}

module "Management" {
  source           = "./Management"
  group            = {}
  ipv4_logging     = []
  ipv4_vrf_logging = []
  ipv6_logging     = []
  ipv6_vrf_logging = []
  logging          = []
  snmp             = {}
  user             = {}
}

module "Multicast" {
  source        = "./Multicast"
  interface_pim = {}
  msdp          = []
  msdp_vrf      = []
  pim_vrf       = []
  pim           = []
}

module "OSPF" {
  source       = "./OSPF"
  interface    = {}
  ospf         = {}
  ospf_process = {}
}

module "Routing" {
  source       = "./Routing"
  static_route = {}
}

module "Switching" {
  source     = "./Switching"
  vlan       = {}
  switchport = {}
}

module "System" {
  source      = "./System"
  banner      = []
  dhcp        = []
  prefix_list = []
  route_map   = {}
  service     = []
  system      = []
}

module "VRF" {
  source = "./VRF"
  vrf    = {}
}