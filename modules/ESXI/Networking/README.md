## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_esxi"></a> [esxi](#provider\_esxi) | n/a |

## Modules

No modules.

## Resources


| Name | Type |
|------|------|
| esxi_vswitch.vswitch | resource |
| esxi_portgroup.portgroup | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_portgroup"></a> [portgroup](#input\_portgroup) | n/a | <pre>map(object({<br>    vswitch = string<br>    vlan = optional(string)<br>    }))</pre> | `{}` | no |
| <a name="input_vswitch"></a> [vswitch](#input\_vswitch) | n/a | <pre>map(object({<br>    port = optional(number)<br>    mtu = optional(number)<br>    promiscuous_mode = optional(bool)<br>    mac_changes = optional(bool)<br>    forged_transmits = optional(bool)<br>    uplink = list(string)<br>    }))</pre> | n/a | yes |

## Outputs

No outputs.
