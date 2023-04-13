## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.62.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.62.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_xray_encryption_config.encryption_config](https://registry.terraform.io/providers/hashicorp/aws/4.62.0/docs/resources/xray_encryption_config) | resource |
| [aws_xray_group.xray_group](https://registry.terraform.io/providers/hashicorp/aws/4.62.0/docs/resources/xray_group) | resource |
| [aws_xray_sampling_rule.sampling_rule](https://registry.terraform.io/providers/hashicorp/aws/4.62.0/docs/resources/xray_sampling_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_encryption_config"></a> [encryption\_config](#input\_encryption\_config) | Creates and manages an AWS XRay Encryption Config. | <pre>list(object({<br>    type   = string<br>    key_id = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_sampling_rule"></a> [sampling\_rule](#input\_sampling\_rule) | Creates and manages an AWS XRay Sampling Rule. | <pre>map(object({<br>    priority       = number<br>    version        = number<br>    reservoir_size = number<br>    fixed_rate     = number<br>    url_path       = string<br>    host           = string<br>    http_method    = string<br>    service_type   = string<br>    service_name   = string<br>    resource_arn   = string<br>    attirbutes     = optional(map(string))<br>    tags           = optional(map(string))<br>  }))</pre> | `{}` | no |
| <a name="input_xray_group"></a> [xray\_group](#input\_xray\_group) | Creates and manages an AWS XRay Group. | <pre>map(object({<br>    filter_expression = string<br>    insight_configuration = optional(list(object({<br>      insights_enabled      = optional(bool)<br>      notifications_enabled = optional(bool)<br>    })))<br>    tags = optional(map(string))<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_xray"></a> [xray](#output\_xray) | n/a |
