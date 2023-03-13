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
| [vsphere_folder.folder](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/folder) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_folder"></a> [folder](#input\_folder) | n/a | <pre>object({<br>    path              = string<br>    type              = string<br>    datacenter_id     = optional(string)<br>    tags              = optional(list(string))<br>    custom_attributes = optional(map(string))<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_folder"></a> [folder](#output\_folder) | n/a |
