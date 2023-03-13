## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_vsphere"></a> [vsphere](#requirement\_vsphere) | 2.3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vsphere"></a> [vsphere](#provider\_vsphere) | 2.3.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vsphere_distributed_virtual_switch.distributed_virtual_switch](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/distributed_virtual_switch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dsitributed_virtual_switch"></a> [dsitributed\_virtual\_switch](#input\_dsitributed\_virtual\_switch) | n/a | <pre>map(object({<br>    datacenter_id            = string<br>    folder                   = optional(string)<br>    description              = optional(string)<br>    contact_name             = optional(string)<br>    contact_detail           = optional(string)<br>    ipv4_address             = optional(string)<br>    lacp_api_version         = optional(string)<br>    link_discovery_operation = optional(string)<br>    link_discovery_protocol  = optional(string)<br>    max_mtu                  = optional(number)<br>    multicast_filtering_mode = optional(string)<br>    version                  = optional(string)<br>    tags                     = optional(list(string))<br>    custom_attributes        = optional(map(string))<br>  }))</pre> | n/a | yes |
| <a name="input_ha_policy"></a> [ha\_policy](#input\_ha\_policy) | n/a | <pre>object({<br>    active_uplinks  = optional(list(string))<br>    standby_uplinks = optional(list(string))<br>    check_beacon    = optional(bool)<br>    failback        = optional(bool)<br>    notify_switches = optional(bool)<br>    teaming_policy  = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_host"></a> [host](#input\_host) | n/a | <pre>object({<br>    host_system_id = string<br>    devices        = optional(list(string))<br>  })</pre> | n/a | yes |
| <a name="input_ignore_other_pvlan_mappings"></a> [ignore\_other\_pvlan\_mappings](#input\_ignore\_other\_pvlan\_mappings) | n/a | `string` | `false` | no |
| <a name="input_lacp_options"></a> [lacp\_options](#input\_lacp\_options) | n/a | <pre>object({<br>    lacp_enabled = optional(bool)<br>    lacp_mode    = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_miscellaneous_options"></a> [miscellaneous\_options](#input\_miscellaneous\_options) | n/a | <pre>object({<br>    block_all_ports         = optional(bool)<br>    netflow_enabled         = optional(bool)<br>    tx_uplink               = optional(bool)<br>    directpath_gen2_allowed = optional(bool)<br>  })</pre> | `{}` | no |
| <a name="input_netflow_options"></a> [netflow\_options](#input\_netflow\_options) | n/a | <pre>object({<br>    netflow_active_flow_timeout   = optional(number)<br>    netflow_collector_ip_address  = optional(string)<br>    netflow_collector_port        = optional(number)<br>    netflow_idle_flow_timeout     = optional(number)<br>    netflow_internal_flows_only   = optional(bool)<br>    netflow_observation_domain_id = optional(string)<br>    netflow_sampling_rate         = optional(number)<br>  })</pre> | `{}` | no |
| <a name="input_network_control"></a> [network\_control](#input\_network\_control) | n/a | <pre>object({<br>    network_resource_control_enabled = optional(bool)<br>    network_resource_control_version = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_pvlan_mapping"></a> [pvlan\_mapping](#input\_pvlan\_mapping) | n/a | <pre>object({<br>    primary_vlan_id   = optional(number)<br>    pvlan_type        = optional(string)<br>    secondary_vlan_id = optional(number)<br>  })</pre> | n/a | yes |
| <a name="input_security_options"></a> [security\_options](#input\_security\_options) | n/a | <pre>object({<br>    allow_forged_transmits = optional(bool)<br>    allow_mac_changes      = optional(bool)<br>    allow_promiscuous      = optional(bool)<br>  })</pre> | `{}` | no |
| <a name="input_traffic_class"></a> [traffic\_class](#input\_traffic\_class) | n/a | <pre>object({<br>    virtualmachine_share_level      = optional(string)<br>    virtualmachine_share_count      = optional(number)<br>    virtualmachine_reservation_mbit = optional(number)<br>    virtualmachine_maximum_mbit     = optional(number)<br>  })</pre> | `{}` | no |
| <a name="input_trafic_shaping"></a> [trafic\_shaping](#input\_trafic\_shaping) | n/a | <pre>object({<br>    ingress_shaping_average_bandwidth = optional(number)<br>    ingress_shaping_burst_size        = optional(number)<br>    ingress_shaping_enabled           = optional(bool)<br>    ingress_shaping_peak_bandwidth    = optional(number)<br>    egress_shaping_average_bandwidth  = optional(number)<br>    egress_shaping_burst_size         = optional(number)<br>    egress_shaping_enabled            = optional(bool)<br>    egress_shaping_peak_bandwidth     = optional(number)<br>  })</pre> | `{}` | no |
| <a name="input_uplinks"></a> [uplinks](#input\_uplinks) | n/a | `list(string)` | n/a | yes |
| <a name="input_vlan"></a> [vlan](#input\_vlan) | n/a | <pre>object({<br>      max_vlan = optional(number)<br>      min_vlan = optional(number)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_distributed_virtual_switch"></a> [distributed\_virtual\_switch](#output\_distributed\_virtual\_switch) | n/a |
