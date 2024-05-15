## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.8.3 |
| <a name="requirement_openstack"></a> [openstack](#requirement\_openstack) | 1.54.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_openstack"></a> [openstack](#provider\_openstack) | 1.54.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [openstack_identity_application_credential_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/identity_application_credential_v3) | resource |
| [openstack_identity_ec2_credential_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/identity_ec2_credential_v3) | resource |
| [openstack_identity_endpoint_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/identity_endpoint_v3) | resource |
| [openstack_identity_group_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/identity_group_v3) | resource |
| [openstack_identity_inherit_role_assignment_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/identity_inherit_role_assignment_v3) | resource |
| [openstack_identity_project_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/identity_project_v3) | resource |
| [openstack_identity_role_assignment_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/identity_role_assignment_v3) | resource |
| [openstack_identity_role_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/identity_role_v3) | resource |
| [openstack_identity_service_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/identity_service_v3) | resource |
| [openstack_identity_user_membership_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/identity_user_membership_v3) | resource |
| [openstack_identity_user_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/identity_user_v3) | resource |
| [openstack_identity_project_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/data-sources/identity_project_v3) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_credential_v3"></a> [application\_credential\_v3](#input\_application\_credential\_v3) | n/a | <pre>list(map(object({<br>    id           = number<br>    name         = string<br>    region       = optional(string)<br>    description  = optional(string)<br>    unrestricted = optional(bool)<br>    secret       = optional(string)<br>    roles        = optional(list(string))<br>    expires_at   = optional(string)<br>    access_rules = optional(list(object({<br>      method  = string<br>      path    = string<br>      service = string<br>    })))<br>  })))</pre> | `[]` | no |
| <a name="input_ec2_credential_v3"></a> [ec2\_credential\_v3](#input\_ec2\_credential\_v3) | n/a | <pre>list(map(object({<br>    id         = number<br>    project_id = optional(number)<br>    user_id    = optional(number)<br>  })))</pre> | `[]` | no |
| <a name="input_endpoint_v3"></a> [endpoint\_v3](#input\_endpoint\_v3) | n/a | <pre>list(map(object({<br>    id         = number<br>    service_id = number<br>    url        = string<br>    name       = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_group_v3"></a> [group\_v3](#input\_group\_v3) | n/a | <pre>list(map(object({<br>    id          = number<br>    name        = string<br>    description = optional(string)<br>    domain_id   = optional(string)<br>    region      = optional(number)<br>  })))</pre> | `[]` | no |
| <a name="input_inherit_role_assignment_v3"></a> [inherit\_role\_assignment\_v3](#input\_inherit\_role\_assignment\_v3) | n/a | <pre>list(map(object({<br>    id         = number<br>    role_id    = number<br>    domain_id  = optional(string)<br>    group_id   = optional(number)<br>    project_id = optional(number)<br>    user_id    = optional(number)<br>  })))</pre> | `[]` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_project_v3"></a> [project\_v3](#input\_project\_v3) | n/a | <pre>list(map(object({<br>    id          = number<br>    name        = optional(string)<br>    description = optional(string)<br>    domain_id   = optional(string)<br>    enabled     = optional(bool)<br>    is_domain   = optional(bool)<br>    parent_id   = optional(string)<br>    region      = optional(string)<br>    tags        = optional(list(string))<br>  })))</pre> | `[]` | no |
| <a name="input_role_assignment_v3"></a> [role\_assignment\_v3](#input\_role\_assignment\_v3) | n/a | <pre>list(map(object({<br>    id         = number<br>    role_id    = number<br>    domain_id  = optional(string)<br>    group_id   = optional(number)<br>    project_id = optional(number)<br>    user_id    = optional(number)<br>  })))</pre> | `[]` | no |
| <a name="input_role_v3"></a> [role\_v3](#input\_role\_v3) | n/a | <pre>list(map(object({<br>    id         = number<br>    name       = string<br>    domain_id  = optional(string)<br>    project_id = optional(number)<br>  })))</pre> | `[]` | no |
| <a name="input_service_v3"></a> [service\_v3](#input\_service\_v3) | n/a | <pre>list(map(object({<br>    id          = number<br>    name        = string<br>    type        = string<br>    project_id  = optional(number)<br>    description = optional(string)<br>    enabled     = optional(bool)<br>  })))</pre> | `[]` | no |
| <a name="input_user_membership_v3"></a> [user\_membership\_v3](#input\_user\_membership\_v3) | n/a | <pre>list(map(object({<br>    id         = number<br>    group_id   = number<br>    user_id    = number<br>    project_id = optional(number)<br>  })))</pre> | `[]` | no |
| <a name="input_user_v3"></a> [user\_v3](#input\_user\_v3) | n/a | <pre>list(map(object({<br>    id                                    = number<br>    description                           = optional(string)<br>    default_project_id                    = optional(string)<br>    domain_id                             = optional(string)<br>    enabled                               = optional(bool)<br>    extra                                 = optional(map(string))<br>    ignore_change_password_upon_first_use = optional(bool)<br>    ignore_lockout_failure_attempts       = optional(bool)<br>    ignore_password_expiry                = optional(bool)<br>    multi_factor_auth_enabled             = optional(bool)<br>    name                                  = optional(string)<br>    password                              = optional(string)<br>    multi_factor_auth_rule = optional(list(object({<br>      rule = list(string)<br>    })), [])<br>  })))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_group"></a> [group](#output\_group) | n/a |
| <a name="output_project"></a> [project](#output\_project) | n/a |
| <a name="output_roe_assignment"></a> [roe\_assignment](#output\_roe\_assignment) | n/a |
| <a name="output_role"></a> [role](#output\_role) | n/a |
| <a name="output_service"></a> [service](#output\_service) | n/a |
| <a name="output_user"></a> [user](#output\_user) | n/a |
| <a name="output_user_membership"></a> [user\_membership](#output\_user\_membership) | n/a |
