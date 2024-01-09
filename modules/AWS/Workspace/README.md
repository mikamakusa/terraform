## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.6.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.31.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.31.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_workspaces_directory.this](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/resources/workspaces_directory) | resource |
| [aws_workspaces_ip_group.this](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/resources/workspaces_ip_group) | resource |
| [aws_workspaces_workspace.this](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/resources/workspaces_workspace) | resource |
| [aws_directory_service_directory.this](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/data-sources/directory_service_directory) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_directory"></a> [directory](#input\_directory) | n/a | <pre>list(map(object({<br>    id         = string<br>    subnet_ids = optional(list(string))<br>    tags       = optional(map(string))<br>    self_service_permissions = optional(list(object({<br>      change_compute_type  = optional(bool)<br>      increase_volume_size = optional(bool)<br>      rebuild_workspace    = optional(bool)<br>      restart_workspace    = optional(bool)<br>      switch_running_mode  = optional(bool)<br>    })), [])<br>    workspace_access_properties = optional(list(object({<br>      device_type_android    = optional(string)<br>      device_type_chromeos   = optional(string)<br>      device_type_ios        = optional(string)<br>      device_type_osx        = optional(string)<br>      device_type_web        = optional(string)<br>      device_type_windows    = optional(string)<br>      device_type_zeroclient = optional(string)<br>    })), [])<br>    workspace_creation_properties = optional(list(object({<br>      custom_security_group_id            = optional(string)<br>      default_ou                          = optional(string)<br>      enable_internet_access              = optional(bool)<br>      enable_maintenance_mode             = optional(bool)<br>      user_enabled_as_local_administrator = optional(bool)<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_directory_service_id"></a> [directory\_service\_id](#input\_directory\_service\_id) | n/a | `string` | n/a | yes |
| <a name="input_ip_group"></a> [ip\_group](#input\_ip\_group) | n/a | <pre>list(map(object({<br>    id          = number<br>    name        = string<br>    description = optional(string)<br>    tags        = optional(map(string))<br>    rules = optional(list(object({<br>      source      = string<br>      description = optional(string)<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_workspace"></a> [workspace](#input\_workspace) | n/a | <pre>list(map(object({<br>    id                             = number<br>    bundle_id                      = string<br>    directory_id                   = number<br>    user_name                      = string<br>    root_volume_encryption_enabled = optional(bool)<br>    user_volume_encryption_enabled = optional(bool)<br>    volume_encryption_key          = optional(string)<br>    tags                           = optional(map(string))<br>    workspace_properties = optional(list(object({<br>      compute_type_name                         = optional(string)<br>      root_volume_size_gib                      = optional(number)<br>      running_mode                              = optional(string)<br>      running_mode_auto_stop_timeout_in_minutes = optional(number)<br>      user_volume_size_gib                      = optional(string)<br>    })), [])<br>  })))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_workspace"></a> [workspace](#output\_workspace) | n/a |
| <a name="output_workspace_directory"></a> [workspace\_directory](#output\_workspace\_directory) | n/a |
| <a name="output_workspace_ip_group"></a> [workspace\_ip\_group](#output\_workspace\_ip\_group) | n/a |
