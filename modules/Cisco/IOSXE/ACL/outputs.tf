output "ios_access_list_id" {
  value = try(
    iosxe_access_list_standard.standard,
    iosxe_access_list_extended.extended
  )
}