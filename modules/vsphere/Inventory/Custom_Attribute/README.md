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
| [vsphere_custom_attribute.custom_attribute](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/custom_attribute) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_attribute"></a> [custom\_attribute](#input\_custom\_attribute) | n/a | <pre>map(object({<br>    managed_object_type = optional(string)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom_attribute"></a> [custom\_attribute](#output\_custom\_attribute) | n/a |
