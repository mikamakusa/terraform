output "get_vlan" {
  value = try(
    iosxe_rest.list,
    iosxe_rest.get_id
  )
}