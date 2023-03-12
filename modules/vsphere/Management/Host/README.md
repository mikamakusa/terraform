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
| [vsphere_host.host](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/host) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_host"></a> [host](#input\_host) | n/a | <pre>map(object({<br>    password        = string<br>    username        = string<br>    datacenter      = optional(string)<br>    cluster         = optional(string)<br>    cluster_managed = optional(string)<br>    thumbprint      = optional(string)<br>    license         = optional(string)<br>    force           = optional(bool)<br>    connected       = optional(bool)<br>    maintenance     = optional(bool)<br>    lockdown        = optional(bool)<br>    tags            = optional(list(string))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_host"></a> [host](#output\_host) | n/a |
