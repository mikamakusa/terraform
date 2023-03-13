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
| [vsphere_vm_storage_policy.storage_policy](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/vm_storage_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_storage_policy"></a> [storage\_policy](#input\_storage\_policy) | n/a | <pre>map(object({<br>    description = optional(string)<br>    tag_rule = list(object({<br>      tag_category                 = string<br>      tags                         = list(string)<br>      include_datastores_with_tags = optional(bool)<br>    }))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_storage_policy"></a> [storage\_policy](#output\_storage\_policy) | n/a |
