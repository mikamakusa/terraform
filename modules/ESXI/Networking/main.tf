resource "esxi_vswitch" "vswitch" {
  for_each = var.vswitch
  name = each.key
  port = each.value.port
  mtu = each.value.mtu
  promiscuous_mode = each.value.promiscuous_mode
  mac_changes = each.value.mac_changes
  forged_transmits = each.value.forged_transmits

  dynamic "uplink" {
    for_each = each.value.uplink
    content {
      name = uplink.value
    }
  }
}

resource "esxi_portgroup" "portgroup" {
  for_each = var.portgroup
  name = each.key
  vswitch = esxi_vswtich.vswitch[each.value.vswitch].id
  vlan = each.value.vlan
}