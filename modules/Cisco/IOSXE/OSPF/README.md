## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_iosxe"></a> [iosxe](#requirement\_iosxe) | 0.1.15 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_iosxe"></a> [iosxe](#provider\_iosxe) | 0.1.15 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [iosxe_interface_ospf.ospf](https://registry.terraform.io/providers/netascode/iosxe/0.1.15/docs/resources/interface_ospf) | resource |
| [iosxe_interface_ospf_process.ospf](https://registry.terraform.io/providers/netascode/iosxe/0.1.15/docs/resources/interface_ospf_process) | resource |
| [iosxe_ospf.ospf](https://registry.terraform.io/providers/netascode/iosxe/0.1.15/docs/resources/ospf) | resource |
| [iosxe_ospf_vrf.ospf](https://registry.terraform.io/providers/netascode/iosxe/0.1.15/docs/resources/ospf_vrf) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_interface"></a> [interface](#input\_interface) | This resource can manage the Interface OSPF configuration. | <pre>map(object({<br>    type                             = string<br>    cost                             = optional(number)<br>    dead_interval                    = optional(number)<br>    hello_interval                   = optional(number)<br>    mtu_ignore                       = optional(bool)<br>    network_type_broadcast           = optional(bool)<br>    network_type_non_broadcast       = optional(bool)<br>    network_type_point_to_multipoint = optional(bool)<br>    network_type_point_to_point      = optional(bool)<br>    priority                         = optional(number)<br>    device                           = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_ospf"></a> [ospf](#input\_ospf) | This resource can manage the OSPF / OSPF VRF configuration. | <pre>map(object({<br>    device                               = optional(string)<br>    bfd_all_interfaces                   = optional(bool)<br>    default_information_originate        = optional(bool)<br>    default_information_originate_always = optional(bool)<br>    default_metric                       = optional(number)<br>    distance                             = optional(number)<br>    domain_tag                           = optional(number)<br>    mpls_ldp_autoconfig                  = optional(bool)<br>    mpls_ldp_sync                        = optional(bool)<br>    priority                             = optional(number)<br>    router_id                            = optional(string)<br>    shutdown                             = optional(bool)<br>    vrf                                  = optional(bool)<br>    neighbor = optional(list(object({<br>      ip       = optional(string)<br>      cost     = optional(number)<br>      priority = optional(number)<br>    })))<br>    network = optional(list(object({<br>      area     = optional(string)<br>      ip       = optional(string)<br>      wildcard = optional(string)<br>    })))<br>    summary_address = optional(list(object({<br>      ip   = optional(string)<br>      mask = optional(string)<br>    })))<br>  }))</pre> | `{}` | no |
| <a name="input_ospf_process"></a> [ospf\_process](#input\_ospf\_process) | This resource can manage the Interface OSPF Process configuration. | <pre>map(object({<br>    type       = string<br>    process_id = optional(number)<br>    device     = optional(string)<br>    area = optional(list(object({<br>      area_id = optional(string)<br>    })))<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ospf"></a> [ospf](#output\_ospf) | n/a |
