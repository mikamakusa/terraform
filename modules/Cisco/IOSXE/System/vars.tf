variable "banner" {
  type = list(object({
    exec_banner           = optional(string)
    login_banner          = optional(string)
    prompt_timeout_banner = optional(string)
    motd_banner           = optional(string)
    device                = optional(string)
  }))

  default = []

  description = "This resource can manage the Banner configuration."
}

variable "dhcp" {
  type = list(object({
    compatibility_suboption_link_selection  = optional(string)
    compatibility_suboption_server_override = optional(string)
    device                                  = optional(string)
    relay_information_option_default        = optional(bool)
    relay_information_option_vpn            = optional(bool)
    relay_information_trust_all             = optional(bool)
    snooping                                = optional(bool)
    snooping_vlans = optional(list(object({
      vlan_id = optional(number)
    })))
  }))

  default = []

  description = "This resource can manage the DHCP configuration."
}

variable "prefix_list" {
  type = list(object({
    device = optional(string)
    prefixes = optional(list(object({
      name   = optional(string)
      seq    = optional(number)
      action = optional(string)
      ip     = optional(string)
      ge     = optional(number)
      le     = optional(number)
    })))
  }))

  default = []

  description = "This resource can manage the Prefix List configuration."
}

variable "route_map" {
  type = map(object({
    device = optional(string)
    entries = optional(list(object({
      continue                                   = optional(bool)
      continue_sequence_number                   = optional(number)
      description                                = optional(string)
      match_as_paths                             = optional(list(number))
      match_community_list_exact_match           = optional(bool)
      match_community_lists                      = optional(list(string))
      match_extcommunity_lists                   = optional(list(string))
      match_interfaces                           = optional(list(string))
      match_ip_address_access_lists              = optional(list(string))
      match_ip_address_prefix_lists              = optional(list(string))
      match_ip_next_hop_access_lists             = optional(list(string))
      match_ip_next_hop_prefix_lists             = optional(list(string))
      match_ipv6_address_access_lists            = optional(string)
      match_ipv6_address_prefix_lists            = optional(string)
      match_ipv6_next_hop_access_lists           = optional(string)
      match_ipv6_next_hop_prefix_lists           = optional(string)
      match_local_preferences                    = optional(list(number))
      match_route_type_external                  = optional(bool)
      match_route_type_external_type_1           = optional(bool)
      match_route_type_external_type_2           = optional(bool)
      match_route_type_internal                  = optional(bool)
      match_route_type_level_1                   = optional(bool)
      match_route_type_level_2                   = optional(bool)
      match_route_type_local                     = optional(bool)
      match_source_protocol_bgp                  = optional(list(string))
      match_source_protocol_connected            = optional(bool)
      match_source_protocol_eigrp                = optional(list(string))
      match_source_protocol_isis                 = optional(bool)
      match_source_protocol_lisp                 = optional(bool)
      match_source_protocol_ospf                 = optional(list(string))
      match_source_protocol_ospfv3               = optional(list(string))
      match_source_protocol_rip                  = optional(bool)
      match_source_protocol_static               = optional(bool)
      match_tags                                 = optional(list(number))
      match_track                                = optional(number)
      operation                                  = optional(string)
      seq                                        = optional(number)
      set_as_path_prepend_as                     = optional(string)
      set_as_path_prepend_last_as                = optional(number)
      set_as_path_tag                            = optional(bool)
      set_communities                            = optional(list(string))
      set_communities_additive                   = optional(bool)
      set_community_list_delete                  = optional(bool)
      set_community_list_expanded                = optional(number)
      set_community_list_name                    = optional(string)
      set_community_list_standard                = optional(number)
      set_community_none                         = optional(bool)
      set_default_interfaces                     = optional(list(string))
      set_extcomunity_rt                         = optional(list(string))
      set_extcomunity_soo                        = optional(string)
      set_extcomunity_vpn_distinguisher          = optional(string)
      set_extcomunity_vpn_distinguisher_additive = optional(bool)
      set_global                                 = optional(bool)
      set_interfaces                             = optional(list(string))
      set_ip_address                             = optional(string)
      set_ip_default_global_next_hop_address     = optional(list(string))
      set_ip_default_next_hop_address            = optional(list(string))
      set_ip_global_next_hop_address             = optional(list(string))
      set_ip_next_hop_address                    = optional(list(string))
      set_ip_next_hop_self                       = optional(bool)
      set_ip_qos_group                           = optional(number)
      set_ipv6_address                           = optional(string)
      set_ipv6_default_global_next_hop           = optional(string)
      set_ipv6_default_next_hop                  = optional(list(string))
      set_ipv6_next_hop                          = optional(list(string))
      set_level_1                                = optional(bool)
      set_level_1_2                              = optional(bool)
      set_level_2                                = optional(bool)
      set_local_preference                       = optional(number)
      set_metric_change                          = optional(string)
      set_metric_delay                           = optional(string)
      set_metric_loading                         = optional(number)
      set_metric_mtu                             = optional(number)
      set_metric_reliability                     = optional(number)
      set_metric_type                            = optional(string)
      set_metric_value                           = optional(number)
      set_tag                                    = optional(number)
      set_vrf                                    = optional(string)
      set_weight                                 = optional(number)
    })))
  }))

  default = {}

  description = "This resource can manage the Route Map configuration."
}

variable "service" {
  type = list(object({
    device                                  = optional(string)
    pad                                     = optional(bool)
    password_encryption                     = optional(bool)
    password_recovery                       = optional(bool)
    timestamps                              = optional(bool)
    timestamps_debug                        = optional(bool)
    timestamps_debug_datetime               = optional(bool)
    timestamps_debug_datetime_msec          = optional(bool)
    timestamps_debug_datetime_localtime     = optional(bool)
    timestamps_debug_datetime_show_timezone = optional(bool)
    timestamps_debug_datetime_year          = optional(bool)
    timestamps_debug_uptime                 = optional(bool)
    timestamps_log                          = optional(bool)
    timestamps_log_datetime                 = optional(bool)
    timestamps_log_datetime_msec            = optional(bool)
    timestamps_log_datetime_localtime       = optional(bool)
    timestamps_log_datetime_show_timezone   = optional(bool)
    timestamps_log_datetime_year            = optional(bool)
    timestamps_log_uptime                   = optional(bool)
    dhcp                                    = optional(bool)
    tcp_keepalives_in                       = optional(bool)
    tcp_keepalives_out                      = optional(bool)
  }))

  default = []

  description = "This resource can manage the Service configuration."
}

variable "system" {
  type = list(object({
    device                        = optional(string)
    hostname                      = optional(string)
    ipv6_unicast_routing          = optional(bool)
    ip_source_route               = optional(bool)
    ip_domain_lookup              = optional(bool)
    ip_domain_name                = optional(string)
    login_delay                   = optional(number)
    login_on_failure              = optional(bool)
    login_on_failure_log          = optional(bool)
    login_on_success              = optional(bool)
    login_on_success_log          = optional(bool)
    multicast_routing             = optional(bool)
    multicast_routing_distributed = optional(bool)
    multicast_routing_switch      = optional(string)
    ip_routing                    = optional(bool)
    mtu                           = optional(number)
    multicast_routing_vrfs = optional(list(object({
      distributed = optional(bool)
      vrf         = optional(string)
    })))
  }))

  default = []

  description = "This resource can manage the System configuration."
}