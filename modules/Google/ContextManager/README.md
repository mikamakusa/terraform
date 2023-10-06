## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.7 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.0.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_access_context_manager_access_level.this](https://registry.terraform.io/providers/hashicorp/google/5.0.0/docs/resources/access_context_manager_access_level) | resource |
| [google_access_context_manager_access_level_condition.this](https://registry.terraform.io/providers/hashicorp/google/5.0.0/docs/resources/access_context_manager_access_level_condition) | resource |
| [google_access_context_manager_access_policy.this](https://registry.terraform.io/providers/hashicorp/google/5.0.0/docs/resources/access_context_manager_access_policy) | resource |
| [google_access_context_manager_access_policy_iam_binding.this](https://registry.terraform.io/providers/hashicorp/google/5.0.0/docs/resources/access_context_manager_access_policy_iam_binding) | resource |
| [google_access_context_manager_authorized_orgs_desc.this](https://registry.terraform.io/providers/hashicorp/google/5.0.0/docs/resources/access_context_manager_authorized_orgs_desc) | resource |
| [google_access_context_manager_gcp_user_access_binding.this](https://registry.terraform.io/providers/hashicorp/google/5.0.0/docs/resources/access_context_manager_gcp_user_access_binding) | resource |
| [google_access_context_manager_service_perimeter.this](https://registry.terraform.io/providers/hashicorp/google/5.0.0/docs/resources/access_context_manager_service_perimeter) | resource |
| [google_access_context_manager_service_perimeter_resource.this](https://registry.terraform.io/providers/hashicorp/google/5.0.0/docs/resources/access_context_manager_service_perimeter_resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_level"></a> [access\_level](#input\_access\_level) | An AccessLevel is a label that can be applied to requests to GCP Services, along with a list of requirements necessary for the label to be applied. | <pre>object({<br>    name        = string<br>    parent      = string<br>    title       = string<br>    description = optional(string)<br>    basic       = optional(object({}))<br>    custom      = optional(object({}))<br>    basic = optional(object({<br>      combining_function = optional(string)<br>      conditions = optional(object({<br>        ip_subnetworks         = optional(list(string))<br>        required_access_levels = optional(list(string))<br>        members                = optional(string)<br>        negate                 = optional(bool)<br>        regions                = optional(list(string))<br>        device_policy = optional(object({<br>          require_screen_lock              = optional(bool)<br>          allowed_encryption_statuses      = optional(list(string))<br>          allowed_device_management_levels = optional(list(string))<br>          require_admin_approval           = optional(bool)<br>          require_corp_owned               = optional(bool)<br>          os_constraints = optional(object({<br>            minimum_version             = optional(string)<br>            os_type                     = optional(string)<br>            required_verified_chrome_os = optional(bool)<br>          }))<br>        }))<br>      }))<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_access_policy"></a> [access\_policy](#input\_access\_policy) | It's a container for AccessLevels and Service Perimeters. It's globally visibile within an organization, and the restrictions it specifies apply to all projects within an organization. | <pre>object({<br>    parent = string<br>    title  = string<br>    scopes = optional(list(string))<br>  })</pre> | `null` | no |
| <a name="input_authorized_orgs_desc"></a> [authorized\_orgs\_desc](#input\_authorized\_orgs\_desc) | An authorized organizations description describes a list of organizations that have been authorized to use certain asset data owned by different organizations at the enforcement points, or with certain asset (device, for example) have been authorized to access the resource in another organization at the enforcement points. | <pre>object({<br>    name                    = string<br>    authorization_direction = optional(string)<br>    asset_type              = optional(string)<br>    orgs                    = list(string)<br>  })</pre> | `null` | no |
| <a name="input_members"></a> [members](#input\_members) | n/a | `list(string)` | `[]` | no |
| <a name="input_perimeter_resource"></a> [perimeter\_resource](#input\_perimeter\_resource) | Allows configuring a single GCP resource that should be inside a service perimeter | <pre>object({<br>    resource       = string<br>    perimeter_name = string<br>  })</pre> | `null` | no |
| <a name="input_service_perimeter"></a> [service\_perimeter](#input\_service\_perimeter) | Describe a set of GCP resources which can freely import and export data amongst themselves, but not export outside of the service perimeter. | <pre>object({<br>    title                       = string<br>    parent                      = string<br>    name                        = string<br>    description                 = optional(string)<br>    perimeter_type              = optional(string)<br>    use_explicitly_dry_run_spec = optional(string)<br>    status = optional(object({<br>      resources           = optional(list(string))<br>      access_levels       = optional(list(string))<br>      restricted_services = optional(list(string))<br>      vpc_accessible_services = optional(object({<br>        enable_restrictions = optional(bool)<br>        allowed_services    = optional(list(string))<br>      }))<br>      ingress_policies = optional(object({<br>        ingress_from = optional(object({<br>          identity_type = optional(string)<br>          identities    = optional(list(string))<br>          sources = optional(object({<br>            access_level = optional(string)<br>            resource     = optional(string)<br>          }))<br>        }))<br>        ingress_to = optional(object({<br>          resources = list(string)<br>          operations = optional(object({<br>            service_name = optional(string)<br>            method_selectors = optional(object({<br>              method     = optional(string)<br>              permission = optional(string)<br>            }))<br>          }))<br>        }))<br>      }))<br>      egress_policies = optional(object({<br>        egress_from = optional(object({<br>          identity_type = optional(string)<br>          identities    = optional(list(string))<br>        }))<br>        egress_to = optional(object({<br>          external_resources = optional(list(string))<br>          resources          = optional(list(string))<br>          operations = optional(object({<br>            service_name = optional(string)<br>            method_selectors = optional(object({<br>              method     = optional(string)<br>              permission = optional(string)<br>            }))<br>          }))<br>        }))<br>      }))<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_user_access_binding"></a> [user\_access\_binding](#input\_user\_access\_binding) | Restricts access to Cloud Console and Google Cloud APIs for a set of users. | <pre>object({<br>    group_key       = string<br>    organization_id = string<br>    access_levels   = list(string)<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_level"></a> [access\_level](#output\_access\_level) | n/a |
| <a name="output_access_level_condition"></a> [access\_level\_condition](#output\_access\_level\_condition) | n/a |
| <a name="output_access_policy"></a> [access\_policy](#output\_access\_policy) | n/a |
| <a name="output_authorized_orgs_desc"></a> [authorized\_orgs\_desc](#output\_authorized\_orgs\_desc) | n/a |
| <a name="output_gcp_user_access_binding"></a> [gcp\_user\_access\_binding](#output\_gcp\_user\_access\_binding) | n/a |
| <a name="output_iam_binding"></a> [iam\_binding](#output\_iam\_binding) | n/a |
| <a name="output_service_perimeter"></a> [service\_perimeter](#output\_service\_perimeter) | n/a |
| <a name="output_service_perimeter_resource"></a> [service\_perimeter\_resource](#output\_service\_perimeter\_resource) | n/a |
