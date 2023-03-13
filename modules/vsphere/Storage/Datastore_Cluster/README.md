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
| [vsphere_datastore_cluster.datastore_cluster](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/datastore_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_datastore_cluster"></a> [datastore\_cluster](#input\_datastore\_cluster) | n/a | <pre>map(object({<br>    datacenter_id     = string<br>    folder            = optional(string)<br>    tags              = optional(list(string))<br>    custom_attributes = optional(map(string))<br>  }))</pre> | n/a | yes |
| <a name="input_sdrs"></a> [sdrs](#input\_sdrs) | n/a | <pre>object({<br>    enabled                                  = optional(bool)<br>    automation_level                    = optional(string)<br>    default_intra_vm_affinity           = optional(string)<br>    free_space_threshold                = optional(number)<br>    free_space_threshold_mode           = optional(string)<br>    free_space_utilization_difference   = optional(number)<br>    io_balance_automation_level         = optional(string)<br>    io_latency_threshold                = optional(number)<br>    io_load_balance_enabled             = optional(bool)<br>    io_load_imbalance_threshold         = optional(number)<br>    io_reservable_iops_threshold        = optional(number)<br>    io_reservable_percent_threshold     = optional(number)<br>    io_reservable_threshold_mode        = optional(string)<br>    load_balance_interval               = optional(number)<br>    policy_enforcement_automation_level = optional(string)<br>    rule_enforcement_automation_level   = optional(string)<br>    space_balance_automation_level      = optional(string)<br>    space_utilization_threshold         = optional(number)<br>    vm_evacuation_automation_level      = optional(string)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_datastore_cluster"></a> [datastore\_cluster](#output\_datastore\_cluster) | n/a |
