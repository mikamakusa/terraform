## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | 1.211.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | 1.211.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_actiontrail.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/resources/actiontrail) | resource |
| [alicloud_actiontrail_global_events_storage_region.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/resources/actiontrail_global_events_storage_region) | resource |
| [alicloud_actiontrail_history_delivery_job.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/resources/actiontrail_history_delivery_job) | resource |
| [alicloud_actiontrail_trail.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/resources/actiontrail_trail) | resource |
| [alicloud_log_project.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/resources/log_project) | resource |
| [alicloud_mns_topic.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/resources/mns_topic) | resource |
| [alicloud_oss_bucket.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/resources/oss_bucket) | resource |
| [alicloud_ram_policy.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/resources/ram_policy) | resource |
| [alicloud_ram_role.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/resources/ram_role) | resource |
| [alicloud_ram_role_policy_attachment.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/resources/ram_role_policy_attachment) | resource |
| [alicloud_account.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/data-sources/account) | data source |
| [alicloud_log_projects.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/data-sources/log_projects) | data source |
| [alicloud_mns_topics.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/data-sources/mns_topics) | data source |
| [alicloud_oss_buckets.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/data-sources/oss_buckets) | data source |
| [alicloud_ram_roles.sls_role](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/data-sources/ram_roles) | data source |
| [alicloud_ram_roles.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/data-sources/ram_roles) | data source |
| [alicloud_regions.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_actiontrail"></a> [actiontrail](#input\_actiontrail) | n/a | <pre>list(map(object({<br>    id                 = number<br>    name               = string<br>    event_rw           = optional(string)<br>    oss_bucket_id      = optional(number)<br>    role_id            = optional(number)<br>    oss_key_prefix     = optional(string)<br>    sls_project_arn    = optional(string)<br>    sls_write_role_arn = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_buckets"></a> [buckets](#input\_buckets) | Name of the bucket used as datasource | `string` | `null` | no |
| <a name="input_delivery_job"></a> [delivery\_job](#input\_delivery\_job) | n/a | <pre>list(map(object({<br>    id       = number<br>    trail_id = number<br>  })))</pre> | `[]` | no |
| <a name="input_log_project"></a> [log\_project](#input\_log\_project) | n/a | `string` | `null` | no |
| <a name="input_log_projects"></a> [log\_projects](#input\_log\_projects) | n/a | <pre>list(map(object({<br>    id          = number<br>    name        = string<br>    description = optional(string)<br>    tags        = optional(map(string))<br>  })))</pre> | `[]` | no |
| <a name="input_mns_topics"></a> [mns\_topics](#input\_mns\_topics) | n/a | <pre>list(map(object({<br>    name                 = string<br>    maximum_message_size = optional(number, 0)<br>    logging_enabled      = optional(bool, true)<br>  })))</pre> | `{}` | no |
| <a name="input_oss_bucket"></a> [oss\_bucket](#input\_oss\_bucket) | n/a | <pre>list(map(object({<br>    id     = number<br>    bucket = string<br>    tags   = map(string)<br>  })))</pre> | `[]` | no |
| <a name="input_ram_policy"></a> [ram\_policy](#input\_ram\_policy) | policy\_name = string / Name of the RAM policy. This name can have a string of 1 to 128 characters, must contain only alphanumeric characters or hyphen "-", and must not begin with a hyphen.<br>statement = optional(list(object) / Statements of the RAM policy document.<br>  resource = list(string) / List of specific objects which will be authorized.<br>  action   = list(string) / List of operations for the resource.<br>  effect   = string / This parameter indicates whether or not the action is allowed. Valid values are Allow and Deny.<br>version         = optional(string) / Version of the RAM policy document. Valid value is 1. Default value is 1.<br>description     = optional(string) / Description of the RAM policy.<br>rotate\_strategy = optional(string) / The rotation strategy of the policy.<br>force           = optional(bool, false) / This parameter is used for resource destroy. | <pre>list(map(object({<br>    id          = number<br>    policy_name = string<br>    statement = optional(list(object({<br>      resource = list(string)<br>      action   = list(string)<br>      effect   = string<br>    })), [])<br>    version         = optional(string)<br>    description     = optional(string)<br>    rotate_strategy = optional(string)<br>    force           = optional(bool, false)<br>  })))</pre> | `[]` | no |
| <a name="input_ram_roles"></a> [ram\_roles](#input\_ram\_roles) | name                 = string / Name of the RAM role. This name can have a string of 1 to 64 characters, must contain only alphanumeric characters or hyphens, such as "-", "\_", and must not begin with a hyphen.<br>services             = optional(set(string)) / List of services which can assume the RAM role.<br>ram\_users            = optional(set(string)) / List of ram users who can assume the RAM role.<br>version              = optional(string) / Version of the RAM role policy document.<br>document             = optional(string) / Authorization strategy of the RAM role.<br>description          = optional(string) / Description of the RAM role.<br>force                = optional(bool, false) / This parameter is used for resource destroy.<br>max\_session\_duration = optional(number, 3600) / The maximum session duration of the RAM role. Valid values: 3600 to 43200. | <pre>list(map(object({<br>    id                   = number<br>    name                 = string<br>    services             = optional(set(string))<br>    ram_users            = optional(set(string))<br>    version              = optional(string)<br>    document             = optional(string)<br>    description          = optional(string)<br>    force                = optional(bool, false)<br>    max_session_duration = optional(number, 3600)<br>  })))</pre> | `[]` | no |
| <a name="input_role_policy_attachement"></a> [role\_policy\_attachement](#input\_role\_policy\_attachement) | n/a | <pre>list(map(object({<br>    id        = number<br>    policy_id = number<br>    role_id   = number<br>  })))</pre> | `[]` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | Name of the role used as datasource | `string` | `null` | no |
| <a name="input_storage_region"></a> [storage\_region](#input\_storage\_region) | n/a | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_topics"></a> [topics](#input\_topics) | n/a | `string` | `null` | no |
| <a name="input_trail"></a> [trail](#input\_trail) | n/a | <pre>list(map(object({<br>    id                    = number<br>    trail_id              = optional(number)<br>    name                  = optional(string)<br>    event_rw              = optional(string)<br>    oss_bucket_id         = optional(number)<br>    oss_key_prefix        = optional(string)<br>    role_name             = optional(number)<br>    sls_project_id        = optional(number)<br>    sls_write_role_arn    = optional(string)<br>    mns_topic_id          = optional(number)<br>    status                = optional(string)<br>    is_organization_trail = optional(bool, false)<br>  })))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_actiontrail_trails"></a> [actiontrail\_trails](#output\_actiontrail\_trails) | n/a |
| <a name="output_actiontrails"></a> [actiontrails](#output\_actiontrails) | n/a |
| <a name="output_global_events_storage_regions"></a> [global\_events\_storage\_regions](#output\_global\_events\_storage\_regions) | n/a |
| <a name="output_history_delivery_jons"></a> [history\_delivery\_jons](#output\_history\_delivery\_jons) | n/a |
| <a name="output_log_projects"></a> [log\_projects](#output\_log\_projects) | n/a |
| <a name="output_mns_topics"></a> [mns\_topics](#output\_mns\_topics) | n/a |
| <a name="output_policies"></a> [policies](#output\_policies) | n/a |
| <a name="output_policies_attachment"></a> [policies\_attachment](#output\_policies\_attachment) | n/a |
| <a name="output_roles"></a> [roles](#output\_roles) | n/a |
