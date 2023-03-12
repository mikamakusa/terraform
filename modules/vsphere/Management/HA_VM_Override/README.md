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
| [vsphere_ha_vm_override.override](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/ha_vm_override) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compute_cluster_id"></a> [compute\_cluster\_id](#input\_compute\_cluster\_id) | n/a | `string` | n/a | yes |
| <a name="input_general_ha"></a> [general\_ha](#input\_general\_ha) | n/a | <pre>object({<br>    ha_vm_restart_priority     = optional(string)<br>    ha_vm_restart_timeout      = optional(string)<br>    ha_host_isolation_response = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_ha_virtual_machine"></a> [ha\_virtual\_machine](#input\_ha\_virtual\_machine) | n/a | <pre>object({<br>    ha_datastore_pdl_response        = optional(string)<br>    ha_datastore_apd_response_delay  = optional(string)<br>    ha_datastore_apd_response        = optional(string)<br>    ha_datastore_apd_recovery_action = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_monitoring_settings"></a> [monitoring\_settings](#input\_monitoring\_settings) | n/a | <pre>object({<br>    ha_vm_monitoring                      = optional(string)<br>    ha_vm_monitoring_use_cluster_defaults = optional(bool)<br>    ha_vm_failure_interval                = optional(number)<br>    ha_vm_minimum_uptime                  = optional(number)<br>    ha_vm_maximum_resets                  = optional(number)<br>    ha_vm_maximum_failure_window          = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_virtual_machine_id"></a> [virtual\_machine\_id](#input\_virtual\_machine\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_override"></a> [override](#output\_override) | n/a |
