## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.7.4 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | 5.39.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 5.39.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_cloud_bridge_agent.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/resources/cloud_bridge_agent) | resource |
| [oci_cloud_bridge_agent_dependency.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/resources/cloud_bridge_agent_dependency) | resource |
| [oci_cloud_bridge_agent_plugin.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/resources/cloud_bridge_agent_plugin) | resource |
| [oci_cloud_bridge_asset.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/resources/cloud_bridge_asset) | resource |
| [oci_cloud_bridge_asset_source.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/resources/cloud_bridge_asset_source) | resource |
| [oci_cloud_bridge_discovery_schedule.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/resources/cloud_bridge_discovery_schedule) | resource |
| [oci_cloud_bridge_environment.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/resources/cloud_bridge_environment) | resource |
| [oci_cloud_bridge_inventory.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/resources/cloud_bridge_inventory) | resource |
| [oci_identity_compartment.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/data-sources/identity_compartment) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent"></a> [agent](#input\_agent) | This resource provides the Agent resource in Oracle Cloud Infrastructure Cloud Bridge service. | <pre>list(map(object({<br>    id             = number<br>    agent_type     = string<br>    agent_version  = string<br>    display_name   = string<br>    environment_id = number<br>    os_version     = string<br>    defined_tags   = optional(map(string))<br>    freeform_tags  = optional(map(string))<br>  })))</pre> | `[]` | no |
| <a name="input_agent_dependency"></a> [agent\_dependency](#input\_agent\_dependency) | This resource provides the Agent Dependency resource in Oracle Cloud Infrastructure Cloud Bridge service. | <pre>list(map(object({<br>    id                 = number<br>    bucket             = string<br>    dependency_name    = string<br>    display_name       = string<br>    namespace          = string<br>    object             = string<br>    defined_tags       = optional(map(string))<br>    freeform_tags      = optional(map(string))<br>    dependency_version = optional(string)<br>    description        = optional(string)<br>    system_tags        = optional(map(string))<br>  })))</pre> | `[]` | no |
| <a name="input_agent_plugin"></a> [agent\_plugin](#input\_agent\_plugin) | This resource provides the Agent Plugin resource in Oracle Cloud Infrastructure Cloud Bridge service. | <pre>list(map(object({<br>    id            = number<br>    agent_id      = number<br>    plugin_name   = string<br>    desired_state = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_asset"></a> [asset](#input\_asset) | This resource provides the Asset resource in Oracle Cloud Infrastructure Cloud Bridge service. | <pre>list(map(object({<br>    id                 = number<br>    asset_type         = string<br>    external_asset_key = string<br>    inventory_id       = number<br>    source_key         = string<br>    asset_source_ids   = optional(list(string))<br>    defined_tags       = optional(map(string))<br>    freeform_tags      = optional(map(string))<br>    display_name       = optional(string)<br>    compute = optional(list(object({<br>      connected_networks         = optional(number)<br>      cores_count                = optional(number)<br>      cpu_model                  = optional(string)<br>      description                = optional(string)<br>      disks_count                = optional(number)<br>      dns_name                   = optional(string)<br>      firmware                   = optional(string)<br>      gpu_devices_count          = optional(number)<br>      guest_state                = optional(string)<br>      hardware_version           = optional(string)<br>      host_name                  = optional(string)<br>      is_pmem_enabled            = optional(bool)<br>      is_tpm_enabled             = optional(bool)<br>      latency_sensitivity        = optional(string)<br>      memory_in_mbs              = optional(string)<br>      nics_count                 = optional(number)<br>      operating_system           = optional(string)<br>      operating_system_version   = optional(string)<br>      pmem_in_mbs                = optional(string)<br>      power_state                = optional(string)<br>      primary_ip                 = optional(string)<br>      storage_provisioned_in_mbs = optional(string)<br>      threads_per_core_count     = optional(number)<br>      disks = optional(list(object({<br>        boot_order      = optional(number)<br>        location        = optional(string)<br>        name            = optional(string)<br>        persistent_mode = optional(string)<br>        size_in_mbs     = optional(string)<br>        uuid            = optional(string)<br>        uuid_lun        = optional(string)<br>      })), [])<br>      nvdimm_controller = optional(list(object({<br>        bus_number = optional(number)<br>        label      = optional(string)<br>      })), [])<br>      nvdimms = optional(list(object({<br>        controller_key = optional(number)<br>        label          = optional(string)<br>        unit_number    = optional(number)<br>      })), [])<br>      gpu_devices = optional(list(object({<br>        cores_count   = optional(number)<br>        description   = optional(string)<br>        manufacturer  = optional(string)<br>        memory_in_mbs = optional(string)<br>        name          = optional(string)<br>      })), [])<br>      nics = optional(list(object({<br>        ip_addresses     = optional(list(string))<br>        label            = optional(string)<br>        mac_address      = optional(string)<br>        mac_address_type = optional(string)<br>        network_name     = optional(string)<br>        switch_name      = optional(string)<br>      })), [])<br>      scsi_controller = optional(list(object({<br>        label       = optional(string)<br>        shared_bus  = optional(string)<br>        unit_number = optional(number)<br>      })), [])<br>    })), [])<br>    vm = optional(list(object({<br>      hypervisor_host    = optional(string)<br>      hypervisor_vendor  = optional(string)<br>      hypervisor_version = optional(string)<br>    })), [])<br>    vmware_vcenter = optional(list(object({<br>      data_center     = optional(string)<br>      vcenter_key     = optional(string)<br>      vcenter_version = optional(string)<br>    })), [])<br>    vmware_vm = optional(list(object({<br>      cluster                           = optional(string)<br>      customer_fields                   = optional(list(string))<br>      fault_tolerance_bandwidth         = optional(number)<br>      fault_tolerance_secondary_latency = optional(number)<br>      fault_tolerance_state             = optional(string)<br>      instance_uuid                     = optional(string)<br>      is_disks_cbt_enabled              = optional(bool)<br>      is_disks_uuid_enabled             = optional(bool)<br>      path                              = optional(string)<br>      vmware_tools_status               = optional(string)<br>      customer_tags = optional(list(object({<br>        description = optional(string)<br>        name        = optional(string)<br>      })), [])<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_asset_source"></a> [asset\_source](#input\_asset\_source) | This resource provides the Asset Source resource in Oracle Cloud Infrastructure Cloud Bridge service. | <pre>list(map(object({<br>    id                               = number<br>    assets_compartment_id            = string<br>    environment_id                   = number<br>    inventory_id                     = number<br>    type                             = string<br>    vcenter_endpoint                 = string<br>    are_historical_metrics_collected = optional(bool)<br>    are_realtime_metrics_collected   = optional(bool)<br>    defined_tags                     = optional(map(string))<br>    freeform_tags                    = optional(map(string))<br>    discovery_schedule_id            = optional(string)<br>    display_name                     = optional(string)<br>    system_tags                      = optional(map(string))<br>    discovery_credentials = list(object({<br>      secret_id = string<br>      type      = string<br>    }))<br>    replication_credentials = list(object({<br>      secret_id = string<br>      type      = string<br>    }))<br>  })))</pre> | `[]` | no |
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | This data source provides details about a specific Compartment resource in Oracle Cloud Infrastructure Identity service.<br>Gets the specified compartment's information. | `string` | n/a | yes |
| <a name="input_defined_tags"></a> [defined\_tags](#input\_defined\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_discovery_schedule"></a> [discovery\_schedule](#input\_discovery\_schedule) | This resource provides the Discovery Schedule resource in Oracle Cloud Infrastructure Cloud Bridge service. | <pre>list(map(object({<br>    id                    = number<br>    execution_recurrences = string<br>    defined_tags          = optional(map(string))<br>    freeform_tags         = optional(map(string))<br>    display_name          = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | This resource provides the Environment resource in Oracle Cloud Infrastructure Cloud Bridge service. | <pre>list(map(object({<br>    id            = number<br>    defined_tags  = optional(map(string))<br>    freeform_tags = optional(map(string))<br>    display_name  = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_freeform_tags"></a> [freeform\_tags](#input\_freeform\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_inventory"></a> [inventory](#input\_inventory) | This resource provides the Inventory resource in Oracle Cloud Infrastructure Cloud Bridge service. | <pre>list(map(object({<br>    id            = number<br>    defined_tags  = optional(map(string))<br>    freeform_tags = optional(map(string))<br>    display_name  = optional(string)<br>  })))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_agent"></a> [agent](#output\_agent) | n/a |
| <a name="output_asset"></a> [asset](#output\_asset) | n/a |
| <a name="output_discovery_schedule"></a> [discovery\_schedule](#output\_discovery\_schedule) | n/a |
| <a name="output_environment"></a> [environment](#output\_environment) | n/a |
| <a name="output_inventory"></a> [inventory](#output\_inventory) | n/a |