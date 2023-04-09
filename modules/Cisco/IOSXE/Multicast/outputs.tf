output "multicast" {
  value = try(
    iosxe_interface_pim.multicast,
    iosxe_msdp.multicast,
    iosxe_msdp_vrf.multicast,
    iosxe_pim.multicast,
    iosxe_pim_vrf.multicast
  )
}