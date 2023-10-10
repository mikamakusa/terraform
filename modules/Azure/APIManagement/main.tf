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