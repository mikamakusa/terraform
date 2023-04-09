output "evpn" {
  value = try(
    iosxe_evpn.evpn,
    iosxe_evpn_instance.evpn
  )
}