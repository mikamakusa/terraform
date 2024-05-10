## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.8.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.49.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.49.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_detective_graph.this](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/detective_graph) | resource |
| [aws_detective_invitation_accepter.this](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/detective_invitation_accepter) | resource |
| [aws_detective_member.this](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/detective_member) | resource |
| [aws_detective_organization_admin_account.this](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/detective_organization_admin_account) | resource |
| [aws_detective_organization_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/detective_organization_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_graph"></a> [graph](#input\_graph) | Provides a resource to manage an AWS Detective Graph.<br>The following arguments are optional:<br>tags - (Optional) A map of tags to assign to the instance. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | <pre>list(map(object({<br>    id   = number<br>    tags = optional(map(string))<br>  })))</pre> | `[]` | no |
| <a name="input_invitation_accepter"></a> [invitation\_accepter](#input\_invitation\_accepter) | Provides a resource to manage an Amazon Detective Invitation Accepter.<br>This resource supports the following arguments:<br>graph\_arn - (Required) ARN of the behavior graph that the member account is accepting the invitation for. | <pre>list(map(object({<br>    id       = number<br>    graph_id = number<br>  })))</pre> | `[]` | no |
| <a name="input_member"></a> [member](#input\_member) | Provides a resource to manage an Amazon Detective Member.<br>This resource supports the following arguments:<br>account\_id - (Required) AWS account ID for the account.<br>email\_address - (Required) Email address for the account.<br>graph\_arn - (Required) ARN of the behavior graph to invite the member accounts to contribute their data to.<br>message - (Optional) A custom message to include in the invitation. Amazon Detective adds this message to the standard content that it sends for an invitation.<br>disable\_email\_notification - (Optional) If set to true, then the root user of the invited account will not receive an email notification. This notification is in addition to an alert that the root user receives in AWS Personal Health Dashboard. By default, this is set to false. | <pre>list(map(object({<br>    id                         = number<br>    account_id                 = string<br>    email_address              = string<br>    graph_id                   = number<br>    message                    = optional(string)<br>    disable_email_notification = optional(bool)<br>  })))</pre> | `[]` | no |
| <a name="input_organization_admin_account"></a> [organization\_admin\_account](#input\_organization\_admin\_account) | Manages a Detective Organization Admin Account.<br>The following arguments are supported:<br>account\_id - (Required) AWS account identifier to designate as a delegated administrator for Detective. | <pre>list(map(object({<br>    id         = number<br>    account_id = string<br>  })))</pre> | `[]` | no |
| <a name="input_organization_configuration"></a> [organization\_configuration](#input\_organization\_configuration) | Manages the Detective Organization Configuration in the current AWS Region.<br>The following arguments are supported:<br>auto\_enable - (Required) When this setting is enabled, all new accounts that are created in, or added to, the organization are added as a member accounts of the organization’s Detective delegated administrator and Detective is enabled in that AWS Region.<br>graph\_arn - (Required) ARN of the behavior graph. | <pre>list(map(object({<br>    id          = number<br>    auto_enable = bool<br>    graph_id    = number<br>  })))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_graph"></a> [graph](#output\_graph) | n/a |
| <a name="output_invitation_accepter"></a> [invitation\_accepter](#output\_invitation\_accepter) | n/a |
| <a name="output_member"></a> [member](#output\_member) | n/a |
| <a name="output_organization_admin_account"></a> [organization\_admin\_account](#output\_organization\_admin\_account) | n/a |
| <a name="output_organization_configuration"></a> [organization\_configuration](#output\_organization\_configuration) | n/a |
