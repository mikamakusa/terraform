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
  snooping_vlans                          = each.value.snooping_vlans
}

resource "iosxe_prefix_list" "prefix_list" {
  for_each = toset(keys({ for k, v in var.prefix_list : k => v }))
  device   = var.prefix_list[each.value]["device"]
  prefixes = var.prefix_list[each.value]["prefixes"]
}

resource "iosxe_route_map" "route_map" {
  for_each = var.route_map
  name     = each.key
  entries  = each.value.entries
}

resource "iosxe_service" "service" {
  for_each                                = toset(keys({ for k, v in var.service : k => v }))
  device                                  = var.service[each.value]["device"]
  pad                                     = var.service[each.value]["pad"]
  password_encryption                     = var.service[each.value]["password_encryption"]
  password_recovery                       = var.service[each.value]["password_recovery"]
  timestamps                              = var.service[each.value]["timestamps"]
  timestamps_debug                        = var.service[each.value]["timestamps_debug"]
  timestamps_debug_datetime               = var.service[each.value]["timestamps_debug_datetime"]
  timestamps_debug_datetime_msec          = var.service[each.value]["timestamps_debug_datetime_msec"]
  timestamps_debug_datetime_localtime     = var.service[each.value]["timestamps_debug_datetime_localtime"]
  timestamps_debug_datetime_show_timezone = var.service[each.value]["timestamps_debug_datetime_show_timezone"]
  timestamps_debug_datetime_year          = var.service[each.value]["timestamps_debug_datetime_year"]
  timestamps_debug_uptime                 = var.service[each.value]["timestamps_debug_uptime"]
  timestamps_log                          = var.service[each.value]["timestamps_log"]
  timestamps_log_datetime                 = var.service[each.value]["timestamps_log_datetime"]
  timestamps_log_datetime_msec            = var.service[each.value]["timestamps_log_datetime_msec"]
  timestamps_log_datetime_localtime       = var.service[each.value]["timestamps_log_datetime_localtime"]
  timestamps_log_datetime_show_timezone   = var.service[each.value]["timestamps_log_datetime_show_timezone"]
  timestamps_log_datetime_year            = var.service[each.value]["timestamps_log_datetime_year"]
  timestamps_log_uptime                   = var.service[each.value]["timestamps_log_uptime"]
  dhcp                                    = var.service[each.value]["dhcp"]
  tcp_keepalives_in                       = var.service[each.value]["tcp_keepalives_in"]
  tcp_keepalives_out                      = var.service[each.value]["tcp_keepalives_out"]
}

resource "iosxe_system" "system" {
  for_each                      = toset(keys({ for k, v in var.system : k => v }))
  device                        = var.system[each.value]["device"]
  hostname                      = var.system[each.value]["hostname"]
  ipv6_unicast_routing          = var.system[each.value]["ipv6_unicast_routing"]
  ip_source_route               = var.system[each.value]["ip_source_route"]
  ip_domain_lookup              = var.system[each.value]["ip_domain_lookup"]
  ip_domain_name                = var.system[each.value]["ip_domain_name"]
  login_delay                   = var.system[each.value]["login_delay"]
  login_on_failure              = var.system[each.value]["login_on_failure"]
  login_on_failure_log          = var.system[each.value]["login_on_failure_log"]
  login_on_success              = var.system[each.value]["login_on_success"]
  login_on_success_log          = var.system[each.value]["login_on_success_log"]
  multicast_routing             = var.system[each.value]["multicast_routing"]
  multicast_routing_distributed = var.system[each.value]["multicast_routing_distributed"]
  multicast_routing_switch      = var.system[each.value]["multicast_routing_switch"]
  ip_routing                    = var.system[each.value]["ip_routing"]
  mtu                           = var.system[each.value]["mtu"]
  multicast_routing_vrfs        = var.system[each.value]["multicast_routing_vrfs"]
}