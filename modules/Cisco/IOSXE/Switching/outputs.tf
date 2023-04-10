output "switchport" {
  value = iosxe_interface_switchport.switchport
}

output "vlan" {
  value = try(
    iosxe_vlan.vlan,
    iosxe_vlan_configuration.vlan_configuration
  )
}