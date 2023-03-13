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
| [vsphere_nas_datastore.nas_datastore](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/nas_datastore) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_nas_datastore"></a> [nas\_datastore](#input\_nas\_datastore) | n/a | <pre>map(object({<br>    host_system_ids      = list(string)<br>    remote_hosts         = list(string)<br>    remote_path          = string<br>    type                 = optional(string)<br>    access_mode          = optional(string)<br>    security_type        = optional(string)<br>    folder               = optional(string)<br>    datastore_cluster_id = optional(string)<br>    tags                 = optional(list(string))<br>    custom_attributes    = optional(map(string))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nas_datastore"></a> [nas\_datastore](#output\_nas\_datastore) | n/a |
