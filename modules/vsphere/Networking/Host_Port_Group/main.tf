resource "vsphere_host_port_group" "host_port_group" {
  for_each            = var.host_port_group
  host_system_id      = each.value.host_system_id
  name                = each.key
  virtual_switch_name = each.value.virtual_switch_name
  vlan_id             = each.value.vlan_id

  allow_promiscuous      = var.security_policy.allow_promiscuous
  allow_forged_transmits = var.security_policy.allow_forged_transmits
  allow_mac_changes      = var.security_policy.allow_mac_changes

  shaping_average_bandwidth = var.traffic_shaping.shaping_average_bandwidth
  shaping_burst_size        = var.traffic_shaping.shaping_burst_size
  shaping_enabled           = var.traffic_shaping.shaping_enabled
  shaping_peak_bandwidth    = var.traffic_shaping.shaping_peak_bandwidth

  standby_nics    = var.nic_teaming.standby_nics
  active_nics     = var.nic_teaming.active_nics
  teaming_policy  = var.nic_teaming.teaming_policy
  notify_switches = var.nic_teaming.notify_switches
  failback        = var.nic_teaming.failback
}