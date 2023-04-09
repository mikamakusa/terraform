output "ospf" {
  value = try(
    iosxe_interface_ospf.ospf,
    iosxe_interface_ospf_process.ospf,
    iosxe_ospf.ospf,
    iosxe_ospf_vrf.ospf
  )
}