## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vsphere"></a> [vsphere](#provider\_vsphere) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vsphere_tag.tag](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/tag) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tag"></a> [tag](#input\_tag) | n/a | <pre>map(object({<br>    category_id = string<br>    description = optional(string)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tag"></a> [tag](#output\_tag) | n/a |
