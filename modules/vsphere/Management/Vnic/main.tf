resource "vsphere_vnic" "vnic" {
  host                    = var.vnic.host
  portgroup               = var.vnic.portgroup
  distributed_port_group  = var.vnic.distributed_port_group
  distributed_switch_port = var.vnic.distributed_switch_port

  dynamic "ipv4" {
    for_each = var.vnic.ipv4
    content {
      dhcp = ipv4.value.dhcp
      ip = ipv4.value.ip
      netmask = ipv4.value.netmask
      gw = ipv4.value.gw
    }
  }

  dynamic "ipv6" {
    for_each = var.vnic.ipv6
    content {
      dhcp = ipv6.value.dhcp
      autoconfig = ipv6.value.autoconfig
      addresses = ipv6.value.addresses
      gw = ipv6.value.gw
    }
  }

  mac      = var.vnic.mac
  mtu      = var.vnic.mtu
  netstack = var.vnic.netstack
}