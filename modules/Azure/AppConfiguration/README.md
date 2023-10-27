## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.6.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.78.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.78.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_app_configuration.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/resources/app_configuration) | resource |
| [azurerm_app_configuration_feature.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/resources/app_configuration_feature) | resource |
| [azurerm_app_configuration_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/resources/app_configuration_key) | resource |
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/resources/key_vault_key) | resource |
| [azurerm_key_vault_secret.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/resources/key_vault_secret) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/resources/user_assigned_identity) | resource |
| [azurerm_client_config.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/data-sources/key_vault_key) | data source |
| [azurerm_key_vault_secret.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_management_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/data-sources/management_group) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/data-sources/resource_group) | data source |
| [azurerm_role_definition.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/data-sources/role_definition) | data source |
| [azurerm_user_assigned_identity.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/data-sources/user_assigned_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_configuration"></a> [app\_configuration](#input\_app\_configuration) | n/a | <pre>list(map(object({<br>    id                         = number<br>    location                   = string<br>    name                       = string<br>    resource_group_id          = number<br>    local_auth_enabled         = optional(bool, false)<br>    public_network_access      = optional(string)<br>    purge_protection_enabled   = optional(bool, false)<br>    sku                        = optional(string)<br>    soft_delete_retention_days = optional(number)<br>    identity = optional(list(object({<br>      type         = string<br>      identity_ids = list(number)<br>    })), [])<br>    encryption = optional(list(object({<br>      key_vault_key_id = optional(number)<br>    })), [])<br>    replica = optional(list(object({<br>      location = string<br>      name     = string<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_configuration_key"></a> [configuration\_key](#input\_configuration\_key) | n/a | <pre>list(map(object({<br>    id                     = number<br>    configuration_store_id = number<br>    key                    = string<br>    content_type           = optional(string)<br>    label                  = optional(string)<br>    value                  = optional(string)<br>    locked                 = optional(bool, false)<br>    type                   = optional(string)<br>    vault_key_id           = optional(number)<br>    tags                   = optional(map(string))<br>  })))</pre> | `[]` | no |
| <a name="input_feature"></a> [feature](#input\_feature) | n/a | <pre>list(map(object({<br>    id                      = number<br>    configuration_store_id  = number<br>    name                    = string<br>    description             = optional(string)<br>    key                     = optional(string)<br>    label                   = optional(string)<br>    locked                  = optional(bool, false)<br>    percentage_filter_value = optional(number)<br>    tags                    = optional(map(string))<br>    targeting_filter = optional(list(object({<br>      default_rollout_percentage = number<br>      users                      = optional(list(string))<br>      groups = optional(list(object({<br>        name               = string<br>        rollout_percentage = number<br>      })), [])<br>    })), [])<br>    timewindow_filter = optional(list(object({<br>      start = optional(string)<br>      end   = optional(string)<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_key"></a> [key](#input\_key) | n/a | <pre>list(map(object({<br>    id              = number<br>    key_opts        = list(string)<br>    key_type        = string<br>    key_vault_id    = number<br>    name            = string<br>    key_size        = optional(number)<br>    curve           = optional(string)<br>    not_before_date = optional(string)<br>    expiration_date = optional(string)<br>    tags            = optional(map(string))<br>    rotation_policy = optional(list(object({<br>      expire_after         = optional(string)<br>      notify_before_expiry = optional(string)<br>      time_after_creation  = optional(string)<br>      time_before_expiry   = optional(string)<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_key_vault"></a> [key\_vault](#input\_key\_vault) | n/a | <pre>list(map(object({<br>    id                              = number<br>    location                        = string<br>    name                            = string<br>    resource_group_id               = number<br>    sku_name                        = string<br>    enable_rbac_authorization       = optional(bool, false)<br>    enabled_for_deployment          = optional(bool, false)<br>    enabled_for_disk_encryption     = optional(bool, false)<br>    enabled_for_template_deployment = optional(bool, false)<br>    purge_protection_enabled        = optional(bool, false)<br>    public_network_access_enabled   = optional(bool, false)<br>    soft_delete_retention_days      = optional(number)<br>    tags                            = optional(map(string))<br>    contact = optional(list(object({<br>      email = string<br>      name  = optional(string)<br>      phone = optional(string)<br>    })), [])<br>    network_acls = optional(list(object({<br>      bypass                     = string<br>      default_action             = string<br>      ip_rules                   = optional(list(string))<br>      virtual_network_subnet_ids = optional(list(string))<br>    })), [])<br>    access_policy = optional(list(object({<br>      application_id          = optional(string)<br>      certificate_permissions = optional(list(string))<br>      key_permissions         = optional(list(string))<br>      secret_permissions      = optional(list(string))<br>      storage_permissions     = optional(list(string))<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_key_vault_access_policy"></a> [key\_vault\_access\_policy](#input\_key\_vault\_access\_policy) | n/a | <pre>list(map(object({<br>    id                      = number<br>    key_vault_id            = number<br>    application_id          = optional(string)<br>    certificate_permissions = optional(list(string))<br>    key_permissions         = optional(list(string))<br>    secret_permissions      = optional(list(string))<br>    storage_permissions     = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | n/a | `string` | `null` | no |
| <a name="input_management_group_name"></a> [management\_group\_name](#input\_management\_group\_name) | n/a | `string` | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | n/a | <pre>list(map(object({<br>    id       = number<br>    location = string<br>    name     = string<br>    tags     = optional(map(string))<br>  })))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | `null` | no |
| <a name="input_role_assignment"></a> [role\_assignment](#input\_role\_assignment) | n/a | <pre>list(map(object({<br>    id                               = number<br>    name                             = optional(string)<br>    condition                        = optional(string)<br>    condition_version                = optional(string)<br>    description                      = optional(string)<br>    skip_service_principal_aad_check = optional(bool, false)<br>  })))</pre> | `[]` | no |
| <a name="input_role_definition_name"></a> [role\_definition\_name](#input\_role\_definition\_name) | n/a | `string` | `null` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | n/a | <pre>list(map(object({<br>    id              = number<br>    key_vault_id    = number<br>    name            = string<br>    value           = string<br>    content_type    = string<br>    tags            = optional(list(string))<br>    not_before_date = optional(string)<br>    expiration_date = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_user_assigned_identity"></a> [user\_assigned\_identity](#input\_user\_assigned\_identity) | n/a | <pre>list(map(object({<br>    location          = string<br>    name              = string<br>    resource_group_id = number<br>    tags              = optional(map(string))<br>  })))</pre> | `[]` | no |
| <a name="input_user_assigned_identity_name"></a> [user\_assigned\_identity\_name](#input\_user\_assigned\_identity\_name) | n/a | `string` | `null` | no |
| <a name="input_vault_key_name"></a> [vault\_key\_name](#input\_vault\_key\_name) | n/a | `string` | `null` | no |
| <a name="input_vault_secret_name"></a> [vault\_secret\_name](#input\_vault\_secret\_name) | n/a | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_configuration"></a> [app\_configuration](#output\_app\_configuration) | n/a |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | n/a |
| <a name="output_vault"></a> [vault](#output\_vault) | n/a |
