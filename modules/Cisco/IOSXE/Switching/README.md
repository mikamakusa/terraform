## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_iosxe"></a> [iosxe](#requirement\_iosxe) | >=0.1.13 |
| <a name="requirement_utils"></a> [utils](#requirement\_utils) | >= 0.2.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_iosxe"></a> [iosxe](#provider\_iosxe) | >=0.1.13 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [iosxe_interface_switchport.switchport](https://registry.terraform.io/providers/netascode/iosxe/latest/docs/resources/interface_switchport) | resource |
| [iosxe_vlan.vlan](https://registry.terraform.io/providers/netascode/iosxe/latest/docs/resources/vlan) | resource |
| [iosxe_vlan_configuration.vlan_configuration](https://registry.terraform.io/providers/netascode/iosxe/latest/docs/resources/vlan_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_switchport"></a> [switchport](#input\_switchport) | This data source can read the Interface Switchport configuration. | <pre>map(object({<br>    type                          = string<br>    mode_access                   = optional(bool)<br>    mode_dot1q_tunnel             = optional(bool)<br>    mode_private_vlan_trunk       = optional(bool)<br>    mode_private_vlan_host        = optional(bool)<br>    mode_private_vlan_promiscuous = optional(bool)<br>    mode_trunk                    = optional(bool)<br>    nonegotiate                   = optional(bool)<br>    access_vlan                   = optional(string)<br>    trunk_allowed_vlans           = optional(string)<br>    trunk_native_vlan_tag         = optional(bool)<br>    trunk_native_vlan             = optional(number)<br>    host                          = optional(bool)<br>    device                        = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_vlan"></a> [vlan](#input\_vlan) | This data source can read the VLAN configuration. | <pre>map(object({<br>    vlan_id                  = number<br>    shutdown                 = optional(bool)<br>    private_vlan_association = optional(string)<br>    private_vlan_community   = optional(string)<br>    private_vlan_isolated    = optional(string)<br>    private_vlan_primary     = optional(string)<br>    remote_span              = optional(string)<br>    device                   = optional(string)<br>    access_vfi               = optional(string)<br>    vni                      = optional(number)<br>    evpn_instance            = optional(number)<br>    evpn_instance_vni        = optional(number)<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_switchport"></a> [switchport](#output\_switchport) | n/a |
| <a name="output_vlan"></a> [vlan](#output\_vlan) | n/a |
