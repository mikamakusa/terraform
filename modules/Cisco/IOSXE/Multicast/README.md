## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_iosxe"></a> [iosxe](#provider\_iosxe) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [iosxe_interface_pim.multicast](https://registry.terraform.io/providers/hashicorp/iosxe/latest/docs/resources/interface_pim) | resource |
| [iosxe_msdp.multicast](https://registry.terraform.io/providers/hashicorp/iosxe/latest/docs/resources/msdp) | resource |
| [iosxe_msdp_vrf.multicast](https://registry.terraform.io/providers/hashicorp/iosxe/latest/docs/resources/msdp_vrf) | resource |
| [iosxe_pim.multicast](https://registry.terraform.io/providers/hashicorp/iosxe/latest/docs/resources/pim) | resource |
| [iosxe_pim_vrf.multicast](https://registry.terraform.io/providers/hashicorp/iosxe/latest/docs/resources/pim_vrf) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_interface_pim"></a> [interface\_pim](#input\_interface\_pim) | This resource can manage the Interface PIM configuration. | <pre>map(object({<br>    type              = string<br>    passive           = optional(bool)<br>    dense_mode        = optional(bool)<br>    sparse_mode       = optional(bool)<br>    sparse_dense_mode = optional(bool)<br>    bfd               = optional(bool)<br>    border            = optional(bool)<br>    bsr_border        = optional(bool)<br>    dr_priority       = optional(number)<br>    device            = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_msdp"></a> [msdp](#input\_msdp) | This resource can manage the MSDP configuration. | <pre>list(object({<br>    device        = optional(string)<br>    originator_id = optional(string)<br>    passwords = list(object({<br>      password   = string<br>      addr       = optional(string)<br>      encryption = optional(number)<br>    }))<br>    peers = list(object({<br>      addr                    = optional(string)<br>      connect_source_loopback = optional(number)<br>      remote_as               = optional(number)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_msdp_vrf"></a> [msdp\_vrf](#input\_msdp\_vrf) | This resource can manage the MSDP VRF configuration. | <pre>list(object({<br>    device        = optional(string)<br>    originator_id = optional(string)<br>    vrf           = optional(string)<br>    passwords = list(object({<br>      password   = string<br>      addr       = optional(string)<br>      encryption = optional(number)<br>    }))<br>    peers = list(object({<br>      addr                    = optional(string)<br>      connect_source_loopback = optional(number)<br>      remote_as               = optional(number)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_pim"></a> [pim](#input\_pim) | This resource can manage the PIM configuration. | <pre>list(object({<br>    autorp                            = optional(bool)<br>    autorp_listener                   = optional(bool)<br>    device                            = optional(string)<br>    bsr_candidate_loopback            = optional(number)<br>    bsr_candidate_mask                = optional(number)<br>    bsr_candidate_priority            = optional(number)<br>    bsr_candidate_accept_rp_candidate = optional(string)<br>    ssm_range                         = optional(string)<br>    ssm_default                       = optional(bool)<br>    rp_address                        = optional(string)<br>    rp_address_override               = optional(bool)<br>    rp_address_bidir                  = optional(bool)<br>    rp_addresses = optional(object({<br>      access_list = optional(string)<br>      bidir       = optional(bool)<br>      override    = optional(bool)<br>      rp_address  = optional(string)<br>    }))<br>    rp_candidates = optional(object({<br>      bidir      = optional(bool)<br>      group_list = optional(string)<br>      interface  = optional(string)<br>      interval   = optional(number)<br>      priority   = optional(number)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_pim_vrf"></a> [pim\_vrf](#input\_pim\_vrf) | This resource can manage the PIM VRF configuration. | <pre>list(object({<br>    vrf                               = optional(string)<br>    autorp                            = optional(bool)<br>    autorp_listener                   = optional(bool)<br>    device                            = optional(string)<br>    bsr_candidate_loopback            = optional(number)<br>    bsr_candidate_mask                = optional(number)<br>    bsr_candidate_priority            = optional(number)<br>    bsr_candidate_accept_rp_candidate = optional(string)<br>    ssm_range                         = optional(string)<br>    ssm_default                       = optional(bool)<br>    rp_address                        = optional(string)<br>    rp_address_override               = optional(bool)<br>    rp_address_bidir                  = optional(bool)<br>    rp_addresses = optional(object({<br>      access_list = optional(string)<br>      bidir       = optional(bool)<br>      override    = optional(bool)<br>      rp_address  = optional(string)<br>    }))<br>    rp_candidates = optional(object({<br>      bidir      = optional(bool)<br>      group_list = optional(string)<br>      interface  = optional(string)<br>      interval   = optional(number)<br>      priority   = optional(number)<br>    }))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_multicast"></a> [multicast](#output\_multicast) | n/a |
