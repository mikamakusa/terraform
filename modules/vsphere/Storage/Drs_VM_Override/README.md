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
| [vsphere_storage_drs_vm_override.drs_vm_override](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/storage_drs_vm_override) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_drs_vm_overrides"></a> [drs\_vm\_overrides](#input\_drs\_vm\_overrides) | n/a | <pre>object({<br>    datastore_cluster_id   = string<br>    virtual_machine_id     = string<br>    sdrs_enabled           = optional(bool)<br>    sdrs_automation_level  = optional(string)<br>    sdrs_infra_vm_affinity = optional(string)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_drs_vm_override"></a> [drs\_vm\_override](#output\_drs\_vm\_override) | n/a |
