output "system" {
  value = try(
    iosxe_banner.banner,
    iosxe_dhcp.dhcp,
    iosxe_prefix_list.prefix_list,
    iosxe_route_map.route_map,
    iosxe_service.service,
    iosxe_system.system
  )
}