## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.6.2 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 2.45.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.78.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.45.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.78.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/resources/role_assignment) | resource |
| [azurerm_role_definition.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/resources/role_definition) | resource |
| [azurerm_virtual_desktop_application.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/resources/virtual_desktop_application) | resource |
| [azurerm_virtual_desktop_application_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/resources/virtual_desktop_application_group) | resource |
| [azurerm_virtual_desktop_host_pool.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/resources/virtual_desktop_host_pool) | resource |
| [azurerm_virtual_desktop_host_pool_registration_info.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/resources/virtual_desktop_host_pool_registration_info) | resource |
| [azurerm_virtual_desktop_scaling_plan.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/resources/virtual_desktop_scaling_plan) | resource |
| [azurerm_virtual_desktop_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/resources/virtual_desktop_workspace) | resource |
| [azurerm_virtual_desktop_workspace_application_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/resources/virtual_desktop_workspace_application_group_association) | resource |
| [azuread_service_principal.this](https://registry.terraform.io/providers/hashicorp/azuread/2.45.0/docs/data-sources/service_principal) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/data-sources/resource_group) | data source |
| [azurerm_role_definition.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/data-sources/role_definition) | data source |
| [azurerm_virtual_desktop_host_pool.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.78.0/docs/data-sources/virtual_desktop_host_pool) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_group"></a> [application\_group](#input\_application\_group) | n/a | <pre>list(map(object({<br>    id                           = number<br>    host_pool_id                 = number<br>    name                         = string<br>    resource_group_id            = number<br>    type                         = string<br>    friendly_name                = optional(string)<br>    default_desktop_display_name = optional(string)<br>    description                  = optional(string)<br>    tags                         = optional(map(string))<br>  })))</pre> | `[]` | no |
| <a name="input_desktop_application"></a> [desktop\_application](#input\_desktop\_application) | n/a | <pre>list(map(object({<br>    id                           = number<br>    application_group_id         = string<br>    command_line_argument_policy = string<br>    name                         = string<br>    path                         = string<br>    friendly_name                = optional(string)<br>    description                  = optional(string)<br>    command_line_arguments       = optional(string)<br>    show_in_portal               = optional(bool, false)<br>    icon_path                    = optional(string)<br>    icon_index                   = optional(number)<br>  })))</pre> | `[]` | no |
| <a name="input_desktop_workspace"></a> [desktop\_workspace](#input\_desktop\_workspace) | n/a | <pre>list(map(object({<br>    id                            = number<br>    name                          = string<br>    resource_group_id             = number<br>    friendly_name                 = optional(string)<br>    description                   = optional(string)<br>    public_network_access_enabled = optional(bool, false)<br>    tags                          = optional(map(string))<br>  })))</pre> | `[]` | no |
| <a name="input_group_association"></a> [group\_association](#input\_group\_association) | n/a | <pre>list(map(object({<br>    id                   = number<br>    application_group_id = number<br>    workspace_id         = number<br>  })))</pre> | `[]` | no |
| <a name="input_host_pool"></a> [host\_pool](#input\_host\_pool) | n/a | <pre>list(map(object({<br>    id                               = number<br>    load_balancer_type               = string<br>    name                             = string<br>    resource_group_id                = string<br>    type                             = string<br>    friendly_name                    = optional(string)<br>    description                      = optional(string)<br>    validate_environment             = optional(bool, false)<br>    start_vm_on_connect              = optional(bool, false)<br>    custom_rdp_properties            = optional(string)<br>    personal_desktop_assignment_type = optional(string)<br>    maximum_sessions_allowed         = optional(number)<br>    preferred_app_group_type         = optional(string)<br>    tags                             = optional(map(string))<br>    scheduled_agent_updates = optional(list(object({<br>      enabled                   = optional(bool, false)<br>      timezone                  = optional(string)<br>      use_session_host_timezone = optional(bool, false)<br>      schedule = optional(list(object({<br>        day_of_week = string<br>        hour_of_day = number<br>      })), [])<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_host_pool_name"></a> [host\_pool\_name](#input\_host\_pool\_name) | n/a | `string` | `null` | no |
| <a name="input_registration_info"></a> [registration\_info](#input\_registration\_info) | n/a | <pre>list(map(object({<br>    id           = number<br>    host_pool_id = number<br>  })))</pre> | `[]` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | n/a | <pre>list(map(object({<br>    id       = number<br>    location = string<br>    name     = string<br>    tags     = optional(map(string))<br>  })))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | `null` | no |
| <a name="input_role_assignment"></a> [role\_assignment](#input\_role\_assignment) | n/a | <pre>list(map(object({<br>    id = number<br>    resource_group_id = number<br><br>  })))</pre> | `[]` | no |
| <a name="input_role_assignment_name"></a> [role\_assignment\_name](#input\_role\_assignment\_name) | n/a | `string` | `null` | no |
| <a name="input_scaling_plan"></a> [scaling\_plan](#input\_scaling\_plan) | n/a | <pre>list(map(object({<br>    id                = number<br>    name              = string<br>    resource_group_id = number<br>    time_zone         = string<br>    description       = optional(string)<br>    exclusion_tag     = optional(string)<br>    friendly_name     = optional(string)<br>    tags              = optional(map(string))<br>    host_pool = optional(list(object({<br>      hostpool_id          = number<br>      scaling_plan_enabled = bool<br>    })), [])<br>    schedule = optional(list(object({<br>      days_of_week                         = list(string)<br>      name                                 = string<br>      off_peak_load_balancing_algorithm    = string<br>      off_peak_start_time                  = string<br>      peak_load_balancing_algorithm        = string<br>      peak_start_time                      = string<br>      ramp_down_capacity_threshold_percent = number<br>      ramp_down_force_logoff_users         = bool<br>      ramp_down_load_balancing_algorithm   = string<br>      ramp_down_minimum_hosts_percent      = number<br>      ramp_down_notification_message       = string<br>      ramp_down_start_time                 = string<br>      ramp_down_stop_hosts_when            = string<br>      ramp_down_wait_time_minutes          = number<br>      ramp_up_load_balancing_algorithm     = string<br>      ramp_up_start_time                   = string<br>      ramp_up_capacity_threshold_percent   = optional(number)<br>      ramp_up_minimum_hosts_percent        = optional(number)<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_service_principal"></a> [service\_principal](#input\_service\_principal) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application"></a> [application](#output\_application) | n/a |
| <a name="output_application_group"></a> [application\_group](#output\_application\_group) | n/a |
| <a name="output_desktop_workspace"></a> [desktop\_workspace](#output\_desktop\_workspace) | n/a |
| <a name="output_host_pool"></a> [host\_pool](#output\_host\_pool) | n/a |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | n/a |
| <a name="output_scaling_plan"></a> [scaling\_plan](#output\_scaling\_plan) | n/a |
