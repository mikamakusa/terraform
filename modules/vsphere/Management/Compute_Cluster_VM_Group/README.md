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
| [vsphere_compute_cluster_vm_group.vm_group](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/compute_cluster_vm_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vm_group"></a> [vm\_group](#input\_vm\_group) | n/a | <pre>map(object({<br>    compute_cluster_id = string<br>    virtual_machine_ids = optional(list(string))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vm_group"></a> [vm\_group](#output\_vm\_group) | n/a |
