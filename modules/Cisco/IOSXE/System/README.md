# System Cisco IOSXE Terraform module documentation

## Usage
### module declaration
```hcl
provider "iosxe" {
  username = var.username
  password = var.password
  url      = var.url
  insecure = true
}

module "System" {
  source      = "./System"
  banner      = [
    {
      exec_banner           = "My Exec Banner"
      login_banner          = "My Login Banner"
      prompt_timeout_banner = "My Prompt-Timeout Banner"
      motd_banner           = "My MOTD Banner"
    }
  ]
  dhcp        = [
    {
      compatibility_suboption_link_selection  = "cisco"
      relay_information_trust_all             = false
      relay_information_option_default        = false
      relay_information_option_vpn            = false
    }
  ]
  prefix_list = [
    {
      prefixes = [
        {
          name   = "PREFIX_LIST_1"
          seq    = 10
          action = "permit"
          ip     = "10.0.0.0/8"
          ge     = 24
          le     = 32
        }
      ]
    }
  ]
  route_map   = {
    rte_map_1 = {
      seq                                        = 10
      operation                                  = "permit"
      description                                = "Entry 10"
      continue                                   = false
      match_interfaces                           = ["GigabitEthernet1"]
      match_ip_address_access_lists              = ["ACL1"]
      match_ip_next_hop_access_lists             = ["ACL1"]
      match_ipv6_address_access_lists            = "ACL1"
      match_ipv6_next_hop_access_lists           = "ACL1"
      match_route_type_external                  = true
      match_route_type_external_type_1           = true
      match_route_type_external_type_2           = true
      match_route_type_internal                  = true
      match_route_type_level_1                   = true
      match_route_type_level_2                   = true
      match_route_type_local                     = true
      match_source_protocol_bgp                  = ["65000"]
      match_source_protocol_connected            = true
      match_source_protocol_eigrp                = ["10"]
      match_source_protocol_isis                 = true
      match_source_protocol_lisp                 = true
      match_source_protocol_ospf                 = ["10"]
      match_source_protocol_ospfv3               = ["10"]
      match_source_protocol_rip                  = true
      match_source_protocol_static               = true
      match_tags                                 = [100]
      match_track                                = 1
      match_as_paths                             = [10]
      match_community_lists                      = ["COMM1"]
      match_community_list_exact_match           = true
      match_extcommunity_lists                   = ["EXTCOMM1"]
      match_local_preferences                    = [100]
      set_default_interfaces                     = ["GigabitEthernet1"]
      set_global                                 = false
      set_interfaces                             = ["GigabitEthernet1"]
      set_ip_address                             = "PFL1"
      set_ip_default_global_next_hop_address     = ["1.2.3.4"]
      set_ip_default_next_hop_address            = ["1.2.3.4"]
      set_ip_global_next_hop_address             = ["1.2.3.4"]
      set_ip_next_hop_address                    = ["1.2.3.4"]
      set_ip_qos_group                           = 1
      set_ipv6_address                           = "PFL2"
      set_ipv6_default_global_next_hop           = "2001::1"
      set_ipv6_default_next_hop                  = ["2001::1"]
      set_ipv6_next_hop                          = ["2001::1"]
      set_level_1                                = true
      set_metric_value                           = 110
      set_metric_delay                           = "10"
      set_metric_reliability                     = 90
      set_metric_loading                         = 10
      set_metric_mtu                             = 1500
      set_metric_type                            = "external"
      set_tag                                    = 100
      set_as_path_prepend_as                     = "65001 65001"
      set_as_path_prepend_last_as                = 5
      set_as_path_tag                            = true
      set_communities                            = ["1:2"]
      set_communities_additive                   = true
      set_community_list_delete                  = true
      set_community_list_name                    = "COMML1"
      set_extcomunity_rt                         = ["10:10"]
      set_extcomunity_soo                        = "10:10"
      set_extcomunity_vpn_distinguisher          = "10:10"
      set_extcomunity_vpn_distinguisher_additive = true
      set_local_preference                       = 110
      set_weight                                 = 10000
    }
  }
  service     = [
    {
      pad                                     = true
      password_encryption                     = true
      password_recovery                       = true
      timestamps                              = true
      timestamps_debug                        = true
      timestamps_debug_datetime               = true
      timestamps_debug_datetime_msec          = true
      timestamps_debug_datetime_localtime     = true
      timestamps_debug_datetime_show_timezone = true
      timestamps_debug_datetime_year          = true
      timestamps_debug_uptime                 = true
      timestamps_log                          = true
      timestamps_log_datetime                 = true
      timestamps_log_datetime_msec            = true
      timestamps_log_datetime_localtime       = true
      timestamps_log_datetime_show_timezone   = true
      timestamps_log_datetime_year            = true
      timestamps_log_uptime                   = true
      dhcp                                    = true
      tcp_keepalives_in                       = true
      tcp_keepalives_out                      = true
    }
  ]
  system      = [
    {
      hostname                      = "ROUTER-1"
      ipv6_unicast_routing          = true
      ip_source_route               = false
      ip_domain_lookup              = false
      ip_domain_name                = "test.com"
      login_delay                   = 10
      login_on_failure              = true
      login_on_failure_log          = true
      login_on_success              = true
      login_on_success_log          = true
      multicast_routing             = true
      multicast_routing_distributed = true
    }
  ]
}
```

## Requirements

| Name | Version   |
|------|-----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.5  |
| <a name="requirement_iosxe"></a> [iosxe](#requirement\_iosxe) | >= 0.1.15 |

## Providers

| Name | Version   |
|------|-----------|
| <a name="provider_iosxe"></a> [iosxe](#provider\_iosxe) | >= 0.1.15 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [iosxe_banner.banner](https://registry.terraform.io/providers/netascode/iosxe/latest/docs/resources/banner) | resource |
| [iosxe_dhcp.dhcp](https://registry.terraform.io/providers/netascode/iosxe/latest/docs/resources/dhcp) | resource |
| [iosxe_prefix_list.prefix_list](https://registry.terraform.io/providers/netascode/iosxe/latest/docs/resources/prefix_list) | resource |
| [iosxe_route_map.route_map](https://registry.terraform.io/providers/netascode/iosxe/latest/docs/resources/route_map) | resource |
| [iosxe_service.service](https://registry.terraform.io/providers/netascode/iosxe/latest/docs/resources/service) | resource |
| [iosxe_system.system](https://registry.terraform.io/providers/netascode/iosxe/latest/docs/resources/system) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_banner"></a> [banner](#input\_banner) | This resource can manage the Banner configuration. | <pre>list(object({<br>    exec_banner           = optional(string)<br>    login_banner          = optional(string)<br>    prompt_timeout_banner = optional(string)<br>    motd_banner           = optional(string)<br>    device                = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_dhcp"></a> [dhcp](#input\_dhcp) | This resource can manage the DHCP configuration. | <pre>list(object({<br>    compatibility_suboption_link_selection  = optional(string)<br>    compatibility_suboption_server_override = optional(string)<br>    device                                  = optional(string)<br>    relay_information_option_default        = optional(bool)<br>    relay_information_option_vpn            = optional(bool)<br>    relay_information_trust_all             = optional(bool)<br>    snooping                                = optional(bool)<br>    snooping_vlans = optional(list(object({<br>      vlan_id = optional(number)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_prefix_list"></a> [prefix\_list](#input\_prefix\_list) | This resource can manage the Prefix List configuration. | <pre>list(object({<br>    device = optional(string)<br>    prefixes = optional(object({<br>      name   = optional(string)<br>      seq    = optional(number)<br>      action = optional(string)<br>      ip     = optional(string)<br>      ge     = optional(number)<br>      le     = optional(number)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_route_map"></a> [route\_map](#input\_route\_map) | This resource can manage the Route Map configuration. | <pre>map(object({<br>    device = optional(string)<br>    entries = optional(object({<br>      continue                                   = optional(bool)<br>      continue_sequence_number                   = optional(number)<br>      description                                = optional(string)<br>      match_as_paths                             = optional(list(number))<br>      match_community_list_exact_match           = optional(bool)<br>      match_community_lists                      = optional(list(string))<br>      match_extcommunity_lists                   = optional(list(string))<br>      match_interfaces                           = optional(list(string))<br>      match_ip_address_access_lists              = optional(list(string))<br>      match_ip_address_prefix_lists              = optional(list(string))<br>      match_ip_next_hop_access_lists             = optional(list(string))<br>      match_ip_next_hop_prefix_lists             = optional(list(string))<br>      match_ipv6_address_access_lists            = optional(string)<br>      match_ipv6_address_prefix_lists            = optional(string)<br>      match_ipv6_next_hop_access_lists           = optional(string)<br>      match_ipv6_next_hop_prefix_lists           = optional(string)<br>      match_local_preferences                    = optional(list(number))<br>      match_route_type_external                  = optional(bool)<br>      match_route_type_external_type_1           = optional(bool)<br>      match_route_type_external_type_2           = optional(bool)<br>      match_route_type_internal                  = optional(bool)<br>      match_route_type_level_1                   = optional(bool)<br>      match_route_type_level_2                   = optional(bool)<br>      match_route_type_local                     = optional(bool)<br>      match_source_protocol_bgp                  = optional(list(string))<br>      match_source_protocol_connected            = optional(bool)<br>      match_source_protocol_eigrp                = optional(list(string))<br>      match_source_protocol_isis                 = optional(bool)<br>      match_source_protocol_lisp                 = optional(bool)<br>      match_source_protocol_ospf                 = optional(list(string))<br>      match_source_protocol_ospfv3               = optional(list(string))<br>      match_source_protocol_rip                  = optional(bool)<br>      match_source_protocol_static               = optional(bool)<br>      match_tags                                 = optional(list(number))<br>      match_track                                = optional(number)<br>      operation                                  = optional(string)<br>      seq                                        = optional(number)<br>      set_as_path_prepend_as                     = optional(string)<br>      set_as_path_prepend_last_as                = optional(number)<br>      set_as_path_tag                            = optional(bool)<br>      set_communities                            = optional(list(string))<br>      set_communities_additive                   = optional(bool)<br>      set_community_list_delete                  = optional(bool)<br>      set_community_list_expanded                = optional(number)<br>      set_community_list_name                    = optional(string)<br>      set_community_list_standard                = optional(number)<br>      set_community_none                         = optional(bool)<br>      set_default_interfaces                     = optional(list(string))<br>      set_extcomunity_rt                         = optional(list(string))<br>      set_extcomunity_soo                        = optional(string)<br>      set_extcomunity_vpn_distinguisher          = optional(string)<br>      set_extcomunity_vpn_distinguisher_additive = optional(bool)<br>      set_global                                 = optional(bool)<br>      set_interfaces                             = optional(list(string))<br>      set_ip_address                             = optional(string)<br>      set_ip_default_global_next_hop_address     = optional(list(string))<br>      set_ip_default_next_hop_address            = optional(list(string))<br>      set_ip_global_next_hop_address             = optional(list(string))<br>      set_ip_next_hop_address                    = optional(list(string))<br>      set_ip_next_hop_self                       = optional(bool)<br>      set_ip_qos_group                           = optional(number)<br>      set_ipv6_address                           = optional(string)<br>      set_ipv6_default_global_next_hop           = optional(string)<br>      set_ipv6_default_next_hop                  = optional(list(string))<br>      set_ipv6_next_hop                          = optional(list(string))<br>      set_level_1                                = optional(bool)<br>      set_level_1_2                              = optional(bool)<br>      set_level_2                                = optional(bool)<br>      set_local_preference                       = optional(number)<br>      set_metric_change                          = optional(string)<br>      set_metric_delay                           = optional(string)<br>      set_metric_loading                         = optional(number)<br>      set_metric_mtu                             = optional(number)<br>      set_metric_reliability                     = optional(number)<br>      set_metric_type                            = optional(string)<br>      set_metric_value                           = optional(number)<br>      set_tag                                    = optional(number)<br>      set_vrf                                    = optional(string)<br>      set_weight                                 = optional(number)<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_service"></a> [service](#input\_service) | This resource can manage the Service configuration. | <pre>list(object({<br>    device                                  = optional(string)<br>    pad                                     = optional(bool)<br>    password_encryption                     = optional(bool)<br>    password_recovery                       = optional(bool)<br>    timestamps                              = optional(bool)<br>    timestamps_debug                        = optional(bool)<br>    timestamps_debug_datetime               = optional(bool)<br>    timestamps_debug_datetime_msec          = optional(bool)<br>    timestamps_debug_datetime_localtime     = optional(bool)<br>    timestamps_debug_datetime_show_timezone = optional(bool)<br>    timestamps_debug_datetime_year          = optional(bool)<br>    timestamps_debug_uptime                 = optional(bool)<br>    timestamps_log                          = optional(bool)<br>    timestamps_log_datetime                 = optional(bool)<br>    timestamps_log_datetime_msec            = optional(bool)<br>    timestamps_log_datetime_localtime       = optional(bool)<br>    timestamps_log_datetime_show_timezone   = optional(bool)<br>    timestamps_log_datetime_year            = optional(bool)<br>    timestamps_log_uptime                   = optional(bool)<br>    dhcp                                    = optional(bool)<br>    tcp_keepalives_in                       = optional(bool)<br>    tcp_keepalives_out                      = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_system"></a> [system](#input\_system) | This resource can manage the System configuration. | <pre>list(object({<br>    device                        = optional(string)<br>    hostname                      = optional(string)<br>    ipv6_unicast_routing          = optional(bool)<br>    ip_source_route               = optional(bool)<br>    ip_domain_lookup              = optional(bool)<br>    ip_domain_name                = optional(string)<br>    login_delay                   = optional(number)<br>    login_on_failure              = optional(bool)<br>    login_on_failure_log          = optional(bool)<br>    login_on_success              = optional(bool)<br>    login_on_success_log          = optional(bool)<br>    multicast_routing             = optional(bool)<br>    multicast_routing_distributed = optional(bool)<br>    multicast_routing_switch      = optional(string)<br>    ip_routing                    = optional(bool)<br>    mtu                           = optional(number)<br>    multicast_routing_vrfs = optional(list(object({<br>      distributed = optional(bool)<br>      vrf         = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_system"></a> [system](#output\_system) | n/a |
