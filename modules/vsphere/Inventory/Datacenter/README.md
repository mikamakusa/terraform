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
| [vsphere_datacenter.datacenter](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/datacenter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_datacenter"></a> [datacenter](#input\_datacenter) | n/a | <pre>map(object({<br>    folder = optional(string)<br>    tags = optional(list(string))<br>    custom_attributes = optional(map(string))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_datacenter"></a> [datacenter](#output\_datacenter) | n/a |
