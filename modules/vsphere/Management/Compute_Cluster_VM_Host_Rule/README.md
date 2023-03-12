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
| [vsphere_compute_cluster_vm_host_rule.host_rule](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/compute_cluster_vm_host_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_host_rule"></a> [host\_rule](#input\_host\_rule) | n/a | <pre>map(object({<br>    compute_cluster_id            = string<br>    vm_group_name                 = string<br>    affinity_host_group_name      = optional(string)<br>    anti_affinity_host_group_name = optional(string)<br>    enabled                       = optional(bool)<br>    mandatory                     = optional(bool)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_host_rule"></a> [host\_rule](#output\_host\_rule) | n/a |
