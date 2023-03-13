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
| [vsphere_content_library_item.item](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/content_library_item) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_item"></a> [item](#input\_item) | n/a | <pre>map(object({<br>    name        = string<br>    library_id  = string<br>    file_url    = optional(string)<br>    source_uuid = optional(string)<br>    description = optional(string)<br>    type        = optional(string)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_content_library_item"></a> [content\_library\_item](#output\_content\_library\_item) | n/a |
