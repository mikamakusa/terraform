resource "iosxe_banner" "banner" {
  for_each              = var.banner
  device                = each.value.device
  exec_banner           = each.value.exec_banner
  login_banner          = each.value.login_banner
  prompt_timeout_banner = each.value.prompt_timeout_banner
  motd_banner           = each.value.motd_banner
}

resource "iosxe_dhcp" "dhcp" {
  for_each                                = var.dhcp
  relay_information_trust_all             = each.value.relay_information_trust_all
  relay_information_option_default        = each.value.relay_information_option_default
  relay_information_option_vpn            = each.value.relay_information_option_vpn
  compatibility_suboption_link_selection  = each.value.compatibility_suboption_link_selection
  compatibility_suboption_server_override = each.value.compatibility_suboption_server_override
  device                                  = each.value.device
  snooping                                = each.value.snooping

  dynamic "snooping_vlans" {
    for_each = each.value.snooping_vlans
    content {
      vlan_id = snooping_vlans.value.vlan_id
    }
  }
}

resource "iosxe_prefix_list" "prefix_list" {
  for_each = var.prefix_list
  device   = each.value.device

  dynamic "prefixes" {
    for_each = each.value.prefixes
    content {
      name   = prefixes.value.name
      seq    = prefixes.value.seq
      action = prefixes.value.action
      ip     = prefixes.value.ip
      ge     = prefixes.value.ge
      le     = prefixes.value.le
    }
  }
}

resource "iosxe_route_map" "route_map" {
  for_each = var.route_map
  name     = each.key

  dynamic "entries" {
    for_each = each.value.entries
    content {
      continue                                   = entries.value.continue
      continue_sequence_number                   = entries.value.continue_sequence_number
      description                                = entries.value.description
      match_as_paths                             = entries.value.match_as_paths
      match_community_list_exact_match           = entries.value.match_community_list_exact_match
      match_community_lists                      = entries.value.match_community_lists
      match_extcommunity_lists                   = entries.value.match_extcommunity_lists
      match_interfaces                           = entries.value.match_interfaces
      match_ip_address_access_lists              = entries.value.match_ip_address_access_lists
      match_ip_address_prefix_lists              = entries.value.match_ip_address_prefix_lists
      match_ip_next_hop_access_lists             = entries.value.match_ip_next_hop_access_lists
      match_ip_next_hop_prefix_lists             = entries.value.match_ip_next_hop_prefix_lists
      match_ipv6_address_access_lists            = entries.value.match_ipv6_address_access_lists
      match_ipv6_address_prefix_lists            = entries.value.match_ipv6_address_prefix_lists
      match_ipv6_next_hop_access_lists           = entries.value.match_ipv6_next_hop_access_lists
      match_ipv6_next_hop_prefix_lists           = entries.value.match_ipv6_next_hop_prefix_lists
      match_local_preferences                    = entries.value.match_local_preferences
      match_route_type_external                  = entries.value.match_route_type_external
      match_route_type_external_type_1           = entries.value.match_route_type_external_type_1
      match_route_type_external_type_2           = entries.value.match_route_type_external_type_2
      match_route_type_internal                  = entries.value.match_route_type_internal
      match_route_type_level_1                   = entries.value.match_route_type_level_1
      match_route_type_level_2                   = entries.value.match_route_type_level_2
      match_route_type_local                     = entries.value.match_route_type_local
      match_source_protocol_bgp                  = entries.value.match_source_protocol_bgp
      match_source_protocol_connected            = entries.value.match_source_protocol_connected
      match_source_protocol_eigrp                = entries.value.match_source_protocol_eigrp
      match_source_protocol_isis                 = entries.value.match_source_protocol_isis
      match_source_protocol_lisp                 = entries.value.match_source_protocol_lisp
      match_source_protocol_ospf                 = entries.value.match_source_protocol_ospf
      match_source_protocol_ospfv3               = entries.value.match_source_protocol_ospfv3
      match_source_protocol_rip                  = entries.value.match_source_protocol_rip
      match_source_protocol_static               = entries.value.match_source_protocol_static
      match_tags                                 = entries.value.match_tags
      match_track                                = entries.value.match_track
      operation                                  = entries.value.operation
      seq                                        = entries.value.seq
      set_as_path_prepend_as                     = entries.value.set_as_path_prepend_as
      set_as_path_prepend_last_as                = entries.value.set_as_path_prepend_last_as
      set_as_path_tag                            = entries.value.set_as_path_tag
      set_communities                            = entries.value.set_communities
      set_communities_additive                   = entries.value.set_communities_additive
      set_community_list_delete                  = entries.value.set_community_list_delete
      set_community_list_expanded                = entries.value.set_community_list_expanded
      set_community_list_name                    = entries.value.set_community_list_name
      set_community_list_standard                = entries.value.set_community_list_standard
      set_community_none                         = entries.value.set_community_none
      set_default_interfaces                     = entries.value.set_default_interfaces
      set_extcomunity_rt                         = entries.value.set_extcomunity_rt
      set_extcomunity_soo                        = entries.value.set_extcomunity_soo
      set_extcomunity_vpn_distinguisher          = entries.value.set_extcomunity_vpn_distinguisher
      set_extcomunity_vpn_distinguisher_additive = entries.value.set_extcomunity_vpn_distinguisher_additive
      set_global                                 = entries.value.set_global
      set_interfaces                             = entries.value.set_interfaces
      set_ip_address                             = entries.value.set_ip_address
      set_ip_default_global_next_hop_address     = entries.value.set_ip_default_global_next_hop_address
      set_ip_default_next_hop_address            = entries.value.set_ip_default_next_hop_address
      set_ip_global_next_hop_address             = entries.value.set_ip_global_next_hop_address
      set_ip_next_hop_address                    = entries.value.set_ip_next_hop_address
      set_ip_next_hop_self                       = entries.value.set_ip_next_hop_self
      set_ip_qos_group                           = entries.value.set_ip_qos_group
      set_ipv6_address                           = entries.value.set_ipv6_address
      set_ipv6_default_global_next_hop           = entries.value.set_ipv6_default_global_next_hop
      set_ipv6_default_next_hop                  = entries.value.set_ipv6_default_next_hop
      set_ipv6_next_hop                          = entries.value.set_ipv6_next_hop
      set_level_1                                = entries.value.set_level_1
      set_level_1_2                              = entries.value.set_level_1_2
      set_level_2                                = entries.value.set_level_2
      set_local_preference                       = entries.value.set_local_preference
      set_metric_change                          = entries.value.set_metric_change
      set_metric_delay                           = entries.value.set_metric_delay
      set_metric_loading                         = entries.value.set_metric_loading
      set_metric_mtu                             = entries.value.set_metric_mtu
      set_metric_reliability                     = entries.value.set_metric_reliability
      set_metric_type                            = entries.value.set_metric_type
      set_metric_value                           = entries.value.set_metric_value
      set_tag                                    = entries.value.set_tag
      set_vrf                                    = entries.value.set_vrf
      set_weight                                 = entries.value.set_weight
    }
  }
}

resource "iosxe_service" "service" {
  for_each                                = var.service
  device                                  = each.value.device
  pad                                     = each.value.pad
  password_encryption                     = each.value.password_encryption
  password_recovery                       = each.value.password_recovery
  timestamps                              = each.value.timestamps
  timestamps_debug                        = each.value.timestamps_debug
  timestamps_debug_datetime               = each.value.timestamps_debug_datetime
  timestamps_debug_datetime_msec          = each.value.timestamps_debug_datetime_msec
  timestamps_debug_datetime_localtime     = each.value.timestamps_debug_datetime_localtime
  timestamps_debug_datetime_show_timezone = each.value.timestamps_debug_datetime_show_timezone
  timestamps_debug_datetime_year          = each.value.timestamps_debug_datetime_year
  timestamps_debug_uptime                 = each.value.timestamps_debug_uptime
  timestamps_log                          = each.value.timestamps_log
  timestamps_log_datetime                 = each.value.timestamps_log_datetime
  timestamps_log_datetime_msec            = each.value.timestamps_log_datetime_msec
  timestamps_log_datetime_localtime       = each.value.timestamps_log_datetime_localtime
  timestamps_log_datetime_show_timezone   = each.value.timestamps_log_datetime_show_timezone
  timestamps_log_datetime_year            = each.value.timestamps_log_datetime_year
  timestamps_log_uptime                   = each.value.timestamps_log_uptime
  dhcp                                    = each.value.dhcp
  tcp_keepalives_in                       = each.value.tcp_keepalives_in
  tcp_keepalives_out                      = each.value.tcp_keepalives_out
}

resource "iosxe_system" "system" {
  for_each = var.system
  device                        = each.value.device
  hostname                      = each.value.hostname
  ipv6_unicast_routing          = each.value.ipv6_unicast_routing
  ip_source_route               = each.value.ip_source_route
  ip_domain_lookup              = each.value.ip_domain_lookup
  ip_domain_name                = each.value.ip_domain_name
  login_delay                   = each.value.login_delay
  login_on_failure              = each.value.login_on_failure
  login_on_failure_log          = each.value.login_on_failure_log
  login_on_success              = each.value.login_on_success
  login_on_success_log          = each.value.login_on_success_log
  multicast_routing             = each.value.multicast_routing
  multicast_routing_distributed = each.value.multicast_routing_distributed
  multicast_routing_switch      = each.value.multicast_routing_switch
  ip_routing                    = each.value.ip_routing
  ip_source_route               = each.value.ip_source_route
  ipv6_unicast_routing          = each.value.ipv6_unicast_routing
  mtu                           = each.value.mtu

  dynamic "multicast_routing_vrfs" {
    for_each = each.value.multicast_routing_vrfs
    iterator = vrfs
    content {
      vrf = vrfs.value.vrf
      distributed = vrfs.value.distributed
    }
  }
}