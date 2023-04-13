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
| [iosxe_vrf.vrf](https://registry.terraform.io/providers/netascode/iosxe/0.1.15/docs/resources/vrf) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vrf"></a> [vrf](#input\_vrf) | This resource can manage the VRF configuration. | <pre>map(object({<br>    description         = optional(string)<br>    rd                  = optional(string)<br>    address_family_ipv4 = optional(bool)<br>    address_family_ipv6 = optional(bool)<br>    vpn_id              = optional(bool)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vrf"></a> [vrf](#output\_vrf) | n/a |
