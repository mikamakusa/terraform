## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.17.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.17.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_network_security_address_group_iam_binding.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_network_security_address_group_iam_binding) | resource |
| [google-beta_google_network_security_firewall_endpoint.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_network_security_firewall_endpoint) | resource |
| [google-beta_google_network_security_profile.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_network_security_profile) | resource |
| [google-beta_google_network_security_profile_group.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_network_security_profile_group) | resource |
| [google_network_security_address_group.this](https://registry.terraform.io/providers/hashicorp/google/5.17.0/docs/resources/network_security_address_group) | resource |
| [google_network_security_authorization_policy.this](https://registry.terraform.io/providers/hashicorp/google/5.17.0/docs/resources/network_security_authorization_policy) | resource |
| [google_network_security_client_tls_policy.this](https://registry.terraform.io/providers/hashicorp/google/5.17.0/docs/resources/network_security_client_tls_policy) | resource |
| [google_network_security_gateway_security_policy.this](https://registry.terraform.io/providers/hashicorp/google/5.17.0/docs/resources/network_security_gateway_security_policy) | resource |
| [google_network_security_gateway_security_policy_rule.this](https://registry.terraform.io/providers/hashicorp/google/5.17.0/docs/resources/network_security_gateway_security_policy_rule) | resource |
| [google_network_security_server_tls_policy.this](https://registry.terraform.io/providers/hashicorp/google/5.17.0/docs/resources/network_security_server_tls_policy) | resource |
| [google_network_security_tls_inspection_policy.this](https://registry.terraform.io/providers/hashicorp/google/5.17.0/docs/resources/network_security_tls_inspection_policy) | resource |
| [google_network_security_url_lists.this](https://registry.terraform.io/providers/hashicorp/google/5.17.0/docs/resources/network_security_url_lists) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_group"></a> [address\_group](#input\_address\_group) | - type : The type of the Address Group. Possible values are "IPV4" or "IPV6". Possible values are: IPV4, IPV6<br>- capacity : Capacity of the Address Group<br>- name : Name of the AddressGroup resource<br>- location : The location of the gateway security policy. The default value is 'global'. | <pre>list(map(object({<br>    id          = number<br>    capacity    = number<br>    location    = string<br>    name        = string<br>    type        = string<br>    description = optional(string)<br>    labels      = optional(map(string))<br>    items       = optional(list(string))<br>    parent      = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_address_group_iam_binding"></a> [address\_group\_iam\_binding](#input\_address\_group\_iam\_binding) | n/a | <pre>list(map(object({<br>    id               = number<br>    project          = string<br>    address_group_id = number<br>    members          = list(string)<br>  })))</pre> | `[]` | no |
| <a name="input_authorization_policy"></a> [authorization\_policy](#input\_authorization\_policy) | - action : The action to take when a rule match is found. Possible values are "ALLOW" or "DENY"<br>- name : Name of the AuthorizationPolicy resource<br>- rules : List of rules to match. | <pre>list(map(object({<br>    id          = number<br>    action      = string<br>    name        = string<br>    labels      = optional(map(string))<br>    description = optional(string)<br>    location    = optional(string)<br>    project     = optional(string)<br>    rules = optional(list(object({<br>      sources = optional(list(object({<br>        principals = optional(list(string))<br>        ip_blocks  = optional(list(object({})))<br>      })), [])<br>      destinations = optional(list(object({<br>        hosts   = list(string)<br>        methods = list(string)<br>        ports   = list(string)<br>        http_header_match = optional(list(object({<br>          header_name = string<br>          regex_match = string<br>        })), [])<br>      })), [])<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_client_tls_policy"></a> [client\_tls\_policy](#input\_client\_tls\_policy) | n/a | <pre>list(map(object({<br>    id          = number<br>    name        = string<br>    labels      = optional(map(string))<br>    description = optional(string)<br>    sni         = optional(string)<br>    location    = optional(string)<br>    project     = optional(string)<br>    client_certificate = optional(list(object({<br>      grpc_endpoint = optional(list(object({<br>        target_uri = string<br>      })), [])<br>      certificate_provider_instance = optional(list(object({<br>        plugin_instance = string<br>      })), [])<br>    })), [])<br>    server_validation_ca = optional(list(object({<br>      grpc_endpoint = optional(list(object({<br>        target_uri = string<br>      })), [])<br>      certificate_provider_instance = optional(list(object({<br>        plugin_instance = string<br>      })), [])<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_firewall_endpoint"></a> [firewall\_endpoint](#input\_firewall\_endpoint) | n/a | <pre>list(map(object({<br>    id       = number<br>    location = string<br>    name     = string<br>    parent   = string<br>    labels   = optional(map(string))<br>  })))</pre> | `[]` | no |
| <a name="input_gateway_security_policy"></a> [gateway\_security\_policy](#input\_gateway\_security\_policy) | n/a | <pre>list(map(object({<br>    id                       = number<br>    name                     = string<br>    description              = optional(string)<br>    tls_inspection_policy_id = optional(number)<br>    location                 = optional(string)<br>    project                  = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_gateway_security_policy_rule"></a> [gateway\_security\_policy\_rule](#input\_gateway\_security\_policy\_rule) | n/a | <pre>list(map(object({<br>    id                         = number<br>    basic_profile              = string<br>    enabled                    = bool<br>    gateway_security_policy_id = number<br>    location                   = string<br>    name                       = string<br>    priority                   = number<br>    session_matcher            = string<br>    description                = optional(string)<br>    application_matcher        = optional(string)<br>    tls_inspection_enabled     = optional(bool)<br>    project                    = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | n/a | `map(string)` | `{}` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | n/a | <pre>list(map(object({<br>    id          = number<br>    type        = string<br>    name        = string<br>    description = optional(string)<br>    labels      = optional(map(string))<br>    location    = optional(string)<br>    parent      = optional(string)<br>    threat_prevention_profile = optional(list(object({<br>      severity_overrides = optional(list(object({<br>        action   = string<br>        severity = string<br>      })), [])<br>      threat_overrides = optional(list(object({<br>        action    = string<br>        threat_id = string<br>        type      = string<br>      })), [])<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_profile_group"></a> [profile\_group](#input\_profile\_group) | n/a | <pre>list(map(object({<br>    id                           = number<br>    name                         = string<br>    description                  = optional(string)<br>    labels                       = optional(map(string))<br>    threat_prevention_profile_id = optional(number)<br>    location                     = optional(string)<br>    parent                       = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_server_tls_policy"></a> [server\_tls\_policy](#input\_server\_tls\_policy) | n/a | <pre>list(map(object({<br>    id          = number<br>    name        = string<br>    labels      = optional(map(string))<br>    description = optional(string)<br>    allow_open  = optional(bool)<br>    location    = optional(string)<br>    project     = optional(string)<br>    server_certificate = optional(list(object({<br>      grpc_endpoint = optional(list(object({<br>        target_uri = string<br>      })), [])<br>      certificate_provider_instance = optional(list(object({<br>        plugin_instance = string<br>      })), [])<br>    })), [])<br>    mtls_policy = optional(list(object({<br>      client_validation_mode         = optional(string)<br>      client_validation_trust_config = optional(string)<br>      server_validation_ca = optional(list(object({<br>        grpc_endpoint = optional(list(object({<br>          target_uri = string<br>        })), [])<br>        certificate_provider_instance = optional(list(object({<br>          plugin_instance = string<br>        })), [])<br>      })), [])<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_tls_inspection_policy"></a> [tls\_inspection\_policy](#input\_tls\_inspection\_policy) | n/a | <pre>list(map(object({<br>    id                    = number<br>    ca_pool               = string<br>    name                  = string<br>    description           = optional(string)<br>    exclude_public_ca_set = optional(bool)<br>    location              = optional(string)<br>    project               = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_url_lists"></a> [url\_lists](#input\_url\_lists) | n/a | <pre>list(map(object({<br>    id          = number<br>    location    = string<br>    name        = string<br>    values      = list(string)<br>    description = optional(string)<br>    project     = optional(string)<br>  })))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address_group"></a> [address\_group](#output\_address\_group) | n/a |
| <a name="output_authorization_policy"></a> [authorization\_policy](#output\_authorization\_policy) | n/a |
| <a name="output_client_tls_policy"></a> [client\_tls\_policy](#output\_client\_tls\_policy) | n/a |
| <a name="output_gateway_security_policy"></a> [gateway\_security\_policy](#output\_gateway\_security\_policy) | n/a |
| <a name="output_server_tls_policy"></a> [server\_tls\_policy](#output\_server\_tls\_policy) | n/a |
| <a name="output_tls_inspection_policy"></a> [tls\_inspection\_policy](#output\_tls\_inspection\_policy) | n/a |
