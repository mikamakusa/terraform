resource "vsphere_host_virtual_switch" "host_virtual_switch" {
  for_each        = var.host_virtual_switch
  host_system_id  = each.value.host_system_id
  name            = each.key
  mtu             = each.value.mtu
  number_of_ports = each.value.number_of_ports

  standby_nics    = var.nic_teaming_options.standby_nics
  active_nics     = var.nic_teaming_options.active_nics
  check_beacon    = var.nic_teaming_options.check_beacon
  teaming_policy  = var.nic_teaming_options.teaming_policy
  notify_switches = var.nic_teaming_options.notify_switches
  failback        = var.nic_teaming_options.failback

  network_adapters         = var.bridge_options.network_adapters
  beacon_interval          = var.bridge_options.beacon_interval
  link_discovery_operation = var.bridge_options.link_discovery_operation
  link_discovery_protocol  = var.bridge_options.link_discovery_protocol

  allow_forged_transmits = var.security_policy.allow_forged_transmits
  allow_promiscuous      = var.security_policy.allow_promiscuous
  allow_mac_changes      = var.security_policy.allow_mac_changes

  shaping_enabled           = var.traffic_shaping.shaping_enabled
  shaping_burst_size        = var.traffic_shaping.shaping_burst_size
  shaping_average_bandwidth = var.traffic_shaping.shaping_average_bandwidth
  shaping_peak_bandwidth    = var.traffic_shaping.shaping_peak_bandwidth
}