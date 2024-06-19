## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.54.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.54.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_prometheus_alert_manager_definition.this](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/prometheus_alert_manager_definition) | resource |
| [aws_prometheus_rule_group_namespace.this](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/prometheus_rule_group_namespace) | resource |
| [aws_prometheus_scraper.this](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/prometheus_scraper) | resource |
| [aws_prometheus_workspace.this](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/resources/prometheus_workspace) | resource |
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/data-sources/cloudwatch_log_group) | data source |
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/5.54.1/docs/data-sources/eks_cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_cluster_name"></a> [aks\_cluster\_name](#input\_aks\_cluster\_name) | n/a | `string` | `null` | no |
| <a name="input_alert_manager_definition"></a> [alert\_manager\_definition](#input\_alert\_manager\_definition) | n/a | <pre>list(object({<br>    id           = number<br>    definition   = string<br>    workspace_id = number<br>  }))</pre> | `[]` | no |
| <a name="input_cloudwatch_log_group"></a> [cloudwatch\_log\_group](#input\_cloudwatch\_log\_group) | n/a | `string` | `null` | no |
| <a name="input_rule_group_namespace"></a> [rule\_group\_namespace](#input\_rule\_group\_namespace) | n/a | <pre>list(object({<br>    id           = number<br>    data         = string<br>    name         = string<br>    workspace_id = number<br>  }))</pre> | `[]` | no |
| <a name="input_scraper"></a> [scraper](#input\_scraper) | n/a | <pre>list(object({<br>    id                   = number<br>    scrape_configuration = string<br>    alias                = optional(string)<br>    destination = list(object({<br>      amp = list(object({<br>        workspace_id = number<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_workspace"></a> [workspace](#input\_workspace) | n/a | <pre>list(object({<br>    id          = number<br>    alias       = optional(string)<br>    kms_key_arn = optional(string)<br>    tags        = optional(map(string))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alert_manager_definition"></a> [alert\_manager\_definition](#output\_alert\_manager\_definition) | n/a |
| <a name="output_prometheus_scraper"></a> [prometheus\_scraper](#output\_prometheus\_scraper) | n/a |
| <a name="output_prometheus_workspace"></a> [prometheus\_workspace](#output\_prometheus\_workspace) | n/a |
| <a name="output_rule_group_namespace"></a> [rule\_group\_namespace](#output\_rule\_group\_namespace) | n/a |
