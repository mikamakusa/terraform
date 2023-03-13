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
| [vsphere_compute_cluster.compute_cluster](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/compute_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster"></a> [cluster](#input\_cluster) | n/a | <pre>map(object({<br>    datacenter_id     = string<br>    folder            = optional(string)<br>    tags              = optional(list(string))<br>    custom_attributes = optional(map(string))<br>  }))</pre> | n/a | yes |
| <a name="input_dpm"></a> [dpm](#input\_dpm) | DPM - Distributed Power Management - configuration for this cluster | <pre>object({<br>    enabled          = optional(bool)<br>    automation_level = optional(string)<br>    threshold        = optional(number)<br>  })</pre> | `{}` | no |
| <a name="input_drs"></a> [drs](#input\_drs) | DRS configuration for this cluster | <pre>object({<br>    enabled                  = optional(bool)<br>    automation_level         = optional(string)<br>    migration_threshold      = optional(number)<br>    enable_vm_overrides      = optional(bool)<br>    enable_predictive_drs    = optional(bool)<br>    scale_descendants_shares = optional(bool)<br>    advanced_options         = optional(map(string))<br>  })</pre> | `{}` | no |
| <a name="input_ha"></a> [ha](#input\_ha) | n/a | <pre>object({<br>    enabled = optional(bool)<br>    host = optional(object({<br>      monitoring         = optional(string)<br>      isolation_response = optional(string)<br>    }))<br>    vm = optional(object({<br>      restart_priority             = optional(string)<br>      dependency_restart_condition = optional(string)<br>      restart_additional_delay     = optional(number)<br>      restart_timeout              = optional(number)<br>      isolation_response           = optional(string)<br>      component_protection         = optional(string)<br>      monitoring                   = optional(string)<br>      failure_interval             = optional(number)<br>      minimum_uptime               = optional(number)<br>      maximum_resets               = optional(number)<br>      maximum_failure_window       = optional(number)<br>      advanced_options             = optional(map(string))<br>    }))<br>    datastore = optional(object({<br>      pdl_response        = optional(string)<br>      apd_response        = optional(string)<br>      apd_recovery_action = optional(string)<br>      apd_response_delay  = optional(number)<br>    }))<br>    admission_control = optional(object({<br>      policy                           = optional(string)<br>      host_failure_tolerance           = optional(number)<br>      performance_tolerance            = optional(number)<br>      resource_percentage_auto_compute = optional(bool)<br>      resource_percentage_cpu          = optional(number)<br>      resource_percentage_memory       = optional(number)<br>      slot_policy_use_explicit_size    = optional(bool)<br>      slot_policy_explicit_cpu         = optional(number)<br>      slot_policy_explicit_memory      = optional(number)<br>      failover_host_system_ids         = optional(list(string))<br>    }))<br>    heartbeat = optional(object({<br>      datastore_ids    = optional(list(string))<br>      datastore_policy = optional(string)<br>    }))<br>  })</pre> | `{}` | no |
| <a name="input_host_management"></a> [host\_management](#input\_host\_management) | n/a | <pre>object({<br>    host_system_ids           = optional(list(string))<br>    host_managed              = optional(bool)<br>    host_cluster_exit_timeout = optional(number)<br>    force_evacuate_on_destroy = optional(bool)<br>  })</pre> | `{}` | no |
| <a name="input_proactive"></a> [proactive](#input\_proactive) | n/a | <pre>object({<br>    enabled                 = optional(bool)<br>    ha_automation_level     = optional(string)<br>    ha_moderate_remediation = optional(string)<br>    ha_severe_remediation   = optional(string)<br>    ha_provider_ids         = optional(list(string))<br>  })</pre> | `{}` | no |
| <a name="input_vsan"></a> [vsan](#input\_vsan) | n/a | <pre>object({<br>    enabled                         = optional(bool)<br>    dedup_enabled                   = optional(bool)<br>    compression_enabled             = optional(bool)<br>    performance_enabled             = optional(bool)<br>    verbose_mode_enabled            = optional(bool)<br>    network_diagnostic_mode_enabled = optional(bool)<br>    unmap_enabled                   = optional(bool)<br>    remote_datastore_ids            = optional(list(string))<br>    vsan_disk_group = optional(object({<br>      cache   = optional(string)<br>      storage = optional(map(string))<br>    }))<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vsphere_cluster"></a> [vsphere\_cluster](#output\_vsphere\_cluster) | n/a |
