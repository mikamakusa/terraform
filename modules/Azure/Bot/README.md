## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.6.6 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.85.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.85.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_bot_channel_alexa.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.85.0/docs/resources/bot_channel_alexa) | resource |
| [azurerm_bot_channel_direct_line_speech.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.85.0/docs/resources/bot_channel_direct_line_speech) | resource |
| [azurerm_bot_channel_directline.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.85.0/docs/resources/bot_channel_directline) | resource |
| [azurerm_bot_channel_email.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.85.0/docs/resources/bot_channel_email) | resource |
| [azurerm_bot_channel_facebook.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.85.0/docs/resources/bot_channel_facebook) | resource |
| [azurerm_bot_channel_line.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.85.0/docs/resources/bot_channel_line) | resource |
| [azurerm_bot_channel_ms_teams.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.85.0/docs/resources/bot_channel_ms_teams) | resource |
| [azurerm_bot_channel_slack.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.85.0/docs/resources/bot_channel_slack) | resource |
| [azurerm_bot_channel_sms.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.85.0/docs/resources/bot_channel_sms) | resource |
| [azurerm_bot_channel_web_chat.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.85.0/docs/resources/bot_channel_web_chat) | resource |
| [azurerm_bot_channels_registration.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.85.0/docs/resources/bot_channels_registration) | resource |
| [azurerm_bot_connection.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.85.0/docs/resources/bot_connection) | resource |
| [azurerm_bot_service_azure_bot.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.85.0/docs/resources/bot_service_azure_bot) | resource |
| [azurerm_bot_web_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.85.0/docs/resources/bot_web_app) | resource |
| [azurerm_cognitive_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.85.0/docs/resources/cognitive_account) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.85.0/docs/data-sources/client_config) | data source |
| [azurerm_cognitive_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.85.0/docs/data-sources/cognitive_account) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.85.0/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alexa"></a> [alexa](#input\_alexa) | n/a | <pre>list(map(object({<br>    id              = number<br>    registration_id = number<br>    skill_id        = string<br>  })))</pre> | `[]` | no |
| <a name="input_azure_bot"></a> [azure\_bot](#input\_azure\_bot) | n/a | <pre>list(map(object({<br>    id                                    = number<br>    location                              = optional(string)<br>    microsoft_app_id                      = string<br>    name                                  = string<br>    sku                                   = string<br>    developer_app_insights_api_key        = optional(string)<br>    developer_app_insights_application_id = optional(string)<br>    developer_app_insights_key            = optional(string)<br>    display_name                          = optional(string)<br>    endpoint                              = optional(string)<br>    icon_url                              = optional(string)<br>    microsoft_app_msi_id                  = optional(string)<br>    microsoft_app_tenant_id               = optional(string)<br>    microsoft_app_type                    = optional(string)<br>    local_authentication_enabled          = optional(bool)<br>    luis_app_ids                          = optional(list(string))<br>    luis_key                              = optional(string)<br>    streaming_endpoint_enabled            = optional(bool)<br>    tags                                  = optional(map(string))<br>  })))</pre> | `[]` | no |
| <a name="input_bot_connection"></a> [bot\_connection](#input\_bot\_connection) | n/a | <pre>list(map(object({<br>    id                    = number<br>    registration_id       = number<br>    client_id             = string<br>    client_secret         = string<br>    name                  = string<br>    service_provider_name = string<br>    scopes                = optional(string)<br>    parameters            = optional(map(string))<br>  })))</pre> | `[]` | no |
| <a name="input_channel_line"></a> [channel\_line](#input\_channel\_line) | n/a | <pre>list(map(object({<br>    id              = number<br>    registration_id = number<br>    line_channel = list(object({<br>      access_token = string<br>      secret       = string<br>    }))<br>  })))</pre> | `[]` | no |
| <a name="input_cognitive_account"></a> [cognitive\_account](#input\_cognitive\_account) | n/a | <pre>list(map(object({<br>    id       = number<br>    kind     = string<br>    name     = string<br>    sku_name = string<br>  })))</pre> | `[]` | no |
| <a name="input_cognitive_account_name"></a> [cognitive\_account\_name](#input\_cognitive\_account\_name) | n/a | `string` | `null` | no |
| <a name="input_direct_line_speech"></a> [direct\_line\_speech](#input\_direct\_line\_speech) | n/a | <pre>list(map(object({<br>    id                         = number<br>    registration_id            = number<br>    cognitive_account_id       = optional(number)<br>    custom_speech_model_id     = optional(string)<br>    custom_voice_deployment_id = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_directline"></a> [directline](#input\_directline) | n/a | <pre>list(map(object({<br>    id              = number<br>    registration_id = number<br>  })))</pre> | `[]` | no |
| <a name="input_email"></a> [email](#input\_email) | n/a | <pre>list(map(object({<br>    id              = number<br>    registration_id = number<br>    email_address   = string<br>    email_password  = string<br>  })))</pre> | `[]` | no |
| <a name="input_facebook"></a> [facebook](#input\_facebook) | n/a | <pre>list(map(object({<br>    id                          = number<br>    registration_id             = number<br>    facebook_application_id     = string<br>    facebook_application_secret = string<br>  })))</pre> | `[]` | no |
| <a name="input_ms_teams"></a> [ms\_teams](#input\_ms\_teams) | n/a | <pre>list(map(object({<br>    id                     = number<br>    registration_id        = number<br>    calling_web_hook       = optional(string)<br>    deployment_environment = optional(string)<br>    enable_calling         = optional(bool)<br>  })))</pre> | `[]` | no |
| <a name="input_registration"></a> [registration](#input\_registration) | n/a | <pre>list(map(object({<br>    id                = number<br>    location          = optional(string)<br>    microsoft_app_id  = string<br>    name              = string<br>    sku               = string<br>    cmk_key_vault_url = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | n/a | `string` | n/a | yes |
| <a name="input_slack"></a> [slack](#input\_slack) | n/a | <pre>list(map(object({<br>    id                 = number<br>    registration_id    = number<br>    client_id          = string<br>    client_secret      = string<br>    verification_token = string<br>    landing_page_url   = optional(string)<br>    signing_secret     = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_sms"></a> [sms](#input\_sms) | n/a | <pre>list(map(object({<br>    id                              = number<br>    registration_id                 = number<br>    phone_number                    = string<br>    sms_channel_account_security_id = string<br>    sms_channel_auth_token          = string<br>  })))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_web_app"></a> [web\_app](#input\_web\_app) | n/a | <pre>list(map(object({<br>    id                                    = number<br>    microsoft_app_id                      = string<br>    name                                  = string<br>    resource_group_name                   = string<br>    sku                                   = string<br>    display_name                          = optional(string)<br>    endpoint                              = optional(string)<br>    developer_app_insights_api_key        = optional(string)<br>    developer_app_insights_application_id = optional(string)<br>    developer_app_insights_key            = optional(string)<br>    luis_app_ids                          = optional(list(string))<br>    luis_key                              = optional(string)<br>    tags                                  = optional(map(string))<br>  })))</pre> | `[]` | no |
| <a name="input_web_chat"></a> [web\_chat](#input\_web\_chat) | n/a | <pre>list(map(object({<br>    id              = number<br>    registration_id = number<br>    site = optional(list(object({<br>      name                        = string<br>      user_upload_enabled         = optional(bool)<br>      endpoint_parameters_enabled = optional(bool)<br>      storage_enabled             = optional(bool)<br>    })))<br>  })))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_bot"></a> [azure\_bot](#output\_azure\_bot) | n/a |
| <a name="output_channels"></a> [channels](#output\_channels) | n/a |
| <a name="output_connection"></a> [connection](#output\_connection) | n/a |
| <a name="output_registration"></a> [registration](#output\_registration) | n/a |
| <a name="output_web_app"></a> [web\_app](#output\_web\_app) | n/a |
