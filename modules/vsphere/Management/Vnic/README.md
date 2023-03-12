## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vsphere"></a> [vsphere](#provider\_vsphere) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vsphere_vnic.vnic](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/vnic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vnic"></a> [vnic](#input\_vnic) | n/a | <pre>object({<br>    host                    = string<br>    portgroup               = optional(string)<br>    distributed_switch_port = optional(string)<br>    distributed_port_group  = optional(string)<br>    mac                     = optional(string)<br>    mtu                     = optional(string)<br>    netstack                = optional(string)<br>    ipv4 = optional(object({<br>      dhcp    = optional(bool)<br>      ip      = optional(string)<br>      netmask = optional(string)<br>      gw      = optional(string)<br>    }))<br>    ipv6 = optional(object({<br>      dhcp       = optional(bool)<br>      autoconfig = optional(bool)<br>      addresses  = optional(list(string))<br>      gw         = optional(string)<br>    }))<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vnic"></a> [vnic](#output\_vnic) | n/a |
