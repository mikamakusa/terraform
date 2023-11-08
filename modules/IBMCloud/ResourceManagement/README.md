## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.6.2 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | 1.59.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | 1.59.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ibm_resource_group.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.59.0/docs/resources/resource_group) | resource |
| [ibm_resource_instance.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.59.0/docs/resources/resource_instance) | resource |
| [ibm_resource_key.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.59.0/docs/resources/resource_key) | resource |
| [ibm_resource_group.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.59.0/docs/data-sources/resource_group) | data source |
| [ibm_resource_instance.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.59.0/docs/data-sources/resource_instance) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | n/a | <pre>list(map(object({<br>    id   = number<br>    name = string<br>    tags = optional(list(s))<br>  })))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | `null` | no |
| <a name="input_resource_instance"></a> [resource\_instance](#input\_resource\_instance) | n/a | <pre>list(map(object({<br>    id                = number<br>    location          = string<br>    name              = string<br>    plan              = string<br>    service           = string<br>    parameters        = optional(map(string))<br>    parameters_json   = optional(string)<br>    resource_group_id = optional(any)<br>    tags              = optional(list(string))<br>    service_endpoints = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_resource_instance_name"></a> [resource\_instance\_name](#input\_resource\_instance\_name) | n/a | `string` | `null` | no |
| <a name="input_resource_key"></a> [resource\_key](#input\_resource\_key) | n/a | <pre>list(map(object({<br>    id                   = number<br>    name                 = string<br>    parameters           = optional(map(string))<br>    role                 = optional(string)<br>    resource_instance_id = any<br>    resource_alias_id    = optional(string)<br>    tags                 = optional(list(string))<br>  })))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | n/a |
| <a name="output_resource_instance"></a> [resource\_instance](#output\_resource\_instance) | n/a |
| <a name="output_resource_key"></a> [resource\_key](#output\_resource\_key) | n/a |
