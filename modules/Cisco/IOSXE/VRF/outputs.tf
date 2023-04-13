output "vrf" {
  value = try(
    iosxe_vrf.vrf
  )
}