## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.7.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.42.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.42.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appconfig_application.this](https://registry.terraform.io/providers/hashicorp/aws/5.42.0/docs/resources/appconfig_application) | resource |
| [aws_appconfig_configuration_profile.this](https://registry.terraform.io/providers/hashicorp/aws/5.42.0/docs/resources/appconfig_configuration_profile) | resource |
| [aws_appconfig_deployment.this](https://registry.terraform.io/providers/hashicorp/aws/5.42.0/docs/resources/appconfig_deployment) | resource |
| [aws_appconfig_deployment_strategy.this](https://registry.terraform.io/providers/hashicorp/aws/5.42.0/docs/resources/appconfig_deployment_strategy) | resource |
| [aws_appconfig_environment.this](https://registry.terraform.io/providers/hashicorp/aws/5.42.0/docs/resources/appconfig_environment) | resource |
| [aws_appconfig_extension.this](https://registry.terraform.io/providers/hashicorp/aws/5.42.0/docs/resources/appconfig_extension) | resource |
| [aws_appconfig_extension_association.this](https://registry.terraform.io/providers/hashicorp/aws/5.42.0/docs/resources/appconfig_extension_association) | resource |
| [aws_appconfig_hosted_configuration_version.this](https://registry.terraform.io/providers/hashicorp/aws/5.42.0/docs/resources/appconfig_hosted_configuration_version) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application"></a> [application](#input\_application) | Provides an AppConfig Application resource. | <pre>list(map(object({<br>    id          = number<br>    name        = string<br>    description = optional(string)<br>    tags        = optional(map(string))<br>  })))</pre> | `[]` | no |
| <a name="input_configuration_profile"></a> [configuration\_profile](#input\_configuration\_profile) | Provides an AppConfig Configuration Profile resource. | <pre>list(map(object({<br>    id                 = number<br>    application_id     = number<br>    location_uri       = string<br>    name               = string<br>    description        = optional(string)<br>    retrieval_role_arn = optional(string)<br>    tags               = optional(map(string))<br>    type               = optional(string)<br>    validator = optional(list(object({<br>      type    = string<br>      content = optional(string)<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_deployment"></a> [deployment](#input\_deployment) | Provides an AppConfig Deployment resource for an aws\_appconfig\_application resource. | <pre>list(map(object({<br>    id                       = number<br>    application_id           = number<br>    configuration_profile_id = number<br>    configuration_version    = string<br>    deployment_strategy_id   = number<br>    environment_id           = number<br>    description              = optional(string)<br>    tags                     = optional(map(string))<br>  })))</pre> | `[]` | no |
| <a name="input_deployment_strategy"></a> [deployment\_strategy](#input\_deployment\_strategy) | Provides an AppConfig Deployment Strategy resource. | <pre>list(map(object({<br>    id                             = number<br>    deployment_duration_in_minutes = number<br>    growth_factor                  = number<br>    name                           = string<br>    replicate_to                   = string<br>    description                    = optional(string)<br>    final_bake_time_in_minutes     = optional(number)<br>    growth_type                    = optional(string)<br>    tags                           = optional(map(string))<br>  })))</pre> | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Provides an AppConfig Environment resource for an aws\_appconfig\_application resource. One or more environments can be defined for an application. | <pre>list(map(object({<br>    id             = number<br>    application_id = number<br>    name           = string<br>    description    = optional(string)<br>    tags           = optional(map(string))<br>    monitor = optional(list(object({<br>      alarm_arn      = string<br>      alarm_role_arn = optional(string)<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_extension"></a> [extension](#input\_extension) | Provides an AppConfig Extension resource. | <pre>list(map(object({<br>    id          = number<br>    name        = string<br>    description = optional(string)<br>    tags        = optional(map(string))<br>    action_point = list(object({<br>      point = string<br>      action = list(object({<br>        name     = string<br>        role_arn = string<br>        uri      = string<br>      }))<br>    }))<br>    parameter = optional(list(object({<br>      name        = string<br>      required    = optional(bool)<br>      description = optional(string)<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_extension_association"></a> [extension\_association](#input\_extension\_association) | Associates an AppConfig Extension with a Resource. | <pre>list(map(object({<br>    id           = number<br>    extension_id = number<br>    resource_id  = number<br>    parameters   = optional(map(string))<br>  })))</pre> | `[]` | no |
| <a name="input_hosted_configuration_version"></a> [hosted\_configuration\_version](#input\_hosted\_configuration\_version) | Provides an AppConfig Hosted Configuration Version resource. | <pre>list(map(object({<br>    id                       = number<br>    application_id           = number<br>    configuration_profile_id = number<br>    content                  = string<br>    content_type             = string<br>    description              = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_id"></a> [application\_id](#output\_application\_id) | n/a |
| <a name="output_configuration_profile_id"></a> [configuration\_profile\_id](#output\_configuration\_profile\_id) | n/a |
| <a name="output_deployment"></a> [deployment](#output\_deployment) | n/a |
| <a name="output_environment_id"></a> [environment\_id](#output\_environment\_id) | n/a |
| <a name="output_extension_id"></a> [extension\_id](#output\_extension\_id) | n/a |
