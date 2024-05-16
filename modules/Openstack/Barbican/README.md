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
| [openstack_keymanager_container_v1.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/keymanager_container_v1) | resource |
| [openstack_keymanager_order_v1.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/keymanager_order_v1) | resource |
| [openstack_keymanager_secret_v1.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/keymanager_secret_v1) | resource |
| [openstack_identity_project_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/data-sources/identity_project_v3) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_v1"></a> [container\_v1](#input\_container\_v1) | n/a | <pre>list(map(object({<br>    id   = number<br>    type = string<br>    name = optional(string)<br>    secret_refs = optional(list(object({<br>      secret_id = number<br>      name      = optional(string)<br>    })), [])<br>    acl = optional(list(object({<br>      read = optional(list(object({<br>        project_access = optional(bool)<br>        users          = optional(list(string))<br>      })), [])<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | n/a | `map(string)` | `{}` | no |
| <a name="input_order_v1"></a> [order\_v1](#input\_order\_v1) | n/a | <pre>list(map(object({<br>    id   = number<br>    type = string<br>    meta = list(object({<br>      algorithm            = string<br>      bit_length           = number<br>      expiration           = optional(string)<br>      mode                 = optional(string)<br>      payload_content_type = optional(string)<br>    }))<br>  })))</pre> | `[]` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_secret_v1"></a> [secret\_v1](#input\_secret\_v1) | n/a | <pre>list(map(object({<br>    id                       = number<br>    name                     = optional(string)<br>    bit_length               = optional(number)<br>    algorithm                = optional(string)<br>    mode                     = optional(string)<br>    secret_type              = optional(string)<br>    payload                  = optional(string)<br>    payload_content_encoding = optional(string)<br>    payload_content_type     = optional(string)<br>    expiration               = optional(string)<br>    metadata                 = optional(map(string))<br>    acl = optional(list(object({<br>      read = optional(list(object({<br>        project_access = optional(bool)<br>        users          = optional(list(string))<br>      })), [])<br>    })), [])<br>  })))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container"></a> [container](#output\_container) | n/a |
| <a name="output_order"></a> [order](#output\_order) | n/a |
| <a name="output_secret"></a> [secret](#output\_secret) | n/a |
