/*
locals {
  bgp = defaults(var.bgp, {
    router_id_loopback = 0
  })
  address_family = defaults(var.address_family, {
    af_name = "flowspec"
  })
  l2vpn = defaults(var.l2vpn, {
    af_name = "evpn"
  })
  neighbor = defaults(var.neighbor, {
    send_community = "both"
  })
}*/
