variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group to be used"
}

variable "api_management" {
  type = object({
    name            = string
    publisher_email = string
    publisher_name  = string
    sku_name        = string
  })

  validation {
    condition     = contains(["Consumption", "Developer", "Basic", "Standard", "Premium"], var.api_management.sku_name)
    error_message = "Allowed values are \"Consumption\", \"Developer\", \"Basic\", \"Standard\", \"Premium\"."
  }

  description = "Manages an API Management Service."
}

variable "api_management_api" {
  type = object({
    name         = string
    revision     = string
    api_type     = optional(string)
    display_name = optional(string)
    path         = optional(string)
    protocols    = optional(list(string))
    contact = optional(object({
      email = optional(string)
      name  = optional(string)
      url   = optional(string)
    }))
    description = optional(string)
    import = optional(object({
      content_format = optional(string)
      content_value  = optional(string)
      wsdl_selector = optional(object({
        service_name  = optional(string)
        endpoint_name = optional(string)
      }))
    }))
    license = optional(object({
      name = optional(string)
      url  = optional(string)
    }))
    oauth2_authorization = optional(object({
      authorization_server_name = optional(string)
      scope                     = optional(string)
    }))
    openid_authentication = optional(object({
      openid_provider_name         = optional(string)
      bearer_token_sending_methods = optional(list(string))
    }))
    service_url           = optional(string)
    subscription_required = optional(string)
    subscription_key_parameter_names = optional(object({
      header = optional(string)
      query  = optional(string)
    }))
    subscription_required = optional(bool)
    terms_of_service_url  = optional(string)
    version               = optional(string)
    version_set_id        = optional(string)
    revision_description  = optional(string)
    version_description   = optional(string)
    source_api_id         = optional(string)
  })

  default = null

  description = "Manages an API within an API Management Service."
}

variable "application_insights" {
  type    = string
  default = null
}

variable "event_hub_name" {
  type    = string
  default = null
}

variable "event_hub_namespace" {
  type    = string
  default = null
}

variable "api_management_logger" {
  type = object({
    name        = string
    buffered    = optional(string)
    description = optional(string)
    resource_id = optional(string)
  })

  default = null

  description = "Manages a Logger within an API Management Service."
}

variable "api_diagnostic" {
  type = object({
    identifier            = string
    always_log_errors     = optional(bool)
    log_client_ip         = optional(string)
    sampling_percentage   = optional(string)
    verbosity             = optional(string)
    operation_name_format = optional(string)
    backend_request = optional(object({
      body_bytes     = optional(number)
      headers_to_log = optional(list(string))
      data_masking = optional(object({
        query_params = optional(object({
          mode  = optional(string)
          value = optional(string)
        }))
        headers = optional(object({
          mode  = optional(string)
          value = optional(string)
        }))
      }))
    }))
    backend_response = optional(object({
      body_bytes     = optional(number)
      headers_to_log = optional(list(string))
      data_masking = optional(object({
        query_params = optional(object({
          mode  = optional(string)
          value = optional(string)
        }))
        headers = optional(object({
          mode  = optional(string)
          value = optional(string)
        }))
      }))
    }))
    frontend_request = optional(object({
      body_bytes     = optional(number)
      headers_to_log = optional(list(string))
      data_masking = optional(object({
        query_params = optional(object({
          mode  = optional(string)
          value = optional(string)
        }))
        headers = optional(object({
          mode  = optional(string)
          value = optional(string)
        }))
      }))
    }))
    frontend_response = optional(object({
      body_bytes     = optional(number)
      headers_to_log = optional(list(string))
      data_masking = optional(object({
        query_params = optional(object({
          mode  = optional(string)
          value = optional(string)
        }))
        headers = optional(object({
          mode  = optional(string)
          value = optional(string)
        }))
      }))
    }))
  })

  default = null

  description = "Manages a API Management Service API Diagnostics Logs."
}

variable "api_operation" {
  type = object({
    operation_id = string
    display_name = string
    method       = string
    url_template = string
    description  = optional(string)
  })

  default = null

  description = "Manages an API Operation within an API Management Service."
}

variable "operation_tag" {
  type = map(object({
    display_name = optional(string)
  }))

  default = {}

  description = "Manages a API Management API Operation Tag."
}

variable "api_management_api_schema" {
  type = object({
    schema_id    = string
    content_type = string
    value        = optional(string)
    components   = optional(string)
    definitions  = optional(string)
  })
  default     = null
  description = "Manages an API Schema within an API Management Service."
}

variable "api_version_set" {
  type = map(object({
    display_name        = string
    versioning_scheme   = string
    description         = optional(string)
    version_header_name = optional(string)
    version_query_name  = optional(string)
  }))
  default = {}
  validation {
    condition     = contains(["Header", "Query", "Segment"], var.api_version_set.versioning_scheme)
    error_message = "Allowed values are 'Header', 'Query' and 'Segment'."
  }
  description = "Manages an API Version Set within an API Management Service."
}

variable "authorization_server" {
  type = object({
    authorization_endpoint       = string
    authorization_methods        = list(string)
    client_id                    = string
    client_registration_endpoint = string
    display_name                 = string
    grant_types                  = list(string)
    name                         = string
    bearer_token_sending_methods = optional(list(string))
    client_authentication_method = optional(list(string))
    client_secret                = optional(string)
    default_scope                = optional(string)
    description                  = optional(string)
    resource_owner_password      = optional(string)
    resource_owner_username      = optional(string)
    support_state                = optional(bool)
    token_endpoint               = optional(string)
    token_body_parameter = optional(object({
      name  = optional(string)
      value = optional(string)
    }))
  })
  default = null
  validation {
    condition     = contains(["authorizationCode", "clientCredentials", "implicit", "resourceOwnerPassword"], var.authorization_server.grant_types)
    error_message = "Allowed values are \"authorizationCode\", \"clientCredentials\", \"implicit\", \"resourceOwnerPassword\"."
  }
  validation {
    condition     = contains(["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT", "TRACE"], var.authorization_server.authorization_methods)
    error_message = "Allowed values are : \"DELETE\", \"GET\", \"HEAD\", \"OPTIONS\", \"PATCH\", \"POST\", \"PUT\", \"TRACE\"."
  }
  description = "Manages an Authorization Server within an API Management Service."
}

variable "backend" {
  type = object({
    name        = string
    protocol    = string
    url         = string
    description = optional(string)
    resource_id = optional(string)
    title       = optional(string)
    tls = optional(object({
      validate_certificate_chain = optional(bool)
      validate_certificate_name  = optional(bool)
    }))
    service_fabric_cluster = optional(object({
      management_endpoints             = optional(list(string))
      max_partition_resolution_retries = optional(string)
      client_certificate_thumbprint    = optional(string)
      client_certificate_id            = optional(string)
      server_certificate_thumbprints   = optional(list(string))
      server_x509_name = optional(map(object({
        issuer_certificate_thumbprint = optional(string)
      })))
    }))
    proxy = optional(object({
      username = optional(string)
      password = optional(string)
      url      = optional(string)
    }))
    credentials = optional(object({
      certificate = optional(list(string))
      header      = optional(map(string))
      query       = optional(map(string))
      authorization = optional(object({
        parameter = optional(string)
        scheme    = optional(string)
      }))
    }))
  })
  default = null
  validation {
    condition     = contains(["http", "soap"], var.backend.protocol)
    error_message = "Allowed values are : 'http' or 'soap'."
  }
  description = "Manages a backend within an API Management Service."
}

variable "certificate" {
  type = object({
    name     = string
    password = optional(string)
    data     = optional(string)
  })
  description = "Manages an Certificate within an API Management Service."
  default     = null
}

variable "keyvault_name" {
  type    = string
  default = null
}

variable "keyvault_certificate_name" {
  type    = string
  default = null
}

variable "custom_domain" {
  type = object({
    scm = optional(object({
      host_name                       = optional(string)
      certificate                     = optional(string)
      certificate_password            = optional(string)
      key_vault_id                    = optional(string)
      negotiate_client_certificate    = optional(bool)
      ssl_keyvault_identity_client_id = optional(string)
    }))
    developer_portal = optional(object({
      host_name                       = optional(string)
      certificate                     = optional(string)
      certificate_password            = optional(string)
      key_vault_id                    = optional(string)
      negotiate_client_certificate    = optional(bool)
      ssl_keyvault_identity_client_id = optional(string)
    }))
    portal = optional(object({
      host_name                       = optional(string)
      certificate                     = optional(string)
      certificate_password            = optional(string)
      key_vault_id                    = optional(string)
      negotiate_client_certificate    = optional(bool)
      ssl_keyvault_identity_client_id = optional(string)
    }))
    gateway = optional(object({
      host_name                       = optional(string)
      certificate                     = optional(string)
      certificate_password            = optional(string)
      key_vault_id                    = optional(string)
      negotiate_client_certificate    = optional(bool)
      ssl_keyvault_identity_client_id = optional(string)
      default_ssl_binding             = optional(string)
    }))
    management = optional(object({
      host_name                       = optional(string)
      certificate                     = optional(string)
      certificate_password            = optional(string)
      key_vault_id                    = optional(string)
      negotiate_client_certificate    = optional(bool)
      ssl_keyvault_identity_client_id = optional(string)
    }))
  })
  default     = null
  description = "Manages a API Management Custom Domain."
}

variable "gateway" {
  type = object({
    name        = string
    description = optional(string)
    location_data = optional(object({
      name     = optional(string)
      city     = optional(string)
      district = optional(string)
      region   = optional(string)
    }))
  })
  default = null
  description = "Manages an API Management Gateway."
}

variable "gateway_host_name_configuration" {
  type = object({
    name      = string
    host_name = string
  })
  default = null
}

variable "api_management_group" {
  type = object({
    name         = string
    display_name = string
    description  = optional(string)
    external_id  = optional(string)
    type         = optional(string)
  })
  default = null
}

variable "api_management_user" {
  type = object({
    email        = string
    first_name   = string
    last_name    = string
    user_id      = string
    confirmation = optional(string)
    note         = optional(string)
    password     = optional(string)
    state        = optional(string)
  })
  default = null
}

variable "provider_aad" {
  type = object({
    allowed_tenants = list(string)
    client_id       = string
    client_secrets  = string
  })
  default = null
}

variable "provider_aadb2c" {
  type = object({
    allowed_tenant         = string
    authority              = string
    client_id              = string
    client_secret          = string
    signin_policy          = string
    signin_tenant          = string
    signup_policy          = string
    password_reset_policy  = optional(string)
    profile_editing_policy = optional(string)
  })
  default = null
}

variable "provider_facebook" {
  type = object({
    app_id     = string
    app_secret = string
  })
  default = null
}

variable "provider_google" {
  type = object({
    client_id     = string
    client_secret = string
  })
  default = null
}

variable "provider_microsoft" {
  type = object({
    client_id     = string
    client_secret = string
  })
  default = null
}

variable "provider_twitter" {
  type = object({
    api_key        = string
    api_secret_key = string
  })
  default = null
}

variable "named_value" {
  type = object({
    name          = string
    display_value = string
    value         = optional(string)
    secret        = optional(bool)
    tags          = optional(list(string))
    value_from_key_vault = optional(object({
      secret_id          = optional(string)
      identity_client_id = optional(string)
    }))
  })
  default = null
}

variable "notification_recipient_email" {
  type = object({
    email             = string
    notification_type = string
  })
  default = null
  validation {
    condition     = contains(["AccountClosedPublisher", "BCC", "NewApplicationNotificationMessage", "NewIssuePublisherNotificationMessage", "PurchasePublisherNotificationMessage", "QuotaLimitApproachingPublisherNotificationMessage", "RequestPublisherNotificationMessage"], var.notification_recipient_email.notification_type)
    error_message = "Value not allowed."
  }
}

variable "notification_recipient_user" {
  type = object({
    user_id           = string
    notification_type = string
  })
  default = null
  validation {
    condition     = contains(["AccountClosedPublisher", "BCC", "NewApplicationNotificationMessage", "NewIssuePublisherNotificationMessage", "PurchasePublisherNotificationMessage", "QuotaLimitApproachingPublisherNotificationMessage", "RequestPublisherNotificationMessage"], var.notification_recipient_email.notification_type)
    error_message = "Value not allowed."
  }
}

variable "openid_connect_provider" {
  type = object({
    name              = string
    client_id         = string
    client_secret     = string
    display_name      = string
    metadata_endpoint = string
  })
  default = null
}

variable "api_management_policy" {
  type = object({
    xml_content = optional(string)
    xml_link    = optional(string)
  })
  default = null
}

variable "api_management_product" {
  type = object({
    display_name          = string
    product_id            = string
    published             = bool
    subscription_required = optional(bool)
    subscription_limit    = optional(number)
    terms                 = optional(string)
    approval_required     = optional(bool)
  })
  default = null
}

variable "product_policy" {
  type = object({
    xml_content = optional(string)
    xml_link    = optional(string)
  })
  default = null
}

variable "product_tag" {
  type = object({
    name = string
  })
  default = null
}

variable "redis_cache" {
  type    = string
  default = null
}

variable "api_management_redis_cache" {
  type = object({
    name           = string
    description    = optional(string)
    cache_location = optional(string)
  })
  default = null
}

variable "global_schema" {
  type = object({
    schema_id = string
    type      = string
    value     = string
  })
  default = null
  validation {
    condition     = contains(["xml", "json"], var.global_schema.type)
    error_message = "Allowed value are : 'xml' and 'json'."
  }
}

variable "subscription" {
  type = object({
    display_name    = string
    primary_key     = optional(string)
    secondary_key   = optional(string)
    state           = optional(string)
    subscription_id = optional(string)
  })
  default = null
}

variable "api_management_tag" {
  type = object({
    name = string
  })
  default = null
}