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
| [ibm_app_config_collection.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.59.0/docs/resources/app_config_collection) | resource |
| [ibm_app_config_environment.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.59.0/docs/resources/app_config_environment) | resource |
| [ibm_app_config_feature.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.59.0/docs/resources/app_config_feature) | resource |
| [ibm_app_config_property.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.59.0/docs/resources/app_config_property) | resource |
| [ibm_app_config_segment.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.59.0/docs/resources/app_config_segment) | resource |
| [ibm_app_config_snapshot.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.59.0/docs/resources/app_config_snapshot) | resource |
| [ibm_app_config_collection.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.59.0/docs/data-sources/app_config_collection) | data source |
| [ibm_app_config_environment.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.59.0/docs/data-sources/app_config_environment) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_collection"></a> [collection](#input\_collection) | n/a | <pre>list(map(object({<br>    id            = number<br>    collection_id = string<br>    guid          = string<br>    name          = string<br>    description   = optional(string)<br>    tags          = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_collection_id"></a> [collection\_id](#input\_collection\_id) | n/a | <pre>object({<br>    collection = string<br>    guid       = string<br>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | <pre>list(map(object({<br>    id             = number<br>    environment_id = string<br>    guid           = string<br>    name           = string<br>    description    = optional(string)<br>    tags           = optional(string)<br>    color_code     = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_environment_id"></a> [environment\_id](#input\_environment\_id) | n/a | <pre>object({<br>    environment = string<br>    guid        = string<br>  })</pre> | `null` | no |
| <a name="input_feature"></a> [feature](#input\_feature) | n/a | <pre>list(map(object({<br>    id                 = number<br>    disabled_value     = string<br>    enabled_value      = string<br>    environment_id     = any<br>    feature_id         = string<br>    guid               = string<br>    name               = string<br>    type               = string<br>    description        = optional(string)<br>    tags               = optional(string)<br>    rollout_percentage = optional(number)<br>    segment_rules = optional(list(object({<br>      order              = number<br>      value              = string<br>      rollout_percentage = optional(number)<br>      rules = optional(list(object({<br>        segments = list(string)<br>      })), [])<br>    })), [])<br>    collections = optional(list(object({<br>      collection_id = any<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_property"></a> [property](#input\_property) | n/a | <pre>list(map(object({<br>    id             = number<br>    environment_id = any<br>    guid           = string<br>    name           = string<br>    property_id    = string<br>    type           = string<br>    value          = string<br>    description    = optional(string)<br>    tags           = optional(string)<br>    format         = optional(string)<br>    segment_rules = optional(list(object({<br>      order              = number<br>      value              = string<br>      rollout_percentage = optional(number)<br>      rules = optional(list(object({<br>        segments = list(string)<br>      })), [])<br>    })), [])<br>    collections = optional(list(object({<br>      collection_id = any<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_segment"></a> [segment](#input\_segment) | n/a | <pre>list(map(object({<br>    id          = number<br>    guid        = string<br>    name        = string<br>    segment_id  = string<br>    description = optional(string)<br>    tags        = optional(string)<br>    rules = optional(list(object({<br>      attribute_name = string<br>      operator       = string<br>      values         = list(string)<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_snapshot"></a> [snapshot](#input\_snapshot) | n/a | <pre>list(map(object({<br>    id              = number<br>    collection_id   = any<br>    environment_id  = any<br>    git_branch      = string<br>    git_config_id   = string<br>    git_config_name = string<br>    git_file_path   = string<br>    git_token       = string<br>    git_url         = string<br>    guid            = string<br>  })))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_config_collection"></a> [app\_config\_collection](#output\_app\_config\_collection) | n/a |
| <a name="output_app_config_environment"></a> [app\_config\_environment](#output\_app\_config\_environment) | n/a |
| <a name="output_app_config_feature"></a> [app\_config\_feature](#output\_app\_config\_feature) | n/a |
| <a name="output_app_config_property"></a> [app\_config\_property](#output\_app\_config\_property) | n/a |
| <a name="output_app_config_segment"></a> [app\_config\_segment](#output\_app\_config\_segment) | n/a |
| <a name="output_app_config_snapshot"></a> [app\_config\_snapshot](#output\_app\_config\_snapshot) | n/a |
