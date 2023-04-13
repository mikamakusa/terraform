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
| [iosxe_static_route.main](https://registry.terraform.io/providers/netascode/iosxe/latest/docs/resources/static_route) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_static_route"></a> [static\_route](#input\_static\_route) | This resource can manage the Static Route configuration. | <pre>map(object({<br>    prefix = string<br>    mask   = string<br>    device = optional(string)<br>    next_hops = optional(object({<br>      next_hop  = optional(string)<br>      metric    = optional(number)<br>      global    = optional(bool)<br>      name      = optional(string)<br>      permanent = optional(bool)<br>      tag       = optional(number)<br>    }))<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_static_route"></a> [static\_route](#output\_static\_route) | n/a |
