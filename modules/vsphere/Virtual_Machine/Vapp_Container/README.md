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
| [vsphere_vapp_container.vapp_container](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/vapp_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(string)` | n/a | yes |
| <a name="input_vapp"></a> [vapp](#input\_vapp) | n/a | <pre>map(object({<br>    parent_resource_pool_id = string<br>    parent_folder_id        = optional(string)<br>    cpu_share_level         = optional(string)<br>    cpu_shares              = optional(number)<br>    cpu_reservation         = optional(number)<br>    cpu_expandable          = optional(number)<br>    cpu_limit               = optional(number)<br>    memory_share_level      = optional(string)<br>    memory_shares           = optional(number)<br>    memory_reservation      = optional(number)<br>    memory_expandable       = optional(number)<br>    memory_limit            = optional(number)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vapp_container"></a> [vapp\_container](#output\_vapp\_container) | n/a |
