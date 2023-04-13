output "logging" {
  value = try(
    iosxe_logging.logging,
    iosxe_logging_ipv4_host_transport.logging,
    iosxe_logging_ipv4_host_vrf_transport.logging,
    iosxe_logging_ipv6_host_transport.logging,
    iosxe_logging_ipv6_host_vrf_transport.logging
  )
}

/*
output "snmp" {
  value = try(
    iosxe_snmp_server.snmp,
    iosxe_snmp_server_group.snmp,
    iosxe_snmp_server_user.snmp
  )
}*/
