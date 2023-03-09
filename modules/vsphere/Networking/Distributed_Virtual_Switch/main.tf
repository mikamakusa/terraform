resource "vsphere_distributed_virtual_switch" "distributed_virtual_switch" {
  for_each                 = var.dsitributed_virtual_switch
  datacenter_id            = each.value.datacenter_id
  name                     = each.key
  folder                   = each.value.folder
  description              = each.value.description
  contact_name             = each.value.contact_name
  contact_detail           = each.value.contact_detail
  ipv4_address             = each.value.ipv4_address
  lacp_api_version         = each.value.lacp_api_version
  link_discovery_operation = each.value.link_discovery_operation
  link_discovery_protocol  = each.value.link_discovery_protocol
  max_mtu                  = each.value.max_mtu
  multicast_filtering_mode = each.value.multicast_filtering_mode
  version                  = each.value.version
  tags                     = each.value.tags
  custom_attributes        = each.value.custom_attributes

  uplinks = var.uplinks

  dynamic "host" {
    for_each = var.host
    content {
      host_system_id = host.value.host_system_id
      devices        = host.value.devices
    }
  }

  ignore_other_pvlan_mappings = ""
  dynamic "pvlan_mapping" {
    for_each = var.pvlan_mapping
    content {
      primary_vlan_id   = pvlan_mapping.value.primary_vlan_id
      pvlan_type        = pvlan_mapping.value.pvlan_type
      secondary_vlan_id = pvlan_mapping.value.secondary_vlan_id
    }
  }

  netflow_active_flow_timeout   = var.netflow_options.netflow_active_flow_timeout
  netflow_collector_ip_address  = var.netflow_options.netflow_collector_ip_address
  netflow_collector_port        = var.netflow_options.netflow_collector_port
  netflow_idle_flow_timeout     = var.netflow_options.netflow_idle_flow_timeout
  netflow_internal_flows_only   = var.netflow_options.netflow_internal_flows_only
  netflow_observation_domain_id = var.netflow_options.netflow_observation_domain_id
  netflow_sampling_rate         = var.netflow_options.netflow_sampling_rate

  network_resource_control_enabled = var.network_control.network_resource_control_enabled
  network_resource_control_version = var.network_control.network_resource_control_version

  virtualmachine_share_level      = var.traffic_class.virtualmachine_share_level
  virtualmachine_share_count      = var.traffic_class.virtualmachine_share_count
  virtualmachine_reservation_mbit = var.traffic_class.virtualmachine_reservation_mbit
  virtualmachine_maximum_mbit     = var.traffic_class.virtualmachine_maximum_mbit

  dynamic "vlan_range" {
    for_each = var.vlan
    content {
      max_vlan = vlan_range.value.max_vlan
      min_vlan = vlan_range.value.min_vlan
    }
  }

  active_uplinks  = var.ha_policy.active_uplinks
  standby_uplinks = var.ha_policy.standby_uplinks
  check_beacon    = var.ha_policy.check_beacon
  failback        = var.ha_policy.failback
  notify_switches = var.ha_policy.notify_switches
  teaming_policy  = var.ha_policy.teaming_policy

  lacp_enabled = var.lacp_options.lacp_enabled
  lacp_mode    = var.lacp_options.lacp_mode

  allow_promiscuous      = var.security_options.allow_promiscuous
  allow_forged_transmits = var.security_options.allow_forged_transmits
  allow_mac_changes      = var.security_options.allow_mac_changes

  ingress_shaping_enabled           = var.trafic_shaping.ingress_shaping_enabled
  ingress_shaping_peak_bandwidth    = var.trafic_shaping.ingress_shaping_peak_bandwidth
  ingress_shaping_burst_size        = var.trafic_shaping.ingress_shaping_burst_size
  ingress_shaping_average_bandwidth = var.trafic_shaping.ingress_shaping_average_bandwidth
  egress_shaping_enabled            = var.trafic_shaping.egress_shaping_enabled
  egress_shaping_peak_bandwidth     = var.trafic_shaping.egress_shaping_peak_bandwidth
  egress_shaping_burst_size         = var.trafic_shaping.egress_shaping_burst_size
  egress_shaping_average_bandwidth  = var.trafic_shaping.egress_shaping_average_bandwidth

  block_all_ports         = var.miscellaneous_options.block_all_ports
  netflow_enabled         = var.miscellaneous_options.netflow_enabled
  tx_uplink               = var.miscellaneous_options.tx_uplink
  directpath_gen2_allowed = var.miscellaneous_options.directpath_gen2_allowed
}