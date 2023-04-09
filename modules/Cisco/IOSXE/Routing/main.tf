resource "iosxe_static_route" "main" {
  for_each = var.static_route
  prefix   = each.key
  mask     = each.value.mask
  device   = each.value.device

  dynamic "next_hops" {
    for_each = each.value.next_hops
    content {
      next_hop  = next_hops.value.next_hop
      metric    = next_hops.value.metric
      global    = next_hops.value.global
      name      = next_hops.value.name
      permanent = next_hops.value.permanent
      tag       = next_hops.value.tag
    }
  }
}