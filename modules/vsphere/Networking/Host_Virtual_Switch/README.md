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
| [vsphere_host_virtual_switch.host_virtual_switch](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/host_virtual_switch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bridge_options"></a> [bridge\_options](#input\_bridge\_options) | n/a | <pre>object({<br>    network_adapters         = list(string)<br>    beacon_interval          = optional(number)<br>    link_discovery_operation = optional(string)<br>    link_discovery_protocol  = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_host_virtual_switch"></a> [host\_virtual\_switch](#input\_host\_virtual\_switch) | n/a | <pre>map(object({<br>    host_system_id  = string<br>    mtu             = optional(number)<br>    number_of_ports = optional(number)<br>  }))</pre> | n/a | yes |
| <a name="input_nic_teaming_options"></a> [nic\_teaming\_options](#input\_nic\_teaming\_options) | n/a | <pre>object({<br>    standby_nics    = optional(list(string))<br>    active_nics     = list(string)<br>    check_beacon    = optional(bool)<br>    teaming_policy  = optional(string)<br>    notify_switches = optional(bool)<br>    failback        = optional(bool)<br>  })</pre> | n/a | yes |
| <a name="input_security_policy"></a> [security\_policy](#input\_security\_policy) | n/a | <pre>object({<br>    allow_forged_transmits = optional(bool)<br>    allow_promiscuous      = optional(bool)<br>    allow_mac_changes      = optional(bool)<br>  })</pre> | `{}` | no |
| <a name="input_traffic_shaping"></a> [traffic\_shaping](#input\_traffic\_shaping) | n/a | <pre>object({<br>    shaping_enabled           = optional(bool)<br>    shaping_burst_size        = optional(number)<br>    shaping_average_bandwidth = optional(number)<br>    shaping_peak_bandwidth    = optional(number)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_host_virtual_switch"></a> [host\_virtual\_switch](#output\_host\_virtual\_switch) | n/a |
