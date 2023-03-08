resource "vsphere_distributed_port_group" "distributed_port_group" {
  for_each                        = var.distributed_port_group
  distributed_virtual_switch_uuid = each.value.distributed_virtual_switch_uuid
  name                            = each.key
  type                            = each.value.type
  description                     = each.value.description
  number_of_ports                 = each.value.number_of_ports
  auto_expand                     = each.value.auto_expand
  port_name_format                = each.value.port_name_format
  network_resource_pool_key       = each.value.network_resource_pool_key
  custom_attributes               = each.value.custom_attributes

  block_override_allowed                 = var.port_override.block_override_allowed
  live_port_moving_allowed               = var.port_override.live_port_moving_allowed
  netflow_override_allowed               = var.port_override.netflow_override_allowed
  network_resource_pool_override_allowed = var.port_override.network_resource_pool_override_allowed
  port_config_reset_at_disconnect        = var.port_override.port_config_reset_at_disconnect
  security_policy_override_allowed       = var.port_override.security_policy_override_allowed
  shaping_override_allowed               = var.port_override.shaping_override_allowed
  traffic_filter_override_allowed        = var.port_override.traffic_filter_override_allowed
  uplink_teaming_override_allowed        = var.port_override.uplink_teaming_override_allowed
  vlan_override_allowed                  = var.port_override.vlan_override_allowed

  vlan_id = var.vlan.vlan_id
  vlan_range {
    max_vlan = var.vlan.vlan_range.max_vlan
    min_vlan = var.vlan.vlan_range.min_vlan
  }
  port_private_secondary_vlan_id = var.vlan.port_private_secondary_vlan_id


  active_uplinks  = var.ha_policy.active_uplinks
  standby_uplinks = var.ha_policy.standby_uplinks
  check_beacon    = var.ha_policy.check_beacon
  failback        = var.ha_policy.failback
  notify_switches = var.ha_policy.notify_switches
  teaming_policy  = var.ha_policy.teaming_policy

  lacp_enabled = var.lacp_options.lacp_enabled
  lacp_mode    = var.lacp_options.lacp_mode

  allow_forged_transmits = var.security_options.allow_forged_transmits
  allow_mac_changes      = var.security_options.allow_mac_changes
  allow_promiscuous      = var.security_options.allow_promiscuous

  ingress_shaping_average_bandwidth = var.trafic_shaping.ingress_shaping_average_bandwidth
  ingress_shaping_burst_size        = var.trafic_shaping.ingress_shaping_burst_size
  ingress_shaping_enabled           = var.trafic_shaping.ingress_shaping_enabled
  ingress_shaping_peak_bandwidth    = var.trafic_shaping.ingress_shaping_peak_bandwidth
  egress_shaping_average_bandwidth  = var.trafic_shaping.egress_shaping_average_bandwidth
  egress_shaping_burst_size         = var.trafic_shaping.egress_shaping_burst_size
  egress_shaping_enabled            = var.trafic_shaping.egress_shaping_enabled
  egress_shaping_peak_bandwidth     = var.trafic_shaping.egress_shaping_peak_bandwidth

  block_all_ports         = var.miscellaneous_options.block_all_ports
  netflow_enabled         = var.miscellaneous_options.netflow_enabled
  tx_uplink               = var.miscellaneous_options.tx_uplink
  directpath_gen2_allowed = var.miscellaneous_options.directpath_gen2_allowed
}