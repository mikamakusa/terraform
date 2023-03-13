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
| [vsphere_virtual_disk.disk](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/virtual_disk) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_disk"></a> [disk](#input\_disk) | n/a | <pre>map(object({<br>    vmdk_path          = string<br>    datastore          = string<br>    size               = number<br>    datacenter         = optional(string)<br>    type               = optional(string)<br>    create_directories = optional(bool)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_disk"></a> [disk](#output\_disk) | n/a |
