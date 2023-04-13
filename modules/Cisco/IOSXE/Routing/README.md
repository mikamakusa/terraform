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
| [iosxe_static_route.main](https://registry.terraform.io/providers/netascode/iosxe/0.1.15/docs/resources/static_route) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_static_route"></a> [static\_route](#input\_static\_route) | This resource can manage the Static Route configuration. | <pre>map(object({<br>    prefix = string<br>    mask   = string<br>    device = optional(string)<br>    next_hops = optional(list(object({<br>      next_hop  = optional(string)<br>      metric    = optional(number)<br>      global    = optional(bool)<br>      name      = optional(string)<br>      permanent = optional(bool)<br>      tag       = optional(number)<br>    })))<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_static_route"></a> [static\_route](#output\_static\_route) | n/a |
