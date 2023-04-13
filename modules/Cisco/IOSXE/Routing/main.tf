resource "iosxe_static_route" "main" {
  for_each  = var.static_route
  prefix    = each.key
  mask      = each.value.mask
  device    = each.value.device
  next_hops = each.value.next_hops
}