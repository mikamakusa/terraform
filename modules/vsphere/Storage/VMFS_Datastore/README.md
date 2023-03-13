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
| [vsphere_vmfs_datastore.vmfs_datastore](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/vmfs_datastore) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vmfs_datastore"></a> [vmfs\_datastore](#input\_vmfs\_datastore) | n/a | <pre>map(object({<br>    disks = string<br>    host_system_id = string<br>    folder = optional(string)<br>    datastore_cluster_id = optional(string)<br>    tags = optional(list(string))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vmfs_datastore"></a> [vmfs\_datastore](#output\_vmfs\_datastore) | n/a |
