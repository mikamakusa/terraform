## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.7 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.75.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.75.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/resources/api_management) | resource |
| [azurerm_api_management_api.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api_diagnostic.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/resources/api_management_api_diagnostic) | resource |
| [azurerm_api_management_api_operation.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/resources/api_management_api_operation) | resource |
| [azurerm_api_management_api_operation_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_tag.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/resources/api_management_api_operation_tag) | resource |
| [azurerm_api_management_api_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_release.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/resources/api_management_api_release) | resource |
| [azurerm_api_management_api_schema.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/resources/api_management_api_schema) | resource |
| [azurerm_api_management_api_tag.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/resources/api_management_api_tag) | resource |
| [azurerm_api_management_api_tag_description.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/resources/api_management_api_tag_description) | resource |
| [azurerm_api_management_api_version_set.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_authorization_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/resources/api_management_authorization_server) | resource |
| [azurerm_api_management_backend.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/resources/api_management_backend) | resource |
| [azurerm_api_management_certificate.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/resources/api_management_certificate) | resource |
| [azurerm_api_management_logger.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/resources/api_management_logger) | resource |
| [azurerm_application_insights.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/data-sources/application_insights) | data source |
| [azurerm_eventhub.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/data-sources/eventhub) | data source |
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_certificate.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_diagnostic"></a> [api\_diagnostic](#input\_api\_diagnostic) | n/a | <pre>object({<br>    identifier            = string<br>    always_log_errors     = optional(bool)<br>    log_client_ip         = optional(string)<br>    sampling_percentage   = optional(string)<br>    verbosity             = optional(string)<br>    operation_name_format = optional(string)<br>    backend_request = optional(object({<br>      body_bytes     = optional(number)<br>      headers_to_log = optional(list(string))<br>      data_masking = optional(object({<br>        query_params = optional(object({<br>          mode  = optional(string)<br>          value = optional(string)<br>        }))<br>        headers = optional(object({<br>          mode  = optional(string)<br>          value = optional(string)<br>        }))<br>      }))<br>    }))<br>    backend_response = optional(object({<br>      body_bytes     = optional(number)<br>      headers_to_log = optional(list(string))<br>      data_masking = optional(object({<br>        query_params = optional(object({<br>          mode  = optional(string)<br>          value = optional(string)<br>        }))<br>        headers = optional(object({<br>          mode  = optional(string)<br>          value = optional(string)<br>        }))<br>      }))<br>    }))<br>    frontend_request = optional(object({<br>      body_bytes     = optional(number)<br>      headers_to_log = optional(list(string))<br>      data_masking = optional(object({<br>        query_params = optional(object({<br>          mode  = optional(string)<br>          value = optional(string)<br>        }))<br>        headers = optional(object({<br>          mode  = optional(string)<br>          value = optional(string)<br>        }))<br>      }))<br>    }))<br>    frontend_response = optional(object({<br>      body_bytes     = optional(number)<br>      headers_to_log = optional(list(string))<br>      data_masking = optional(object({<br>        query_params = optional(object({<br>          mode  = optional(string)<br>          value = optional(string)<br>        }))<br>        headers = optional(object({<br>          mode  = optional(string)<br>          value = optional(string)<br>        }))<br>      }))<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_api_management"></a> [api\_management](#input\_api\_management) | n/a | <pre>object({<br>    name            = string<br>    publisher_email = string<br>    publisher_name  = string<br>    sku_name        = string<br>  })</pre> | n/a | yes |
| <a name="input_api_management_api"></a> [api\_management\_api](#input\_api\_management\_api) | n/a | <pre>object({<br>    name         = string<br>    revision     = string<br>    api_type     = optional(string)<br>    display_name = optional(string)<br>    path         = optional(string)<br>    protocols    = optional(list(string))<br>    contact = optional(object({<br>      email = optional(string)<br>      name  = optional(string)<br>      url   = optional(string)<br>    }))<br>    description = optional(string)<br>    import = optional(object({<br>      content_format = optional(string)<br>      content_value  = optional(string)<br>      wsdl_selector = optional(object({<br>        service_name  = optional(string)<br>        endpoint_name = optional(string)<br>      }))<br>    }))<br>    license = optional(object({<br>      name = optional(string)<br>      url  = optional(string)<br>    }))<br>    oauth2_authorization = optional(object({<br>      authorization_server_name = optional(string)<br>      scope                     = optional(string)<br>    }))<br>    openid_authentication = optional(object({<br>      openid_provider_name         = optional(string)<br>      bearer_token_sending_methods = optional(list(string))<br>    }))<br>    service_url           = optional(string)<br>    subscription_required = optional(string)<br>    subscription_key_parameter_names = optional(object({<br>      header = optional(string)<br>      query  = optional(string)<br>    }))<br>    subscription_required = optional(bool)<br>    terms_of_service_url  = optional(string)<br>    version               = optional(string)<br>    version_set_id        = optional(string)<br>    revision_description  = optional(string)<br>    version_description   = optional(string)<br>    source_api_id         = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_api_management_api_schema"></a> [api\_management\_api\_schema](#input\_api\_management\_api\_schema) | n/a | <pre>object({<br>    schema_id    = string<br>    content_type = string<br>    value        = optional(string)<br>    components   = optional(string)<br>    definitions  = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_api_management_logger"></a> [api\_management\_logger](#input\_api\_management\_logger) | n/a | <pre>object({<br>    name        = string<br>    buffered    = optional(string)<br>    description = optional(string)<br>    resource_id = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_api_operation"></a> [api\_operation](#input\_api\_operation) | n/a | <pre>object({<br>    operation_id = string<br>    display_name = string<br>    method       = string<br>    url_template = string<br>    description  = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_api_version_set"></a> [api\_version\_set](#input\_api\_version\_set) | n/a | <pre>map(object({<br>    display_name        = string<br>    versioning_scheme   = string<br>    description         = optional(string)<br>    version_header_name = optional(string)<br>    version_query_name  = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_application_insights"></a> [application\_insights](#input\_application\_insights) | n/a | `string` | `null` | no |
| <a name="input_authorization_server"></a> [authorization\_server](#input\_authorization\_server) | n/a | <pre>object({<br>    authorization_endpoint       = string<br>    authorization_methods        = list(string)<br>    client_id                    = string<br>    client_registration_endpoint = string<br>    display_name                 = string<br>    grant_types                  = list(string)<br>    name                         = string<br>    bearer_token_sending_methods = optional(list(string))<br>    client_authentication_method = optional(list(string))<br>    client_secret                = optional(string)<br>    default_scope                = optional(string)<br>    description                  = optional(string)<br>    resource_owner_password      = optional(string)<br>    resource_owner_username      = optional(string)<br>    support_state                = optional(bool)<br>    token_endpoint               = optional(string)<br>    token_body_parameter = optional(object({<br>      name  = optional(string)<br>      value = optional(string)<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_backend"></a> [backend](#input\_backend) | n/a | <pre>object({<br>    name        = string<br>    protocol    = string<br>    url         = string<br>    description = optional(string)<br>    resource_id = optional(string)<br>    title       = optional(string)<br>    tls = optional(object({<br>      validate_certificate_chain = optional(bool)<br>      validate_certificate_name  = optional(bool)<br>    }))<br>    service_fabric_cluster = optional(object({<br>      management_endpoints             = optional(list(string))<br>      max_partition_resolution_retries = optional(string)<br>      client_certificate_thumbprint    = optional(string)<br>      client_certificate_id            = optional(string)<br>      server_certificate_thumbprints   = optional(list(string))<br>      server_x509_name = optional(map(object({<br>        issuer_certificate_thumbprint = optional(string)<br>      })))<br>    }))<br>    proxy = optional(object({<br>      username = optional(string)<br>      password = optional(string)<br>      url      = optional(string)<br>    }))<br>    credentials = optional(object({<br>      certificate = optional(list(string))<br>      header      = optional(map(string))<br>      query       = optional(map(string))<br>      authorization = optional(object({<br>        parameter = optional(string)<br>        scheme    = optional(string)<br>      }))<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_certificate"></a> [certificate](#input\_certificate) | n/a | <pre>object({<br>    name     = string<br>    password = optional(string)<br>    data     = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_event_hub_name"></a> [event\_hub\_name](#input\_event\_hub\_name) | n/a | `string` | `null` | no |
| <a name="input_event_hub_namespace"></a> [event\_hub\_namespace](#input\_event\_hub\_namespace) | n/a | `string` | `null` | no |
| <a name="input_keyvault_certificate_name"></a> [keyvault\_certificate\_name](#input\_keyvault\_certificate\_name) | n/a | `string` | `null` | no |
| <a name="input_keyvault_name"></a> [keyvault\_name](#input\_keyvault\_name) | n/a | `string` | `null` | no |
| <a name="input_operation_tag"></a> [operation\_tag](#input\_operation\_tag) | n/a | <pre>map(object({<br>    display_name = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the Resource Group to be used | `string` | n/a | yes |

## Outputs

No outputs.
