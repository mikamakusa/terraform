resource "azurerm_api_management" "this" {
  count               = var.api_management == null ? 0 : 1
  location            = data.azurerm_resource_group.this.location
  name                = join("-", [var.api_management.name, "api_management"])
  publisher_email     = var.api_management.publisher_email
  publisher_name      = var.api_management.publisher_name
  resource_group_name = data.azurerm_resource_group.this.name
  sku_name            = var.api_management.sku_name
}

resource "azurerm_api_management_api" "this" {
  count                 = var.api_management != null && var.api_management_api == null ? 0 : 1
  api_management_name   = azurerm_api_management.this.name
  name                  = var.api_management_api.name
  resource_group_name   = data.azurerm_resource_group.this.name
  revision              = var.api_management_api.revision
  api_type              = var.api_management_api.api_type
  display_name          = var.api_management_api.display_name
  path                  = var.api_management_api.path
  protocols             = var.api_management_api.protocols
  description           = var.api_management_api.description
  service_url           = var.api_management_api.service_url
  subscription_required = var.api_management_api.subscription_required
  terms_of_service_url  = var.api_management_api.terms_of_service_url
  version               = var.api_management_api.version
  version_set_id        = var.api_management_api.version_set_id
  revision_description  = var.api_management_api.revision_description
  version_description   = var.api_management_api.version_description
  source_api_id         = var.api_management_api.source_api_id

  dynamic "subscription_key_parameter_names" {
    for_each = var.api_management_api.subscription_key_parameter_names == null ? [] : [""]
    content {
      header = var.api_management_api.subscription_key_parameter_names.header
      query  = var.api_management_api.subscription_key_parameter_names.query
    }
  }

  dynamic "import" {
    for_each = var.api_management_api.import == null ? [] : [""]
    content {
      content_format = var.api_management_api.import.content_format
      content_value  = var.api_management_api.import.content_value

      dynamic "wsdl_selector" {
        for_each = var.api_management_api.import == null ? 0 : var.api_management_api.import.wsdl_selector
        content {
          endpoint_name = var.api_management_api.import.wsdl_selector.endpoint_name
          service_name  = var.api_management_api.import.wsdl_selector.service_name
        }
      }
    }
  }

  dynamic "license" {
    for_each = var.api_management_api.license == null ? [] : [""]
    content {
      name = var.api_management_api.license.name
      url  = var.api_management_api.license.url
    }
  }

  dynamic "oauth2_authorization" {
    for_each = var.api_management_api.oauth2_authorization == null ? [] : [""]
    content {
      authorization_server_name = var.api_management_api.oauth2_authorization.authorization_server_name
      scope                     = var.api_management_api.oauth2_authorization.scope
    }
  }

  dynamic "openid_authentication" {
    for_each = var.api_management_api.openid_authentication == null ? [] : [""]
    content {
      openid_provider_name         = var.api_management_api.openid_authentication.openid_provider_name
      bearer_token_sending_methods = var.api_management_api.openid_authentication.bearer_token_sending_methods
    }
  }

  dynamic "contact" {
    for_each = var.api_management_api.contact == null ? [] : [""]
    content {
      email = var.api_management_api.contact.email
      name  = var.api_management_api.contact.name
      url   = var.api_management_api.contact.url
    }
  }
}

resource "azurerm_api_management_logger" "this" {
  count               = var.api_management_logger == null ? 0 : 1
  api_management_name = azurerm_api_management.this.name
  name                = var.api_management_logger.name
  resource_group_name = data.azurerm_resource_group.this.name
  buffered            = var.api_management_logger.buffered
  description         = var.api_management_logger.description
  resource_id         = var.api_management_logger.resource_id

  eventhub {
    connection_string = join("-", [var.api_management_logger.name, "eventhub"])
    name              = data.azurerm_eventhub.this.name
  }

  application_insights {
    instrumentation_key = data.azurerm_application_insights.this.instrumentation_key
  }
}

resource "azurerm_api_management_api_diagnostic" "this" {
  count                    = var.api_management != null && var.api_management_logger != null && var.api_diagnostic == null ? 0 : 1
  api_management_logger_id = azurerm_api_management_logger.this.id
  api_management_name      = azurerm_api_management.this.name
  api_name                 = azurerm_api_management_api.this.name
  identifier               = var.api_diagnostic.identifier
  resource_group_name      = data.azurerm_resource_group.this.name
  always_log_errors        = var.api_diagnostic.always_log_errors
  log_client_ip            = var.api_diagnostic.log_client_ip
  sampling_percentage      = var.api_diagnostic.sampling_percentage
  verbosity                = var.api_diagnostic.verbosity
  operation_name_format    = var.api_diagnostic.operation_name_format

  dynamic "backend_request" {
    for_each = var.api_diagnostic.backend_request == null ? [] : [""]
    content {
      body_bytes     = var.api_diagnostic.backend_request.body_bytes
      headers_to_log = var.api_diagnostic.backend_request.headers_to_log

      dynamic "data_masking" {
        for_each = var.api_diagnostic.backend_request.data_masking
        content {
          dynamic "query_params" {
            for_each = var.api_diagnostic.backend_request.data_masking.query_params
            content {
              mode  = var.api_diagnostic.backend_request.data_masking.query_params.mode
              value = var.api_diagnostic.backend_request.data_masking.query_params.value
            }
          }
          dynamic "headers" {
            for_each = var.api_diagnostic.backend_request.data_masking.headers
            content {
              mode  = var.api_diagnostic.backend_request.data_masking.headers.mode
              value = var.api_diagnostic.backend_request.data_masking.headers.value
            }
          }
        }
      }
    }
  }

  dynamic "backend_response" {
    for_each = var.api_diagnostic.backend_response == null ? [] : [""]
    content {
      body_bytes     = var.api_diagnostic.backend_response.body_bytes
      headers_to_log = var.api_diagnostic.backend_response.headers_to_log

      dynamic "data_masking" {
        for_each = var.api_diagnostic.backend_response.data_masking
        content {
          dynamic "query_params" {
            for_each = var.api_diagnostic.backend_response.data_masking.query_params
            content {
              mode  = var.api_diagnostic.backend_response.data_masking.query_params.mode
              value = var.api_diagnostic.backend_response.data_masking.query_params.value
            }
          }
          dynamic "headers" {
            for_each = var.api_diagnostic.backend_response.data_masking.headers
            content {
              mode  = var.api_diagnostic.backend_response.data_masking.headers.mode
              value = var.api_diagnostic.backend_response.data_masking.headers.value
            }
          }
        }
      }
    }
  }

  dynamic "frontend_request" {
    for_each = var.api_diagnostic.frontend_request == null ? [] : [""]
    content {
      body_bytes     = var.api_diagnostic.frontend_request.body_bytes
      headers_to_log = var.api_diagnostic.frontend_request.headers_to_log

      dynamic "data_masking" {
        for_each = var.api_diagnostic.frontend_request.data_masking
        content {
          dynamic "query_params" {
            for_each = var.api_diagnostic.frontend_request.data_masking.query_params
            content {
              mode  = var.api_diagnostic.frontend_request.data_masking.query_params.mode
              value = var.api_diagnostic.frontend_request.data_masking.query_params.value
            }
          }
          dynamic "headers" {
            for_each = var.api_diagnostic.frontend_request.data_masking.headers
            content {
              mode  = var.api_diagnostic.frontend_request.data_masking.headers.mode
              value = var.api_diagnostic.frontend_request.data_masking.headers.value
            }
          }
        }
      }
    }
  }

  dynamic "frontend_response" {
    for_each = var.api_diagnostic.frontend_response == null ? [] : [""]
    content {
      body_bytes     = var.api_diagnostic.frontend_response.body_bytes
      headers_to_log = var.api_diagnostic.frontend_response.headers_to_log

      dynamic "data_masking" {
        for_each = var.api_diagnostic.frontend_response.data_masking
        content {
          dynamic "query_params" {
            for_each = var.api_diagnostic.frontend_response.data_masking.query_params
            content {
              mode  = var.api_diagnostic.frontend_response.data_masking.query_params.mode
              value = var.api_diagnostic.frontend_response.data_masking.query_params.value
            }
          }
          dynamic "headers" {
            for_each = var.api_diagnostic.frontend_response.data_masking.headers
            content {
              mode  = var.api_diagnostic.frontend_response.data_masking.headers.mode
              value = var.api_diagnostic.frontend_response.data_masking.headers.value
            }
          }
        }
      }
    }
  }
}

resource "azurerm_api_management_api_operation" "this" {
  count               = var.api_management_api != null && var.api_operation == null ? 0 : 1
  api_management_name = azurerm_api_management_api.this.api_management_name
  api_name            = azurerm_api_management_api.this.name
  display_name        = var.api_operation.display_name
  method              = var.api_operation.method
  operation_id        = var.api_operation.operation_id
  resource_group_name = data.azurerm_resource_group.this.name
  url_template        = var.api_operation.url_template
  description         = var.api_operation.description
}

resource "azurerm_api_management_api_operation_policy" "this" {
  count               = var.api_operation != null
  api_management_name = azurerm_api_management_api_operation.this.api_management_name
  api_name            = azurerm_api_management_api_operation.this.api_name
  operation_id        = azurerm_api_management_api_operation.this.operation_id
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_api_management_api_operation_tag" "this" {
  for_each         = var.operation_tag
  api_operation_id = azurerm_api_management_api_operation.this.operation_id
  display_name     = each.value.display_name
  name             = each.key
}

resource "azurerm_api_management_api_policy" "this" {
  api_management_name = azurerm_api_management_api.this.api_management_name
  api_name            = azurerm_api_management_api.this.name
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_api_management_api_release" "this" {
  count  = var.api_management
  api_id = azurerm_api_management_api.this.id
  name   = join("-", [var.api_management.name, "release"])
}

resource "azurerm_api_management_api_schema" "this" {
  count               = var.api_management_api_schema && var.api_management_api != null
  api_management_name = azurerm_api_management_api.this.api_management_name
  api_name            = azurerm_api_management_api.this.name
  content_type        = var.api_management_api_schema.content_type
  resource_group_name = data.azurerm_resource_group.this.name
  schema_id           = var.api_management_api_schema.schema_id
  value               = file(join("/", [path.cwd, "api/schema", var.api_management_api_schema.value]))
  components          = var.api_management_api_schema.components
  definitions         = var.api_management_api_schema.definitions
}

resource "azurerm_api_management_api_tag" "this" {
  count  = var.api_management_api == null ? 0 : 1
  api_id = azurerm_api_management_api.this.id
  name   = azurerm_api_management_api.this.name
}

resource "azurerm_api_management_api_tag_description" "this" {
  count      = var.api_management_api == null ? 0 : 1
  api_tag_id = azurerm_api_management_api_tag.this.id
}

resource "azurerm_api_management_api_version_set" "this" {
  for_each            = var.api_version_set
  api_management_name = azurerm_api_management.this.name
  display_name        = each.value.display_name
  name                = each.key
  resource_group_name = data.azurerm_resource_group.this.name
  versioning_scheme   = each.value.versioning_scheme
  description         = each.value.description
  version_header_name = each.value.version_header_name
  version_query_name  = each.value.version_query_name
}

resource "azurerm_api_management_authorization_server" "this" {
  count                        = var.authorization_server == null ? 0 : 1 && var.api_management != null
  api_management_name          = azurerm_api_management.this.name
  authorization_endpoint       = var.authorization_server.authorization_endpoint
  authorization_methods        = var.authorization_server.authorization_methods
  client_id                    = var.authorization_server.client_id
  client_registration_endpoint = var.authorization_server.client_registration_endpoint
  display_name                 = var.authorization_server.display_name
  grant_types                  = var.authorization_server.grant_types
  name                         = var.authorization_server.name
  resource_group_name          = data.azurerm_resource_group.this.name
  bearer_token_sending_methods = var.authorization_server.bearer_token_sending_methods
  client_authentication_method = var.authorization_server.client_authentication_method
  client_secret                = sensitive(var.authorization_server.client_secret)
  default_scope                = var.authorization_server.default_scope
  description                  = var.authorization_server.description
  resource_owner_password      = sensitive(var.authorization_server.resource_owner_password)
  resource_owner_username      = sensitive(var.authorization_server.resource_owner_username)
  support_state                = var.authorization_server.support_state
  token_endpoint               = var.authorization_server.token_endpoint

  dynamic "token_body_parameter" {
    for_each = var.authorization_server.token_body_parameter == null ? [] : [""]
    content {
      name  = var.authorization_server.token_body_parameter.name
      value = var.authorization_server.token_body_parameter.value
    }
  }
}

resource "azurerm_api_management_backend" "this" {
  count               = var.backend == null ? 0 : 1 && var.api_management != null
  api_management_name = azurerm_api_management.this.name
  name                = var.backend.name
  protocol            = var.backend.protocol
  resource_group_name = data.azurerm_resource_group.this.name
  url                 = var.backend.url
  description         = var.backend.description
  resource_id         = var.backend.resource_id
  title               = var.backend.title

  dynamic "tls" {
    for_each = var.backend.tls == null ? [] : [""]
    content {
      validate_certificate_chain = var.backend.tls.validate_certificate_chain
      validate_certificate_name  = var.backend.tls.validate_certificate_name
    }
  }

  dynamic "service_fabric_cluster" {
    for_each = var.backend.service_fabric_cluster == null ? [] : [""]
    content {
      management_endpoints             = var.backend.service_fabric_cluster.management_endpoints
      max_partition_resolution_retries = var.backend.service_fabric_cluster.max_partition_resolution_retries
      client_certificate_thumbprint    = var.backend.service_fabric_cluster.client_certificate_thumbprint
      client_certificate_id            = var.backend.service_fabric_cluster.client_certificate_id
      server_certificate_thumbprints   = var.backend.service_fabric_cluster.server_certificate_thumbprints

      dynamic "server_x509_name" {
        for_each = var.backend.service_fabric_cluster.server_x509_name
        content {
          issuer_certificate_thumbprint = server_x509_name.value.issuer_certificate_thumbprint
          name                          = server_x509_name.key
        }
      }
    }
  }

  dynamic "proxy" {
    for_each = var.backend.proxy == null ? [] : [""]
    content {
      url      = var.backend.proxy.url
      username = var.backend.proxy.username
      password = sensitive(var.backend.proxy.password)
    }
  }

  dynamic "credentials" {
    for_each = var.backend.credentials == null ? [] : [""]
    content {
      certificate = var.backend.credentials.certificate
      header      = var.backend.credentials.header
      query       = var.backend.credentials.query

      dynamic "authorization" {
        for_each = var.backend.credentials.authorization == null ? [] : [""]
        content {
          parameter = var.backend.credentials.authorization.parameter
          scheme    = var.backend.credentials.authorization.scheme
        }
      }
    }
  }
}

resource "azurerm_api_management_certificate" "this" {
  count                        = var.certificate == null ? 0 : 1
  api_management_name          = azurerm_api_management.this.name
  name                         = var.certificate.name
  resource_group_name          = data.azurerm_resource_group.this.name
  data                         = var.keyvault_certificate_name == null ? join("/", [path.cwd, "certificate", filebase64(var.certificate.data)]) : [""]
  password                     = var.keyvault_certificate_name == null ? sensitive(var.certificate.password) : [""]
  key_vault_identity_client_id = var.keyvault_certificate_name != null ? data.azurerm_key_vault_certificate.this.id : [""]
  key_vault_secret_id          = var.keyvault_certificate_name != null ? data.azurerm_key_vault_certificate.this.secret_id : [""]
}

resource "azurerm_api_management_custom_domain" "this" {
  count             = var.custom_domain == null ? 0 : 1 && var.api_management != null
  api_management_id = azurerm_api_management.this.id

  dynamic "scm" {
    for_each = var.custom_domain.scm == null ? [] : [""]
    content {
      host_name                       = var.custom_domain.scm.host_name
      certificate                     = join("/", [path.cwd, "certificate", base64encode(var.custom_domain.scm.certificate)])
      certificate_password            = sensitive(var.custom_domain.scm.certificate_password)
      key_vault_id                    = var.custom_domain.scm.certificate == null ? data.azurerm_key_vault_certificate.this.id : [""]
      negotiate_client_certificate    = var.custom_domain.scm.negotiate_client_certificate
      ssl_keyvault_identity_client_id = var.custom_domain.scm.ssl_keyvault_identity_client_id
    }
  }

  dynamic "gateway" {
    for_each = var.custom_domain.gateway == null ? [] : [""]
    content {
      host_name                       = var.custom_domain.gateway.host_name
      certificate                     = join("/", [path.cwd, "certificate", base64encode(var.custom_domain.gateway.certificate)])
      certificate_password            = sensitive(var.custom_domain.gateway.certificate_password)
      key_vault_id                    = var.custom_domain.gateway.certificate == null ? data.azurerm_key_vault_certificate.this.id : [""]
      negotiate_client_certificate    = var.custom_domain.gateway.negotiate_client_certificate
      ssl_keyvault_identity_client_id = var.custom_domain.gateway.ssl_keyvault_identity_client_id
      default_ssl_binding             = var.custom_domain.gateway.default_ssl_binding
    }
  }

  dynamic "portal" {
    for_each = var.custom_domain.portal
    content {
      host_name                       = var.custom_domain.portal.host_name
      certificate                     = join("/", [path.cwd, "certificate", base64encode(var.custom_domain.portal.certificate)])
      certificate_password            = sensitive(var.custom_domain.portal.certificate_password)
      key_vault_id                    = var.custom_domain.portal.certificate == null ? data.azurerm_key_vault_certificate.this.id : [""]
      negotiate_client_certificate    = var.custom_domain.portal.negotiate_client_certificate
      ssl_keyvault_identity_client_id = var.custom_domain.portal.ssl_keyvault_identity_client_id
    }
  }

  dynamic "developer_portal" {
    for_each = var.custom_domain.developer_portal
    content {
      host_name                       = var.custom_domain.developer_portal.host_name
      certificate                     = join("/", [path.cwd, "certificate", base64encode(var.custom_domain.developer_portal.certificate)])
      certificate_password            = sensitive(var.custom_domain.developer_portal.certificate_password)
      key_vault_id                    = var.custom_domain.developer_portal.certificate == null ? data.azurerm_key_vault_certificate.this.id : [""]
      negotiate_client_certificate    = var.custom_domain.developer_portal.negotiate_client_certificate
      ssl_keyvault_identity_client_id = var.custom_domain.developer_portal.ssl_keyvault_identity_client_id
    }
  }

  dynamic "management" {
    for_each = var.custom_domain.management == null ? [] : [""]
    content {
      host_name                       = var.custom_domain.management.host_name
      certificate                     = join("/", [path.cwd, "certificate", base64encode(var.custom_domain.management.certificate)])
      certificate_password            = sensitive(var.custom_domain.management.certificate_password)
      key_vault_id                    = var.custom_domain.management.certificate == null ? data.azurerm_key_vault_certificate.this.id : [""]
      negotiate_client_certificate    = var.custom_domain.management.negotiate_client_certificate
      ssl_keyvault_identity_client_id = var.custom_domain.management.ssl_keyvault_identity_client_id
    }
  }
}


resource "azurerm_api_management_gateway" "this" {
  count             = var.gateway == null ? 0 : 1 && var.api_management != null
  api_management_id = azurerm_api_management.this.id
  name              = var.gateway.name
  description       = var.gateway.description

  dynamic "location_data" {
    for_each = var.gateway.location_data == null ? [] : [""]
    content {
      name     = var.gateway.location_data.name
      city     = var.gateway.location_data.city
      district = var.gateway.location_data.district
      region   = var.gateway.location_data.region
    }
  }
}

resource "azurerm_api_management_gateway_api" "this" {
  count      = var.gateway != null && var.api_management_api != null
  api_id     = azurerm_api_management_api.this.id
  gateway_id = azurerm_api_management_gateway.this.id
}

resource "azurerm_api_management_gateway_certificate_authority" "this" {
  count             = var.api_management != null && var.certificate != null && var.gateway != null
  api_management_id = azurerm_api_management.this.id
  certificate_name  = azurerm_api_management_certificate.this.name
  gateway_name      = azurerm_api_management_gateway.this.name
  is_trusted        = true
}

resource "azurerm_api_management_gateway_host_name_configuration" "this" {
  count                              = var.api_management != null && var.gateway != null && var.certificate != null && var.gateway_host_name_configuration == null ? 0 : 1
  api_management_id                  = azurerm_api_management.this.id
  certificate_id                     = azurerm_api_management_certificate.this.id
  gateway_name                       = azurerm_api_management_gateway.this.name
  host_name                          = var.gateway_host_name_configuration.host_name
  name                               = var.gateway_host_name_configuration.name
  request_client_certificate_enabled = true
  http2_enabled                      = true
  tls10_enabled                      = true
  tls11_enabled                      = true
}

resource "azurerm_api_management_group" "this" {
  count               = var.api_management_group == null ? 0 : 1 && var.api_management != null
  api_management_name = azurerm_api_management.this.name
  display_name        = var.api_management_group.display_name
  name                = var.api_management_group.name
  resource_group_name = data.azurerm_resource_group.this.name
  description         = var.api_management_group.description
  external_id         = var.api_management_group.external_id
  type                = var.api_management_group.type
}

resource "azurerm_api_management_user" "this" {
  count               = var.api_management_user == null ? 0 : 1 && var.api_management != null
  api_management_name = azurerm_api_management.this.name
  email               = var.api_management_user.email
  first_name          = var.api_management_user.first_name
  last_name           = var.api_management_user.last_name
  resource_group_name = data.azurerm_resource_group.this.name
  user_id             = var.api_management_user.user_id
  confirmation        = var.api_management_user.confirmation
  note                = var.api_management_user.note
  password            = sensitive(var.api_management_user.password)
  state               = var.api_management_user.state
}

resource "azurerm_api_management_group_user" "this" {
  count               = var.api_management != null && var.api_management_user != null && var.api_management_group != null
  api_management_name = azurerm_api_management.this.name
  group_name          = azurerm_api_management_group.this.name
  resource_group_name = data.azurerm_resource_group.this.name
  user_id             = azurerm_api_management_user.this.id
}

resource "azurerm_api_management_identity_provider_aad" "this" {
  count               = var.provider_aad == null ? 0 : 1 && var.api_management != null
  allowed_tenants     = var.provider_aad.allowed_tenants
  api_management_name = azurerm_api_management.this.name
  client_id           = var.provider_aad.client_id
  client_secret       = sensitive(var.provider_aad.client_secrets)
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_api_management_identity_provider_aadb2c" "this" {
  count                  = var.provider_aadb2c == null ? 0 : 1 && var.api_management != null
  allowed_tenant         = var.provider_aadb2c.allowed_tenant
  api_management_name    = azurerm_api_management.this.name
  authority              = var.provider_aadb2c.authority
  client_id              = var.provider_aadb2c.client_id
  client_secret          = sensitive(var.provider_aadb2c.client_secret)
  resource_group_name    = data.azurerm_resource_group.this.name
  signin_policy          = var.provider_aadb2c.signin_policy
  signin_tenant          = var.provider_aadb2c.signin_tenant
  signup_policy          = var.provider_aadb2c.signup_policy
  password_reset_policy  = var.provider_aadb2c.password_reset_policy
  profile_editing_policy = var.provider_aadb2c.profile_editing_policy
}

resource "azurerm_api_management_identity_provider_facebook" "this" {
  count               = var.provider_facebook == null ? 0 : 1 && var.api_management != null
  api_management_name = azurerm_api_management.this.name
  app_id              = var.provider_facebook.app_id
  app_secret          = sensitive(var.provider_facebook.app_secret)
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_api_management_identity_provider_google" "this" {
  count               = var.provider_google == null ? 0 : 1 && var.api_management != null
  api_management_name = azurerm_api_management.this.name
  client_id           = var.provider_google.client_id
  client_secret       = sensitive(var.provider_google.client_secret)
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_api_management_identity_provider_microsoft" "this" {
  count               = var.provider_microsoft == null ? 0 : 1 && var.api_management != null
  api_management_name = azurerm_api_management.this.name
  client_id           = var.provider_microsoft.client_id
  client_secret       = sensitive(var.provider_microsoft.client_secret)
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_api_management_identity_provider_twitter" "this" {
  count               = var.provider_twitter == null ? 0 : 1 && var.api_management != null
  api_key             = var.provider_twitter.api_key
  api_management_name = azurerm_api_management.this.name
  api_secret_key      = sensitive(var.provider_twitter.api_secret_key)
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_api_management_named_value" "this" {
  count               = var.named_value == null ? 0 : 1 && var.api_management != null
  api_management_name = azurerm_api_management.this.name
  display_name        = var.named_value.display_value
  name                = var.named_value.name
  resource_group_name = data.azurerm_resource_group.this.name
  value               = var.named_value.value
  secret              = var.named_value.secret
  tags                = var.named_value.tags

  dynamic "value_from_key_vault" {
    for_each = var.named_value.value_from_key_vault
    content {
      secret_id          = var.named_value.value_from_key_vault.secret_id
      identity_client_id = var.named_value.value_from_key_vault.identity_client_id
    }
  }
}

resource "azurerm_api_management_notification_recipient_email" "this" {
  count             = var.notification_recipient_email == null ? 0 : 1 && var.api_management != null
  api_management_id = azurerm_api_management.this.id
  email             = var.notification_recipient_email.email
  notification_type = var.notification_recipient_email.notification_type
}

resource "azurerm_api_management_notification_recipient_user" "this" {
  count             = var.notification_recipient_user == null ? 0 : 1 && var.api_management != null
  api_management_id = azurerm_api_management.this.id
  notification_type = var.notification_recipient_user.notification_type
  user_id           = var.notification_recipient_user.user_id
}

resource "azurerm_api_management_openid_connect_provider" "this" {
  count               = var.openid_connect_provider == null ? 0 : 1 && var.api_management != null
  api_management_name = azurerm_api_management.this.name
  client_id           = var.openid_connect_provider.client_id
  client_secret       = sensitive(var.openid_connect_provider.client_secret)
  display_name        = var.openid_connect_provider.display_name
  metadata_endpoint   = var.openid_connect_provider.metadata_endpoint
  name                = var.openid_connect_provider.name
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_api_management_policy" "this" {
  count             = var.api_management_policy != null ? 0 : 1 && var.api_management != null
  api_management_id = azurerm_api_management.this.name
  xml_content       = join("/", [path.cwd, "policies", file(var.api_management_policy.xml_content)])
  xml_link          = var.api_management_policy.xml_link
}

resource "azurerm_api_management_product" "this" {
  count                 = var.api_management_product == null ? 0 : 1 && var.api_management != null
  api_management_name   = azurerm_api_management.this.name
  display_name          = var.api_management_product.display_name
  product_id            = var.api_management_product.product_id
  published             = var.api_management_product.published
  resource_group_name   = data.azurerm_resource_group.this.name
  approval_required     = var.api_management_product.approval_required
  subscription_required = var.api_management_product.subscription_required
  subscriptions_limit   = var.api_management_product.subscription_limit
  terms                 = var.api_management_product.terms
}

resource "azurerm_api_management_product_api" "this" {
  count               = var.api_management_product != null && var.api_management_api != null && var.api_management != null
  api_management_name = azurerm_api_management.this.name
  api_name            = azurerm_api_management_api.this.name
  product_id          = azurerm_api_management_product.this.product_id
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_api_management_product_group" "this" {
  count               = var.api_management_product != null && var.api_management_api != null && var.api_management != null
  api_management_name = azurerm_api_management.this.name
  group_name          = join("-", [azurerm_api_management_product, "group"])
  product_id          = azurerm_api_management_product.this.product_id
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_api_management_product_policy" "this" {
  count               = var.product_policy == null ? 0 : 1 && var.api_management_product != null
  api_management_name = azurerm_api_management_product.this.api_management_name
  product_id          = azurerm_api_management_product.this.product_id
  resource_group_name = data.azurerm_resource_group.this.name
  xml_content         = var.product_policy.xml_content
  xml_link            = var.product_policy.xml_link
}

resource "azurerm_api_management_product_tag" "this" {
  count                     = var.product_tag == null ? 0 : 1 && var.api_management_product != null
  api_management_name       = azurerm_api_management.this.name
  api_management_product_id = azurerm_api_management_product.this.product_id
  name                      = var.product_tag.name
  resource_group_name       = data.azurerm_resource_group.this.name
}

resource "azurerm_api_management_redis_cache" "this" {
  count             = var.api_management_redis_cache == null ? 0 : 1 && var.redis_cache != null && var.api_management != null
  api_management_id = azurerm_api_management_product.this.id
  connection_string = data.azurerm_redis_cache.this.primary_connection_string
  name              = var.api_management_redis_cache.name
  description       = var.api_management_redis_cache.description
  redis_cache_id    = data.azurerm_redis_cache.this.id
  cache_location    = var.api_management_redis_cache.cache_location
}

resource "azurerm_api_management_global_schema" "this" {
  count               = var.global_schema == null ? 0 : 1 && var.api_management != null
  api_management_name = azurerm_api_management.this.name
  resource_group_name = data.azurerm_resource_group.this.name
  schema_id           = var.global_schema.schema_id
  type                = var.global_schema.type
  value               = var.global_schema.value
}

resource "azurerm_api_management_subscription" "this" {
  count               = var.subscription == null ? 0 : 1 && var.api_management != null
  api_management_name = azurerm_api_management.this.name
  resource_group_name = data.azurerm_resource_group.this.name
  display_name        = var.subscription.display_name
  product_id          = azurerm_api_management_product.this.id
  user_id             = azurerm_api_management_user.this.id
  api_id              = azurerm_api_management_api.this.id
  primary_key         = var.subscription.primary_key
  secondary_key       = var.subscription.secondary_key
  state               = var.subscription.state
  subscription_id     = var.subscription.subscription_id
  allow_tracing       = true
}

resource "azurerm_api_management_tag" "this" {
  count             = var.api_management_tag == null ? 0 : 1 && var.api_management != null
  api_management_id = azurerm_api_management.this.id
  name              = var.api_management_tag.name
}