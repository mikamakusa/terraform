resource "azurerm_api_management" "this" {
  count               = length(var.api_management)
  location            = data.azurerm_resource_group.this.location
  name                = join("-", [lookup(var.api_management[count.index], "name"), "api_management"])
  publisher_email     = lookup(var.api_management[count.index], "publisher_email")
  publisher_name      = lookup(var.api_management[count.index], "publisher_name")
  resource_group_name = data.azurerm_resource_group.this.name
  sku_name            = lookup(var.api_management[count.index], "sku_name")
}

resource "azurerm_api_management_api" "this" {
  count = length(var.api_management_api) == "0" ? "0" : length(var.api_management)
  api_management_name = try(
    element(azurerm_api_management.this.*.id, lookup(var.api_management_api[count.index], "api_management_id"))
  )
  name                  = lookup(var.api_management_api[count.index], "name")
  resource_group_name   = data.azurerm_resource_group.this.name
  revision              = lookup(var.api_management_api[count.index], "revision")
  api_type              = lookup(var.api_management_api[count.index], "api_type")
  display_name          = lookup(var.api_management_api[count.index], "display_name")
  path                  = lookup(var.api_management_api[count.index], "path")
  protocols             = lookup(var.api_management_api[count.index], "protocols")
  description           = lookup(var.api_management_api[count.index], "description")
  service_url           = lookup(var.api_management_api[count.index], "service_url")
  subscription_required = lookup(var.api_management_api[count.index], "subscription_required")
  terms_of_service_url  = lookup(var.api_management_api[count.index], "terms_of_service_url")
  version               = lookup(var.api_management_api[count.index], "version")
  version_set_id        = lookup(var.api_management_api[count.index], "version_set_id")
  revision_description  = lookup(var.api_management_api[count.index], "revision_description")
  version_description   = lookup(var.api_management_api[count.index], "version_description")
  source_api_id         = lookup(var.api_management_api[count.index], "source_api_id")

  dynamic "subscription_key_parameter_names" {
    for_each = lookup(var.api_management_api[count.index], "subscription_key_parameter_names") == null ? [] : ["subscription_key_parameter_names"]
    content {
      header = lookup(subscription_key_parameter_names.value, "header")
      query  = lookup(subscription_key_parameter_names.value, "query")
    }
  }

  dynamic "import" {
    for_each = lookup(var.api_management_api[count.index], "import") == null ? [] : ["import"]
    content {
      content_format = lookup(import.value, "content_format")
      content_value  = lookup(import.value, "content_value")

      dynamic "wsdl_selector" {
        for_each = lookup(import.value, "wsdl_selector") == null ? [] : ["wsdl_selector"]
        content {
          endpoint_name = lookup(wsdl_selector.value, "endpoint_name")
          service_name  = lookup(wsdl_selector.value, "service_name")
        }
      }
    }
  }

  dynamic "license" {
    for_each = lookup(var.api_management_api[count.index], "license") == null ? [] : ["license"]
    content {
      name = lookup(license.value, "name")
      url  = lookup(license.value, "url")
    }
  }

  dynamic "oauth2_authorization" {
    for_each = lookup(var.api_management_api[count.index], "oauth2_authorization") == null ? [] : ["oauth2_authorization"]
    content {
      authorization_server_name = lookup(oauth2_authorization.value, "authorization_server_name")
      scope                     = lookup(oauth2_authorization.value, "scope")
    }
  }

  dynamic "openid_authentication" {
    for_each = lookup(var.api_management_api[count.index], "openid_authentication") == null ? [] : ["openid_authentication"]
    content {
      openid_provider_name         = lookup(openid_authentication.value, "openid_provider_name")
      bearer_token_sending_methods = lookup(openid_authentication.value, "bearer_token_sending_methods")
    }
  }

  dynamic "contact" {
    for_each = lookup(var.api_management_api[count.index], "contact") == null ? [] : ["contact"]
    content {
      email = lookup(contact.value, "email")
      name  = lookup(contact.value, "name")
      url   = lookup(contact.value, "url")
    }
  }
}

resource "azurerm_api_management_logger" "this" {
  count = length(var.api_management_logger) == "0" ? "0" : length(var.api_management)
  api_management_name = try(
    element(azurerm_api_management.this.*.name, lookup(var.api_management_logger[count.index], "api_management_id"))
  )
  name                = lookup(var.api_management_logger[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.name
  buffered            = lookup(var.api_management_logger[count.index], "buffered")
  description         = lookup(var.api_management_logger[count.index], "description")
  resource_id         = lookup(var.api_management_logger[count.index], "resource_id")

  dynamic "eventhub" {
    for_each = lookup(var.api_management_logger[count.index], "eventhub") == null ? [] : ["eventhub"]
    content {
      connection_string = lookup(eventhub.value, "connection_string")
      name              = lookup(eventhub.value, "name")
    }
  }

  dynamic "application_insights" {
    for_each = lookup(var.api_management_logger[count.index], "application_insights") == null ? [] : ["application_insights"]
    content {
      instrumentation_key = lookup(application_insights.value, "instrumentation_key")
    }
  }
}

resource "azurerm_api_management_api_diagnostic" "this" {
  count = length(var.api_diagnostic) == "0" ? "0" : length(var.api_management_logger) && length(var.api_management)
  api_management_logger_id = try(
    element(azurerm_api_management_logger.this.*.id, lookup(var.api_diagnostic[count.index], "api_management_logger_id"))
  )
  api_management_name = try(
    element(azurerm_api_management.this.*.name, lookup(var.api_diagnostic[count.index], "api_management_id"))
  )
  api_name = try(
    element(azurerm_api_management_api.this.*.name, lookup(var.api_diagnostic[count.index], "api_management_id"))
  )
  identifier            = lookup(var.api_diagnostic[count.index], "identifier")
  resource_group_name   = data.azurerm_resource_group.this.name
  always_log_errors     = lookup(var.api_diagnostic[count.index], "always_log_errors")
  log_client_ip         = lookup(var.api_diagnostic[count.index], "log_client_ip")
  sampling_percentage   = lookup(var.api_diagnostic[count.index], "sampling_percentage")
  verbosity             = lookup(var.api_diagnostic[count.index], "verbosity")
  operation_name_format = lookup(var.api_diagnostic[count.index], "operation_name_format")

  dynamic "backend_request" {
    for_each = lookup(var.api_diagnostic[count.index], "backend_request") == null ? [] : ["backend_request"]
    content {
      body_bytes     = lookup(backend_request.value, "body_bytes")
      headers_to_log = lookup(backend_request.value, "headers_to_log")

      dynamic "data_masking" {
        for_each = lookup(backend_request.value, "data_masking") == null ? [] : ["data_masking"]
        content {
          dynamic "query_params" {
            for_each = lookup(data_masking.value, "query_params") == null ? [] : ["query_params"]
            content {
              mode  = lookup(query_params.value, "mode")
              value = lookup(query_params.value, "value")
            }
          }
          dynamic "headers" {
            for_each = var.api_diagnostic.backend_request.data_masking.headers == null ? [] : ["headers"]
            content {
              mode  = lookup(headers.value, "mode")
              value = lookup(headers.value, "value")
            }
          }
        }
      }
    }
  }

  dynamic "backend_response" {
    for_each = lookup(var.api_diagnostic[count.index], "backend_response") == null ? [] : ["backend_response"]
    content {
      body_bytes     = lookup(backend_response.value, "body_bytes")
      headers_to_log = lookup(backend_response.value, "headers_to_log")

      dynamic "data_masking" {
        for_each = lookup(backend_response.value, "data_masking") == null ? [] : ["data_masking"]
        content {
          dynamic "query_params" {
            for_each = lookup(data_masking.value, "query_params") == null ? [] : ["query_params"]
            content {
              mode  = lookup(query_params.value, "mode")
              value = lookup(query_params.value, "value")
            }
          }
          dynamic "headers" {
            for_each = lookup(data_masking.value, "headers") == null ? [] : ["headers"]
            content {
              mode  = lookup(headers.value, "mode")
              value = lookup(headers.value, "value")
            }
          }
        }
      }
    }
  }

  dynamic "frontend_request" {
    for_each = lookup(var.api_diagnostic[count.index], "frontend_request") == null ? [] : [""]
    content {
      body_bytes     = lookup(frontend_request.value, "body_bytes")
      headers_to_log = lookup(frontend_request.value, "headers_to_log")

      dynamic "data_masking" {
        for_each = lookup(frontend_request.value, "data_masking")
        content {
          dynamic "query_params" {
            for_each = lookup(data_masking.value, "query_params")
            content {
              mode  = lookup(query_params.value, "mode")
              value = lookup(query_params.value, "value")
            }
          }
          dynamic "headers" {
            for_each = lookup(data_masking.value, "headers")
            content {
              mode  = lookup(headers.value, "mode")
              value = lookup(headers.value, "value")
            }
          }
        }
      }
    }
  }

  dynamic "frontend_response" {
    for_each = lookup(var.api_diagnostic[count.index], "frontend_response") == null ? [] : [""]
    content {
      body_bytes     = lookup(frontend_response.value, "body_bytes")
      headers_to_log = lookup(frontend_response.value, "headers_to_log")

      dynamic "data_masking" {
        for_each = lookup(frontend_response.value, "data_masking")
        content {
          dynamic "query_params" {
            for_each = lookup(data_masking.value, "query_params")
            content {
              mode  = lookup(query_params.value, "mode")
              value = lookup(query_params.value, "value")
            }
          }
          dynamic "headers" {
            for_each = lookup(data_masking.value, "headers")
            content {
              mode  = lookup(headers.value, "mode")
              value = lookup(headers.value, "value")
            }
          }
        }
      }
    }
  }
}

resource "azurerm_api_management_api_operation" "this" {
  count = length(var.api_operation) == "0" ? "0" : length(var.api_management_api)
  api_management_name = try(
    element(azurerm_api_management_api.this.*.api_management_name, lookup(var.api_operation[count.index], "api_management_id"))
  )
  api_name = try(
    element(azurerm_api_management_api.this.*.name, lookup(var.api_operation[count.index], "api_management_id"))
  )
  display_name = lookup(var.api_operation[count.index], "display_name")
  method       = lookup(var.api_operation[count.index], "method")
  operation_id = lookup(var.api_operation[count.index], "operation_id")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  url_template = lookup(var.api_operation[count.index], "url_template")
  description  = lookup(var.api_operation[count.index], "description")
}

resource "azurerm_api_management_api_operation_policy" "this" {
  count = length(length(var.api_operation_policy)) == "0" ? "0" : length(var.api_operation)
  api_management_name = try(
    element(azurerm_api_management_api_operation.this.*.api_management_name, lookup(var.api_operation_policy[count.index], "api_management_id"))
  )
  api_name = try(
    element(azurerm_api_management_api_operation.this.*.api_name, lookup(var.api_operation_policy[count.index], "api_management_id"))
  )
  operation_id = try(
    element(azurerm_api_management_api_operation.this.*.operation_id, lookup(var.api_operation_policy[count.index], "api_management_id"))
  )
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
}

resource "azurerm_api_management_api_operation_tag" "this" {
  count = length(var.operation_tag) == "0" ? "0" : length(var.api_operation)
  api_operation_id = try(
    element(azurerm_api_management_api_operation.this.*.operation_id, lookup(var.operation_tag[count.index], "api_operation_id"))
  )
  display_name = lookup(var.operation_tag[count.index], "display_name")
  name         = lookup(var.operation_tag[count.index], "name")
}

resource "azurerm_api_management_api_policy" "this" {
  count = length(var.api_policy) == "0" ? "0" : length(var.api_management_api)
  api_management_name = try(
    element(azurerm_api_management_api.this.*.api_management_name, lookup(var.api_policy[count.index], "management_api_id"))
  )
  api_name = try(
    element(azurerm_api_management_api.this.*.name, lookup(var.api_policy[count.index], "management_api_id"))
  )
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
}

resource "azurerm_api_management_api_release" "this" {
  count = length(var.api_release) == "0" ? "0" : length(var.api_management)
  api_id = try(
    element(azurerm_api_management_api.this.id, lookup(var.api_release[count.index], "api_management_id"))
  )
  name  = join("-", [lookup(var.api_release[count.index], "name"), "release"])
  notes = lookup(var.api_release[count.index], "notes")
}

resource "azurerm_api_management_api_schema" "this" {
  count               = length(var.api_management_api_schema) == "0" ? "0" : length(var.api_management_api)
  api_management_name = try(
    element(azurerm_api_management_api.this.*.api_management_name, lookup(var.api_management_api_schema[count.index], "api_management_id"))
  )
  api_name            = try(
    element(azurerm_api_management_api.this.*.name, lookup(var.api_management_api_schema[count.index], "api_management_id"))
  )
  content_type        = lookup(var.api_management_api_schema[count.index], "content_type")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  schema_id           = try(
    element(var.api_management_api_schema.*.schema_id, lookup(var.api_management_api_schema[count.index], "schema_id"))
  )
  value               = file(join("/", [path.cwd, "api/schema", lookup(var.api_management_api_schema[count.index], "value")]))
  components          = lookup(var.api_management_api_schema[count.index], "components")
  definitions         = lookup(var.api_management_api_schema[count.index], "definitions")
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