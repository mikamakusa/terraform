/*
locals {
  dhcp = defaults(var.dhcp, {
    relay_information_trust_all            = false
    relay_information_option_default       = false
    relay_information_option_vpn           = false
    compatibility_suboption_link_selection = "cisco"
    compatibility_suboption_link_override  = "cisco"
    snooping                               = false
  })
  route_map_entries = defaults(var.route_map.entries, {
    seq                                        = 10
    operation                                  = "permit"
    continue                                   = false
    match_interfaces                           = ["GigabitEthernet1"]
    match_route_type_external                  = false
    match_route_type_external_type_1           = false
    match_route_type_external_type_2           = false
    match_route_type_internal                  = false
    match_route_type_level_1                   = false
    match_route_type_level_2                   = false
    match_route_type_local                     = false
    match_source_protocol_connected            = false
    match_source_protocol_isis                 = false
    match_source_protocol_lisp                 = false
    match_source_protocol_rip                  = false
    match_source_protocol_static               = false
    match_track                                = 1
    match_community_list_exact_match           = false
    set_default_interfaces                     = ["GigabitEthernet1"]
    set_global                                 = false
    set_interfaces                             = ["GigabitEthernet1"]
    set_level_1                                = false
    set_metric_value                           = 110
    set_metric_reliability                     = 90
    set_metric_loading                         = 10
    set_metric_mtu                             = 1500
    set_tag                                    = 100
    set_as_path_prepend_last_as                = 5
    set_as_path_tag                            = false
    set_communities_additive                   = false
    set_community_list_delete                  = false
    set_extcomunity_vpn_distinguisher_additive = false
  })
  service = defaults(var.service, {
    pad                                     = false
    password_encryption                     = false
    password_recovery                       = false
    timestamps                              = false
    timestamps_debug                        = false
    timestamps_debug_datetime               = false
    timestamps_debug_datetime_msec          = false
    timestamps_debug_datetime_localtime     = false
    timestamps_debug_datetime_show_timezone = false
    timestamps_debug_datetime_year          = false
    timestamps_debug_uptime                 = false
    timestamps_log                          = false
    timestamps_log_datetime                 = false
    timestamps_log_datetime_msec            = false
    timestamps_log_datetime_localtime       = false
    timestamps_log_datetime_show_timezone   = false
    timestamps_log_datetime_year            = false
    timestamps_log_uptime                   = false
    dhcp                                    = false
    tcp_keepalives_in                       = false
    tcp_keepalives_out                      = false
  })
  system = defaults(var.system, {
    ipv6_unicast_routing          = false
    ip_source_route               = false
    ip_domain_lookup              = false
    login_on_failure              = false
    login_on_failure_log          = false
    login_on_success              = false
    login_on_success_log          = false
    multicast_routing             = false
    multicast_routing_distributed = false
  })
}
*/
