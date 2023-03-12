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
| [vsphere_compute_cluster_vm_dependency_rule.dependency_rule](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/compute_cluster_vm_dependency_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dependency_rule"></a> [dependency\_rule](#input\_dependency\_rule) | n/a | <pre>map(object({<br>    compute_cluster_id = string<br>    dependency_vm_group_name = string<br>    vm_group_name = string<br>    enabled = optional(bool)<br>    mandatory = optional(bool)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dependency_rule"></a> [dependency\_rule](#output\_dependency\_rule) | n/a |
