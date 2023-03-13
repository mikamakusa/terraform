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
| [vsphere_distributed_port_group.distributed_port_group](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/distributed_port_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_distributed_port_group"></a> [distributed\_port\_group](#input\_distributed\_port\_group) | n/a | <pre>map(object({<br>    distributed_virtual_switch_uuid = string<br>    type = optional(string)<br>    description = optional(string)<br>    number_of_ports = optional(number)<br>    auto_expand = optional(bool)<br>    port_name_format = optional(string)<br>    network_resource_pool_key = optional(string)<br>    custom_attributes = optional(map(string))<br>  }))</pre> | n/a | yes |
| <a name="input_ha_policy"></a> [ha\_policy](#input\_ha\_policy) | n/a | <pre>object({<br>    active_uplinks  = optional(list(string))<br>    standby_uplinks = optional(list(string))<br>    check_beacon    = optional(bool)<br>    failback        = optional(bool)<br>    notify_switches = optional(bool)<br>    teaming_policy  = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_lacp_options"></a> [lacp\_options](#input\_lacp\_options) | n/a | <pre>object({<br>    lacp_enabled = optional(bool)<br>    lacp_mode    = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_miscellaneous_options"></a> [miscellaneous\_options](#input\_miscellaneous\_options) | n/a | <pre>object({<br>    block_all_ports         = optional(bool)<br>    netflow_enabled         = optional(bool)<br>    tx_uplink               = optional(bool)<br>    directpath_gen2_allowed = optional(bool)<br>  })</pre> | `{}` | no |
| <a name="input_port_override"></a> [port\_override](#input\_port\_override) | n/a | <pre>object({<br>    block_override_allowed = optional(bool)<br>    live_port_moving_allowed = optional(bool)<br>    netflow_override_allowed = optional(bool)<br>    network_resource_pool_override_allowed = optional(bool)<br>    port_config_reset_at_disconnect = optional(bool)<br>    security_policy_override_allowed = optional(bool)<br>    shaping_override_allowed = optional(bool)<br>    traffic_filter_override_allowed = optional(bool)<br>    uplink_teaming_override_allowed = optional(bool)<br>    vlan_override_allowed = optional(bool)<br>  })</pre> | `{}` | no |
| <a name="input_security_options"></a> [security\_options](#input\_security\_options) | n/a | <pre>object({<br>    allow_forged_transmits = optional(bool)<br>    allow_mac_changes      = optional(bool)<br>    allow_promiscuous      = optional(bool)<br>  })</pre> | `{}` | no |
| <a name="input_trafic_shaping"></a> [trafic\_shaping](#input\_trafic\_shaping) | n/a | <pre>object({<br>    ingress_shaping_average_bandwidth = optional(number)<br>    ingress_shaping_burst_size        = optional(number)<br>    ingress_shaping_enabled           = optional(bool)<br>    ingress_shaping_peak_bandwidth    = optional(number)<br>    egress_shaping_average_bandwidth  = optional(number)<br>    egress_shaping_burst_size         = optional(number)<br>    egress_shaping_enabled            = optional(bool)<br>    egress_shaping_peak_bandwidth     = optional(number)<br>  })</pre> | `{}` | no |
| <a name="input_vlan"></a> [vlan](#input\_vlan) | n/a | <pre>object({<br>    vlan_id = optional(string)<br>    vlan_range = optional(object({<br>      max_vlan = optional(number)<br>      min_vlan = optional(number)<br>    }))<br>    port_private_secondary_vlan_id = optional(string)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_distributed_port_group"></a> [distributed\_port\_group](#output\_distributed\_port\_group) | n/a |
