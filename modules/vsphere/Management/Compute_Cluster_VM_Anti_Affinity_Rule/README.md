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
| [vsphere_compute_cluster_vm_anti_affinity_rule.anti_affinity_rule](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/compute_cluster_vm_anti_affinity_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_anti_affinity_rule"></a> [anti\_affinity\_rule](#input\_anti\_affinity\_rule) | n/a | <pre>map(object({<br>    compute_cluster_id  = string<br>    virtual_machine_ids = list(string)<br>    enabled             = optional(bool)<br>    mandatory           = optional(bool)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_affinity_rule"></a> [affinity\_rule](#output\_affinity\_rule) | n/a |
