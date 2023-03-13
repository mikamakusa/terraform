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
| [vsphere_file.file](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_directories"></a> [create\_directories](#input\_create\_directories) | n/a | `bool` | `false` | no |
| <a name="input_datacenter"></a> [datacenter](#input\_datacenter) | n/a | `string` | `null` | no |
| <a name="input_datastore"></a> [datastore](#input\_datastore) | n/a | `string` | n/a | yes |
| <a name="input_destination_file"></a> [destination\_file](#input\_destination\_file) | n/a | `string` | n/a | yes |
| <a name="input_source_datacenter"></a> [source\_datacenter](#input\_source\_datacenter) | n/a | `string` | `null` | no |
| <a name="input_source_datastore"></a> [source\_datastore](#input\_source\_datastore) | n/a | `string` | `null` | no |
| <a name="input_source_file"></a> [source\_file](#input\_source\_file) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_file"></a> [file](#output\_file) | n/a |
