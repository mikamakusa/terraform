## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.6.2 |
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
| [alicloud_threat_detection_anti_brute_force_rule.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/resources/threat_detection_anti_brute_force_rule) | resource |
| [alicloud_threat_detection_backup_policy.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/resources/threat_detection_backup_policy) | resource |
| [alicloud_threat_detection_baseline_strategy.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/resources/threat_detection_baseline_strategy) | resource |
| [alicloud_threat_detection_honey_pot.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/resources/threat_detection_honey_pot) | resource |
| [alicloud_threat_detection_honeypot_node.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/resources/threat_detection_honeypot_node) | resource |
| [alicloud_threat_detection_honeypot_preset.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/resources/threat_detection_honeypot_preset) | resource |
| [alicloud_threat_detection_honeypot_probe.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/resources/threat_detection_honeypot_probe) | resource |
| [alicloud_threat_detection_instance.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/resources/threat_detection_instance) | resource |
| [alicloud_threat_detection_vul_whitelist.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/resources/threat_detection_vul_whitelist) | resource |
| [alicloud_threat_detection_web_lock_config.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/resources/threat_detection_web_lock_config) | resource |
| [alicloud_vpc.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/resources/vpc) | resource |
| [alicloud_threat_detection_assets.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/data-sources/threat_detection_assets) | data source |
| [alicloud_threat_detection_honeypot_images.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/data-sources/threat_detection_honeypot_images) | data source |
| [alicloud_vpcs.this](https://registry.terraform.io/providers/aliyun/alicloud/1.211.2/docs/data-sources/vpcs) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_anti_brute_force_rule"></a> [anti\_brute\_force\_rule](#input\_anti\_brute\_force\_rule) | n/a | <pre>list(map(object({<br>    id                         = number<br>    anti_brute_force_rule_name = optional(string)<br>    fail_count                 = optional(number)<br>    forbidden_time             = optional(number)<br>    span                       = optional(number)<br>    uuid_list                  = optional(list(string))<br>  })))</pre> | `[]` | no |
| <a name="input_assets"></a> [assets](#input\_assets) | n/a | `string` | `null` | no |
| <a name="input_backup_policy"></a> [backup\_policy](#input\_backup\_policy) | n/a | <pre>list(map(object({<br>    id                 = number<br>    backup_policy_name = optional(string)<br>    policy             = optional(string)<br>    policy_version     = optional(string)<br>    uuid_list          = optional(list(string))<br>    policy_region_id   = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_baseline_strategy"></a> [baseline\_strategy](#input\_baseline\_strategy) | n/a | <pre>list(map(object({<br>    id                     = number<br>    baseline_strategy_name = optional(string)<br>    custom_type            = optional(string)<br>    cycle_days             = optional(number)<br>    end_time               = optional(string)<br>    risk_sub_type_name     = optional(string)<br>    start_time             = optional(string)<br>    target_type            = optional(string)<br>    cycle_start_time       = optional(number)<br>  })))</pre> | `[]` | no |
| <a name="input_detection_instance"></a> [detection\_instance](#input\_detection\_instance) | n/a | <pre>list(map(object({<br>    id                     = number<br>    payment_type           = optional(string)<br>    version_code           = optional(string)<br>    modify_type            = optional(string)<br>    buy_number             = optional(string)<br>    container_image_scan   = optional(string)<br>    honeypot_id            = optional(number)<br>    honeypot_switch        = optional(string)<br>    period                 = optional(number)<br>    renew_period           = optional(number)<br>    renewal_status         = optional(string)<br>    renewal_period_unit    = optional(string)<br>    sas_anti_ransomware    = optional(string)<br>    sas_sc                 = optional(bool, false)<br>    sas_sdk                = optional(string)<br>    sas_sdk_switch         = optional(string)<br>    sas_webguard_boolean   = optional(string)<br>    sas_webguard_order_num = optional(string)<br>    threat_analysis        = optional(string)<br>    threat_analysis_switch = optional(string)<br>    v_core                 = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_honey_pot"></a> [honey\_pot](#input\_honey\_pot) | n/a | <pre>list(map(object({<br>    id                  = number<br>    honeypot_image_id   = optional(string)<br>    honeypot_image_name = optional(string)<br>    honeypot_name       = optional(string)<br>    node_id             = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_honeypot_images"></a> [honeypot\_images](#input\_honeypot\_images) | n/a | `string` | `null` | no |
| <a name="input_honeypot_node"></a> [honeypot\_node](#input\_honeypot\_node) | n/a | <pre>list(map(object({<br>    id                             = number<br>    available_probe_num            = optional(number)<br>    node_name                      = optional(string)<br>    allow_honeypot_access_internet = optional(bool, false)<br>    security_group_probe_ip_list   = optional(list(string))<br>  })))</pre> | `[]` | no |
| <a name="input_honeypot_preset"></a> [honeypot\_preset](#input\_honeypot\_preset) | n/a | <pre>list(map(object({<br>    id                  = number<br>    honeypot_image_name = optional(string)<br>    node_id             = optional(string)<br>    preset_name         = optional(string)<br>    meta = optional(list(object({<br>      burp            = optional(string)<br>      portrait_option = optional(bool, false)<br>      trojan_git      = optional(string)<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_honeypot_probe"></a> [honeypot\_probe](#input\_honeypot\_probe) | n/a | <pre>list(map(object({<br>    id              = number<br>    control_node_id = optional(string)<br>    display_name    = optional(string)<br>    probe_type      = optional(string)<br>    arp             = optional(bool, false)<br>    ping            = optional(bool, false)<br>    proxy_ip        = optional(string)<br>    probe_version   = optional(string)<br>    service_ip_list = optional(list(string))<br>    uuid            = optional(string)<br>    vpc_id          = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | map of strings which contains all the generic tags to apply on the resources. | `map(string)` | `{}` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | vpc\_name              = optional(string)<br>cidr\_block            = optional(string) / The CIDR block for the VPC.<br>classic\_link\_enabled  = optional(bool, false) / The status of ClassicLink function.<br>description           = optional(string) / The VPC description.<br>dry\_run               = optional(bool) / if optional(bool, false) : sends a check request and does not create a VPC.<br>enable\_ipv6           = optional(bool) / Whether to enable the IPv6 network segment.<br>ipv6\_isp              = optional(string) / The IPv6 address segment type of the VPC.<br>resource\_group\_id     = optional(string) / The ID of the resource group to which the VPC belongs.<br>tags                  = optional(map(string)) / The tags of Vpc.<br>user\_cidrs            = optional(list(string)) / A list of user CIDRs. | <pre>list(map(object({<br>    id                   = number<br>    vpc_name             = optional(string)<br>    cidr_block           = optional(string)<br>    classic_link_enabled = optional(bool, false)<br>    description          = optional(string)<br>    dry_run              = optional(bool, false)<br>    enable_ipv6          = optional(bool, false)<br>    ipv6_isp             = optional(string)<br>    resource_group_id    = optional(string)<br>    tags                 = optional(map(string))<br>    user_cidrs           = optional(list(string))<br>  })))</pre> | `[]` | no |
| <a name="input_vpcs"></a> [vpcs](#input\_vpcs) | Regex that match the VPC name to be used as datasource. | `string` | `null` | no |
| <a name="input_vul_whitelist"></a> [vul\_whitelist](#input\_vul\_whitelist) | n/a | <pre>list(map(object({<br>    id          = number<br>    whitelist   = optional(string)<br>    target_info = optional(string)<br>    reason      = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_web_lock_config"></a> [web\_lock\_config](#input\_web\_lock\_config) | n/a | <pre>list(map(object({<br>    id                  = number<br>    defence_mode        = optional(string)<br>    dir                 = optional(string)<br>    local_backup_dir    = optional(string)<br>    mode                = optional(string)<br>    uuid                = optional(string)<br>    exclusive_dir       = optional(string)<br>    exclusive_file      = optional(string)<br>    exclusive_file_type = optional(string)<br>    inclusive_file_type = optional(string)<br>  })))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_anti_brute_force_rule"></a> [anti\_brute\_force\_rule](#output\_anti\_brute\_force\_rule) | n/a |
| <a name="output_backup_policy"></a> [backup\_policy](#output\_backup\_policy) | n/a |
| <a name="output_baseline_strategy"></a> [baseline\_strategy](#output\_baseline\_strategy) | n/a |
| <a name="output_detection_instance"></a> [detection\_instance](#output\_detection\_instance) | n/a |
| <a name="output_honeypot"></a> [honeypot](#output\_honeypot) | n/a |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | n/a |
| <a name="output_vul_whitelist"></a> [vul\_whitelist](#output\_vul\_whitelist) | n/a |
| <a name="output_web_lock_config"></a> [web\_lock\_config](#output\_web\_lock\_config) | n/a |
