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
| [vsphere_tag_category.tag_category](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/tag_category) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tag_category"></a> [tag\_category](#input\_tag\_category) | n/a | <pre>map(object({<br>    description      = optional(string)<br>    cardinality      = string<br>    associable_types = list(string)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tag_category"></a> [tag\_category](#output\_tag\_category) | n/a |
