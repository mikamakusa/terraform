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
| [vsphere_host_port_group.host_port_group](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/host_port_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_host_port_group"></a> [host\_port\_group](#input\_host\_port\_group) | n/a | <pre>map(object({<br>    host_system_id      = string<br>    virtual_switch_name = string<br>    vlan_id             = optional(number)<br>  }))</pre> | n/a | yes |
| <a name="input_nic_teaming"></a> [nic\_teaming](#input\_nic\_teaming) | n/a | <pre>object({<br>    standby_nics    = optional(list(string))<br>    active_nics     = optional(list(string))<br>    teaming_policy  = optional(string)<br>    notify_switches = optional(string)<br>    failback        = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_security_policy"></a> [security\_policy](#input\_security\_policy) | n/a | <pre>object({<br>    allow_promiscuous      = optional(bool)<br>    allow_forged_transmits = optional(bool)<br>    allow_mac_changes      = optional(bool)<br>  })</pre> | `{}` | no |
| <a name="input_traffic_shaping"></a> [traffic\_shaping](#input\_traffic\_shaping) | n/a | <pre>object({<br>    shaping_average_bandwidth = optional(number)<br>    shaping_burst_size        = optional(number)<br>    shaping_enabled           = optional(bool)<br>    shaping_peak_bandwidth    = optional(number)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_host_port_group"></a> [host\_port\_group](#output\_host\_port\_group) | n/a |
