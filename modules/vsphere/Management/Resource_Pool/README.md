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
| [vsphere_resource_pool.resource_pool](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/resource_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config"></a> [config](#input\_config) | n/a | <pre>object({<br>    cpu_share_level    = optional(string)<br>    cpu_expandable     = optional(bool)<br>    cpu_limit          = optional(string)<br>    cpu_reservation    = optional(number)<br>    cpu_shares         = optional(string)<br>    memory_expandable  = optional(bool)<br>    memory_limit       = optional(string)<br>    memory_reservation = optional(number)<br>    memory_share_level = optional(string)<br>    memory_shares      = optional(string)<br>    tags               = optional(list(string))<br>  })</pre> | `{}` | no |
| <a name="input_resource_pool"></a> [resource\_pool](#input\_resource\_pool) | n/a | <pre>map(object({<br>    parent_resource_pool_id = string<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_pool"></a> [resource\_pool](#output\_resource\_pool) | n/a |
