## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.8.3 |
| <a name="requirement_openstack"></a> [openstack](#requirement\_openstack) | 1.54.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_openstack"></a> [openstack](#provider\_openstack) | 1.54.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [openstack_blockstorage_qos_association_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/blockstorage_qos_association_v3) | resource |
| [openstack_blockstorage_qos_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/blockstorage_qos_v3) | resource |
| [openstack_blockstorage_quotaset_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/blockstorage_quotaset_v3) | resource |
| [openstack_blockstorage_volume_attach_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/blockstorage_volume_attach_v3) | resource |
| [openstack_blockstorage_volume_type_access_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/blockstorage_volume_type_access_v3) | resource |
| [openstack_blockstorage_volume_type_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/blockstorage_volume_type_v3) | resource |
| [openstack_blockstorage_volume_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/blockstorage_volume_v3) | resource |
| [openstack_identity_project_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/data-sources/identity_project_v3) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_qos_association_v3"></a> [qos\_association\_v3](#input\_qos\_association\_v3) | n/a | <pre>list(object({<br>    id             = number<br>    qos_id         = number<br>    volume_type_id = number<br>  }))</pre> | `[]` | no |
| <a name="input_qos_v3"></a> [qos\_v3](#input\_qos\_v3) | n/a | <pre>list(object({<br>    id       = number<br>    name     = string<br>    consumer = optional(string)<br>    specs    = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_quotaset_v3"></a> [quotaset\_v3](#input\_quotaset\_v3) | n/a | <pre>list(object({<br>    id                   = number<br>    volumes              = optional(number)<br>    snapshots            = optional(number)<br>    gigabytes            = optional(number)<br>    per_volume_gigabytes = optional(number)<br>    backups              = optional(number)<br>    backup_gigabytes     = optional(number)<br>    groups               = optional(number)<br>    volume_type_quota    = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_volume_attach_v3"></a> [volume\_attach\_v3](#input\_volume\_attach\_v3) | n/a | <pre>list(object({<br>    id          = number<br>    host_name   = string<br>    volume_id   = number<br>    attach_mode = optional(string)<br>    device      = optional(string)<br>    initiator   = optional(string)<br>    ip_address  = optional(string)<br>    multipath   = optional(bool)<br>    os_type     = optional(string)<br>    platform    = optional(string)<br>    wwnn        = optional(string)<br>    wwpn        = optional(list(string))<br>  }))</pre> | `[]` | no |
| <a name="input_volume_type_access_v3"></a> [volume\_type\_access\_v3](#input\_volume\_type\_access\_v3) | n/a | <pre>list(object({<br>    id             = number<br>    volume_type_id = number<br>  }))</pre> | `[]` | no |
| <a name="input_volume_type_v3"></a> [volume\_type\_v3](#input\_volume\_type\_v3) | n/a | <pre>list(object({<br>    id          = number<br>    name        = string<br>    description = optional(string)<br>    is_public   = optional(bool)<br>    extra_specs = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_volume_v3"></a> [volume\_v3](#input\_volume\_v3) | n/a | <pre>list(object({<br>    id                   = number<br>    size                 = number<br>    enable_online_resize = optional(bool)<br>    availability_zone    = optional(string)<br>    consistency_group_id = optional(string)<br>    description          = optional(string)<br>    metadata             = optional(map(string))<br>    name                 = optional(string)<br>    source_replica       = optional(string)<br>    snapshot_id          = optional(string)<br>    source_vol_id        = optional(string)<br>    image_id             = optional(string)<br>    backup_id            = optional(string)<br>    volume_type          = optional(string)<br>    multiattach          = optional(bool)<br>    scheduler_hints = optional(list(object({<br>      different_host        = optional(list(string))<br>      same_host             = optional(list(string))<br>      local_to_instance     = optional(string)<br>      query                 = optional(string)<br>      additional_properties = optional(map(string))<br>    })), [])<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_qos_association"></a> [qos\_association](#output\_qos\_association) | n/a |
| <a name="output_quotaset"></a> [quotaset](#output\_quotaset) | n/a |
| <a name="output_volume_attach"></a> [volume\_attach](#output\_volume\_attach) | n/a |
| <a name="output_volume_id"></a> [volume\_id](#output\_volume\_id) | n/a |
| <a name="output_volume_type_access"></a> [volume\_type\_access](#output\_volume\_type\_access) | n/a |
