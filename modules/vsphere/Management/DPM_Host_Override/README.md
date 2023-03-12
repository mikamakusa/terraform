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
| [vsphere_dpm_host_override.override](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/dpm_host_override) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_override"></a> [override](#input\_override) | n/a | <pre>object({<br>    compute_cluster_id   = string<br>    host_system_id       = string<br>    dpm_enabled          = optional(bool)<br>    dpm_automation_level = optional(string)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_override"></a> [override](#output\_override) | n/a |
