output "interface" {
  value = try(
    iosxe_interface_ethernet.interface,
    iosxe_interface_loopback.interface,
    iosxe_interface_nve.interface,
    iosxe_interface_port_channel.interface,
    iosxe_interface_port_channel_subinterface.interface,
    iosxe_interface_vlan.interface
  )
}