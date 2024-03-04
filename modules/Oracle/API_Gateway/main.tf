resource "oci_apigateway_api" "this" {
  count          = length(var.api)
  compartment_id = var.compartment_id
  content        = lookup(var.api[count.index], "content")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.api[count.index], "defined_tags")
  )
  display_name = lookup(var.api[count.index], "display_name")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.api[count.index], "freeform_tags")
  )
}

resource "oci_apigateway_certificate" "this" {
  count          = length(var.certificate)
  certificate    = lookup(var.certificate[count.index], "certificate")
  compartment_id = data.oci_identity_compartment.this.compartment_id
  private_key    = lookup(var.certificate[count.index], "private_key")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.certificate[count.index], "defined_tags")
  )
  display_name = lookup(var.certificate[count.index], "display_name")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.certificate[count.index], "freeform_tags")
  )
  intermediate_certificates = lookup(var.certificate[count.index], "intermediate_certificates")
}

resource "oci_apigateway_deployment" "this" {
  count          = length(var.deployment) == "0" ? "0" : length(var.gateway)
  compartment_id = data.oci_identity_compartment.this.compartment_id
  gateway_id = try(
    data.oci_apigateway_gateway.this.gateway_id,
    element(oci_apigateway_gateway.this.*.id, lookup(var.deployment[count.index], "gateway_id"))
  )
  path_prefix  = lookup(var.deployment[count.index], "path_prefix")
  display_name = lookup(var.deployment[count.index], "display_name")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.deployment[count.index], "defined_tags")
  )
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.deployment[count.index], "freeform_tags")
  )

  dynamic "specification" {
    for_each = lookup(var.deployment[count.index], "specification") == null ? [] : ["specification"]
    content {
      dynamic "logging_policies" {
        for_each = lookup(specification.value, "logging_policies") == null ? [] : ["logging_policies"]
        content {
          dynamic "access_log" {
            for_each = lookup(logging_policies.value, "access_log") == null ? [] : ["access_log"]
            content {
              is_enabled = lookup(access_log.value, "is_enabled")
            }
          }
          dynamic "execution_log" {
            for_each = lookup(logging_policies.value, "execution_log") == null ? [] : ["execution_log"]
            content {
              is_enabled = lookup(execution_log.value, "is_enabled")
              log_level  = lookup(execution_log.value, "log_level")
            }
          }
        }
      }
      dynamic "request_policies" {
        for_each = lookup(specification.value, "request_policies") == null ? [] : ["request_policies"]
        content {
          dynamic "authentication" {
            for_each = lookup(request_policies.value, "authentication") == null ? [] : ["authentication"]
            content {
              type                        = lookup(authentication.value, "type")
              audiences                   = lookup(authentication.value, "audiences")
              cache_key                   = lookup(authentication.value, "cache_key")
              function_id                 = lookup(authentication.value, "function_id")
              is_anonymous_access_allowed = lookup(authentication.value, "is_anonymous_access_allowed")
              issuers                     = lookup(authentication.value, "issuers")
              max_clock_skew_in_seconds   = lookup(authentication.value, "max_clock_skew_in_seconds")
              parameters                  = lookup(authentication.value, "parameters")
              token_auth_scheme           = lookup(authentication.value, "token_auth_scheme")
              token_header                = lookup(authentication.value, "token_header")
              token_query_param           = lookup(authentication.value, "token_query_param")

              dynamic "public_keys" {
                for_each = lookup(authentication.value, "public_keys") == null ? [] : ["public_keys"]
                content {
                  type                        = lookup(public_keys.value, "type")
                  is_ssl_verify_disabled      = lookup(public_keys.value, "is_ssl_verify_disabled")
                  max_cache_duration_in_hours = lookup(public_keys.value, "max_cache_duration_in_hours")
                  uri                         = lookup(public_keys.value, "uri")

                  dynamic "keys" {
                    for_each = lookup(public_keys.value, "keys") == null ? [] : ["keys"]
                    content {
                      format  = lookup(keys.value, "format")
                      alg     = lookup(keys.value, "alg")
                      e       = lookup(keys.value, "e")
                      key     = lookup(keys.value, "key")
                      key_ops = lookup(keys.value, "key_ops")
                      kid     = lookup(keys.value, "kid")
                      kty     = lookup(keys.value, "kty")
                      use     = lookup(keys.value, "use")
                    }
                  }
                }
              }

              dynamic "validation_failure_policy" {
                for_each = lookup(authentication.value, "validation_failure_policy") == null ? [] : ["validation_failure_policy"]
                content {
                  type                               = lookup(validation_failure_policy.value, "type")
                  fallback_redirect_path             = lookup(validation_failure_policy.value, "fallback_redirect_path")
                  logout_path                        = lookup(validation_failure_policy.value, "logout_path")
                  max_expiry_duration_in_hours       = lookup(validation_failure_policy.value, "max_expiry_duration_in_hours")
                  response_code                      = lookup(validation_failure_policy.value, "response_code")
                  response_message                   = lookup(validation_failure_policy.value, "response_message")
                  response_type                      = lookup(validation_failure_policy.value, "response_type")
                  scopes                             = lookup(validation_failure_policy.value, "scopes")
                  use_cookies_for_intermediate_steps = lookup(validation_failure_policy.value, "use_cookies_for_intermediate_steps")
                  use_cookies_for_session            = lookup(validation_failure_policy.value, "use_cookies_for_session")
                  use_pkce                           = lookup(validation_failure_policy.value, "use_pkce")

                  dynamic "client_details" {
                    for_each = lookup(validation_failure_policy.value, "client_details") == null ? [] : ["client_details"]
                    content {
                      type                         = lookup(client_details.value, "type")
                      client_id                    = lookup(client_details.value, "client_id")
                      client_secret_id             = lookup(client_details.value, "client_secret_id")
                      client_secret_version_number = lookup(client_details.value, "client_secret_version_number")
                    }
                  }

                  dynamic "response_header_transformations" {
                    for_each = lookup(validation_failure_policy.value, "response_header_transformations") == null ? [] : ["response_header_transformations"]
                    content {
                      dynamic "filter_headers" {
                        for_each = lookup(response_header_transformations.value, "filter_headers") == null ? [] : ["filter_headers"]
                        content {
                          dynamic "items" {
                            for_each = lookup(filter_headers.value, "items") == null ? [] : ["items"]
                            content {
                              name = lookup(items.value, "name")
                            }
                          }
                          type = lookup(filter_headers.value, "type")
                        }
                      }
                      dynamic "rename_headers" {
                        for_each = lookup(response_header_transformations.value, "rename_headers") == null ? [] : ["rename_headers"]
                        content {
                          dynamic "items" {
                            for_each = lookup(rename_headers.value, "items") == null ? [] : ["items"]
                            content {
                              from = lookup(items.value, "from")
                              to   = lookup(items.value, "to")
                            }
                          }
                        }
                      }
                      dynamic "set_headers" {
                        for_each = lookup(response_header_transformations.value, "set_headers") == null ? [] : ["set_headers"]
                        content {
                          dynamic "items" {
                            for_each = lookup(set_headers.value, "items") == null ? [] : ["items"]
                            content {
                              if_exists = lookup(items.value, "if_exists")
                              name      = lookup(items.value, "name")
                              values    = lookup(items.value, "values")
                            }
                          }
                        }
                      }
                    }
                  }

                  dynamic "source_uri_details" {
                    for_each = lookup(validation_failure_policy.value, "source_uri_details") == null ? [] : ["source_uri_details"]
                    content {
                      type = lookup(source_uri_details.value, "type")
                      uri  = lookup(source_uri_details.value, "uri")
                    }
                  }

                }
              }
              dynamic "validation_policy" {
                for_each = lookup(authentication.value, "validation_policy") == null ? [] : ["validation_policy"]
                content {
                  type                        = lookup(validation_policy.value, "type")
                  is_ssl_verify_disabled      = lookup(validation_policy.value, "is_ssl_verify_disabled")
                  max_cache_duration_in_hours = lookup(validation_policy.value, "max_cache_duration_in_hours")

                  dynamic "additional_validation_policy" {
                    for_each = lookup(validation_policy.value, "additional_validation_policy") == null ? [] : ["additional_validation_policy"]
                    content {
                      audiences = lookup(additional_validation_policy.value, "audiences")
                      issuers   = lookup(additional_validation_policy.value, "issuers")
                      dynamic "verify_claims" {
                        for_each = lookup(additional_validation_policy.value, "verify_claims")
                        content {
                          is_required = lookup(verify_claims.value, "is_required")
                          key         = lookup(verify_claims.value, "key")
                          values      = lookup(verify_claims.value, "values")
                        }
                      }
                    }
                  }

                  dynamic "client_details" {
                    for_each = lookup(validation_policy.value, "client_details") == null ? [] : ["client_details"]
                    content {
                      type                         = lookup(client_details.value, "type")
                      client_id                    = lookup(client_details.value, "client_id")
                      client_secret_id             = lookup(client_details.value, "client_secret_id")
                      client_secret_version_number = lookup(client_details.value, "client_secret_version_number")
                    }
                  }

                  dynamic "keys" {
                    for_each = lookup(validation_policy.value, "keys") == null ? [] : ["keys"]
                    content {
                      format  = lookup(keys.value, "format")
                      alg     = lookup(keys.value, "alg")
                      e       = lookup(keys.value, "e")
                      key     = lookup(keys.value, "key")
                      key_ops = lookup(keys.value, "key_ops")
                      kid     = lookup(keys.value, "kid")
                      kty     = lookup(keys.value, "kty")
                      use     = lookup(keys.value, "use")
                    }
                  }

                  dynamic "source_uri_details" {
                    for_each = lookup(validation_policy.value, "source_uri_details") == null ? [] : ["source_uri_details"]
                    content {
                      type = lookup(source_uri_details.value, "type")
                      uri  = lookup(source_uri_details.value, "uri")
                    }
                  }
                }
              }
            }
          }
          dynamic "cors" {
            for_each = lookup(request_policies.value, "cors") == null ? [] : ["cors"]
            content {
              allowed_origins              = lookup(cors.value, "allowed_origins")
              allowed_headers              = lookup(cors.value, "allowed_headers")
              allowed_methods              = lookup(cors.value, "allowed_methods")
              exposed_headers              = lookup(cors.value, "exposed_headers")
              is_allow_credentials_enabled = lookup(cors.value, "is_allow_credentials_enabled")
              max_age_in_seconds           = lookup(cors.value, "max_age_in_seconds")
            }
          }
          dynamic "dynamic_authentication" {
            for_each = lookup(request_policies.value, "dynamic_authentication") == null ? [] : ["dynamic_authentication"]
            content {
              dynamic "authentication_servers" {
                for_each = lookup(dynamic_authentication.value, "authentication_servers") == null ? [] : ["authentication_servers"]
                content {
                  dynamic "authentication_server_detail" {
                    for_each = lookup(authentication_servers.value, "authentication_server_detail") == null ? [] : ["authentication_server_detail"]
                    content {
                      type                        = lookup(authentication_server_detail.value, "type")
                      audiences                   = lookup(authentication_server_detail.value, "audiences")
                      function_id                 = lookup(authentication_server_detail.value, "function_id")
                      is_anonymous_access_allowed = lookup(authentication_server_detail.value, "is_anonymous_access_allowed")
                      issuers                     = lookup(authentication_server_detail.value, "issuers")
                      max_clock_skew_in_seconds   = lookup(authentication_server_detail.value, "max_clock_skew_in_seconds")
                      parameters                  = lookup(authentication_server_detail.value, "parameters")
                      token_auth_scheme           = lookup(authentication_server_detail.value, "token_auth_scheme")
                      token_header                = lookup(authentication_server_detail.value, "token_header")
                      token_query_param           = lookup(authentication_server_detail.value, "token_query_param")
                      cache_key                   = lookup(authentication_server_detail.value, "cache_key")

                      dynamic "public_keys" {
                        for_each = lookup(authentication_server_detail.value, "public_keys") == null ? [] : ["public_keys"]
                        content {
                          type                        = lookup(public_keys.value, "type")
                          is_ssl_verify_disabled      = lookup(public_keys.value, "is_ssl_verify_disabled")
                          max_cache_duration_in_hours = lookup(public_keys.value, "max_cache_duration_in_hours")
                          uri                         = lookup(public_keys.value, "uri")
                          dynamic "keys" {
                            for_each = lookup(public_keys.value, "keys") == null ? [] : ["keys"]
                            content {
                              format  = lookup(keys.value, "format")
                              alg     = lookup(keys.value, "alg")
                              e       = lookup(keys.value, "e")
                              key     = lookup(keys.value, "key")
                              key_ops = lookup(keys.value, "key_ops")
                              kid     = lookup(keys.value, "kid")
                              kty     = lookup(keys.value, "kty")
                              use     = lookup(keys.value, "use")
                            }
                          }
                        }
                      }

                      dynamic "validation_failure_policy" {
                        for_each = lookup(authentication_server_detail.value, "validation_failure_policy") == null ? [] : ["validation_failure_policy"]
                        content {
                          type                               = lookup(validation_failure_policy.value, "type")
                          fallback_redirect_path             = lookup(validation_failure_policy.value, "fallback_redirect_path")
                          logout_path                        = lookup(validation_failure_policy.value, "logout_path")
                          max_expiry_duration_in_hours       = lookup(validation_failure_policy.value, "max_expiry_duration_in_hours")
                          response_code                      = lookup(validation_failure_policy.value, "response_code")
                          response_message                   = lookup(validation_failure_policy.value, "response_message")
                          response_type                      = lookup(validation_failure_policy.value, "response_type")
                          scopes                             = lookup(validation_failure_policy.value, "scopes")
                          use_cookies_for_intermediate_steps = lookup(validation_failure_policy.value, "use_cookies_for_intermediate_steps")
                          use_cookies_for_session            = lookup(validation_failure_policy.value, "use_cookies_for_session")
                          use_pkce                           = lookup(validation_failure_policy.value, "use_pkce")

                          dynamic "client_details" {
                            for_each = lookup(validation_failure_policy.value, "client_details") == null ? [] : ["client_details"]
                            content {
                              type                         = lookup(client_details.value, "type")
                              client_id                    = lookup(client_details.value, "client_id")
                              client_secret_id             = lookup(client_details.value, "client_secret_id")
                              client_secret_version_number = lookup(client_details.value, "client_secret_version_number")
                            }
                          }

                          dynamic "response_header_transformations" {
                            for_each = lookup(validation_failure_policy.value, "response_header_transformations") == null ? [] : ["response_header_transformations"]
                            content {
                              dynamic "filter_headers" {
                                for_each = lookup(response_header_transformations.value, "filter_headers") == null ? [] : ["filter_headers"]
                                content {
                                  dynamic "items" {
                                    for_each = lookup(filter_headers.value, "items")
                                    content {
                                      name = lookup(items.value, "name")
                                    }
                                  }
                                  type = lookup(filter_headers.value, "type")
                                }
                              }
                              dynamic "rename_headers" {
                                for_each = lookup(response_header_transformations.value, "rename_headers") == null ? [] : ["rename_headers"]
                                content {
                                  dynamic "items" {
                                    for_each = lookup(rename_headers.value, "items") == null ? [] : ["items"]
                                    content {
                                      from = lookup(items.value, "from")
                                      to   = lookup(items.value, "to")
                                    }
                                  }
                                }
                              }
                              dynamic "set_headers" {
                                for_each = lookup(response_header_transformations.value, "set_headers") == null ? [] : ["set_headers"]
                                content {
                                  dynamic "items" {
                                    for_each = lookup(set_headers.value, "items") == null ? [] : ["items"]
                                    content {
                                      if_exists = lookup(items.value, "if_exists")
                                      name      = lookup(items.value, "name")
                                      values    = lookup(items.value, "values")
                                    }
                                  }
                                }
                              }
                            }
                          }

                          dynamic "source_uri_details" {
                            for_each = lookup(validation_failure_policy.value, "source_uri_details") == null ? [] : ["source_uri_details"]
                            content {
                              type = lookup(source_uri_details.value, "type")
                              uri  = lookup(source_uri_details.value, "uri")
                            }
                          }
                        }
                      }
                      dynamic "validation_policy" {
                        for_each = lookup(authentication_server_detail.value, "validation_policy") == null ? [] : ["validation_policy"]
                        content {
                          type                        = lookup(validation_policy.value, "type")
                          uri                         = lookup(validation_policy.value, "uri")
                          is_ssl_verify_disabled      = lookup(validation_policy.value, "is_ssl_verify_disabled")
                          max_cache_duration_in_hours = lookup(validation_policy.value, "max_cache_duration_in_hours")

                          dynamic "additional_validation_policy" {
                            for_each = lookup(validation_policy.value, "additional_validation_policy") == null ? [] : ["additional_validation_policy"]
                            content {
                              audiences = lookup(additional_validation_policy.value, "audiences")
                              issuers   = lookup(additional_validation_policy.value, "issuers")

                              dynamic "verify_claims" {
                                for_each = lookup(additional_validation_policy.value, "verify_claims") == null ? [] : ["verify_claims"]
                                content {
                                  is_required = lookup(verify_claims.value, "is_required")
                                  key         = lookup(verify_claims.value, "key")
                                  values      = lookup(verify_claims.value, "values")
                                }
                              }
                            }
                          }

                          dynamic "client_details" {
                            for_each = lookup(validation_policy.value, "client_details") == null ? [] : ["client_details"]
                            content {
                              type                         = lookup(client_details.value, "type")
                              client_id                    = lookup(client_details.value, "client_id")
                              client_secret_id             = lookup(client_details.value, "client_secret_id")
                              client_secret_version_number = lookup(client_details.value, "client_secret_version_number")
                            }
                          }

                          dynamic "keys" {
                            for_each = lookup(validation_policy.value, "keys") == null ? [] : ["keys"]
                            content {
                              format  = lookup(keys.value, "format")
                              alg     = lookup(keys.value, "alg")
                              e       = lookup(keys.value, "e")
                              key     = lookup(keys.value, "key")
                              key_ops = lookup(keys.value, "key_ops")
                              kid     = lookup(keys.value, "kid")
                              kty     = lookup(keys.value, "kty")
                              use     = lookup(keys.value, "use")
                            }
                          }

                          dynamic "source_uri_details" {
                            for_each = lookup(validation_policy.value, "source_uri_details") == null ? [] : ["source_uri_details"]
                            content {
                              type = lookup(source_uri_details.value, "type")
                              uri  = lookup(source_uri_details.value, "uri")
                            }
                          }
                        }
                      }
                      dynamic "verify_claims" {
                        for_each = lookup(authentication_server_detail.value, "verify_claims") == null ? [] : ["verify_claims"]
                        content {
                          is_required = lookup(verify_claims.value, "is_required")
                          key         = lookup(verify_claims.value, "key")
                          values      = lookup(verify_claims.value, "values")
                        }
                      }
                    }
                  }
                  dynamic "key" {
                    for_each = lookup(authentication_servers.value, "key") == null ? [] : ["key"]
                    content {
                      name       = lookup(key.value, "name")
                      expression = lookup(key.value, "expression")
                      is_default = lookup(key.value, "is_default")
                      type       = lookup(key.value, "type")
                      values     = lookup(key.value, "values")
                    }
                  }
                }
              }
              dynamic "selection_source" {
                for_each = lookup(dynamic_authentication.value, "selection_source") == null ? [] : ["selection_source"]
                content {
                  selector = lookup(selection_source.value, "selector")
                  type     = lookup(selection_source.value, "type")
                }
              }
            }
          }
          dynamic "mutual_tls" {
            for_each = lookup(request_policies.value, "mutual_tls") == null ? [] : ["mutual_tls"]
            content {
              allowed_sans                     = lookup(mutual_tls.value, "allowed_sans")
              is_verified_certificate_required = lookup(mutual_tls.value, "is_verified_certificate_required")
            }
          }
          dynamic "rate_limiting" {
            for_each = lookup(request_policies.value, "rate_limiting") == null ? [] : ["rate_limiting"]
            content {
              rate_in_requests_per_second = lookup(rate_limiting.value, "rate_in_requests_per_second")
              rate_key                    = lookup(rate_limiting.value, "rate_key")
            }
          }
          dynamic "usage_plans" {
            for_each = lookup(request_policies.value, "usage_plans") == null ? [] : ["usage_plans"]
            content {
              token_locations = lookup(usage_plans.value, "token_locations")
            }
          }
        }
      }
      dynamic "routes" {
        for_each = lookup(specification.value, "routes") == null ? [] : ["routes"]
        content {
          path    = lookup(routes.value, "path")
          methods = lookup(routes.value, "methods")

          dynamic "backend" {
            for_each = lookup(routes.value, "backend") == null ? [] : ["backend"]
            content {
              type                       = lookup(backend.value, "type")
              allowed_post_logout_uris   = lookup(backend.value, "allowed_post_logout_uris")
              body                       = lookup(backend.value, "body")
              connect_timeout_in_seconds = lookup(backend.value, "connect_timeout_in_seconds")
              function_id                = lookup(backend.value, "function_id")
              is_ssl_verify_disabled     = lookup(backend.value, "is_ssl_verify_disabled")
              post_logout_state          = lookup(backend.value, "post_logout_state")
              read_timeout_in_seconds    = lookup(backend.value, "read_timeout_in_seconds")
              send_timeout_in_seconds    = lookup(backend.value, "send_timeout_in_seconds")
              status                     = lookup(backend.value, "status")
              url                        = lookup(backend.value, "url")

              dynamic "headers" {
                for_each = lookup(backend.value, "headers") == null ? [] : ["headers"]
                content {
                  name  = lookup(backend.value, "name")
                  value = lookup(backend.value, "value")
                }
              }

              dynamic "routing_backends" {
                for_each = lookup(backend.value, "routing_backends") == null ? [] : ["routing_backends"]
                content {
                  dynamic "backend" {
                    for_each = lookup(routing_backends.value, "backend") == null ? [] : ["backend"]
                    content {
                      type                    = lookup(backend.value, "type")
                      body                    = lookup(backend.value, "body")
                      is_ssl_verify_disabled  = lookup(backend.value, "is_ssl_verify_disabled")
                      function_id             = lookup(backend.value, "function_id")
                      read_timeout_in_seconds = lookup(backend.value, "read_timeout_in_seconds")
                      status                  = lookup(backend.value, "status")
                      url                     = lookup(backend.value, "url")
                    }
                  }
                  dynamic "key" {
                    for_each = lookup(routing_backends.value, "key") == null ? [] : ["key"]
                    content {
                      name       = lookup(key.value, "name")
                      type       = lookup(key.value, "type")
                      expression = lookup(key.value, "expression")
                      is_default = lookup(key.value, "is_default")
                    }
                  }
                }
              }

              dynamic "selection_source" {
                for_each = lookup(backend.value, "selection_source") == null ? [] : ["selection_source"]
                content {
                  selector = lookup(selection_source.value, "selector")
                  type     = lookup(selection_source.value, "type")
                }
              }
            }
          }
          dynamic "logging_policies" {
            for_each = lookup(routes.value, "logging_policies") == null ? [] : ["logging_policies"]
            content {
              dynamic "access_log" {
                for_each = lookup(logging_policies.value, "access_log") == null ? [] : ["access_log"]
                content {
                  is_enabled = lookup(access_log.value, "is_enabled")
                }
              }
              dynamic "execution_log" {
                for_each = lookup(logging_policies.value, "execution_log") == null ? [] : ["execution_log"]
                content {
                  is_enabled = lookup(execution_log.value, "is_enabled")
                  log_level  = lookup(execution_log.value, "log_level")
                }
              }
            }
          }
          dynamic "request_policies" {
            for_each = lookup(routes.value, "dynamic") == null ? [] : ["dynamic"]
            content {
              dynamic "authorization" {
                for_each = lookup(request_policies.value, "authorization") == null ? [] : ["authorization"]
                content {
                  allowed_scope = lookup(authorization.value, "allowed_scope")
                  type          = lookup(authorization.value, "type")
                }
              }
              dynamic "body_validation" {
                for_each = lookup(request_policies.value, "body_validation") == null ? [] : ["body_validation"]
                content {
                  dynamic "content" {
                    for_each = lookup(body_validation.value, "content") == null ? [] : ["content"]
                    content {
                      media_type      = lookup(content.value, "media_type")
                      validation_type = lookup(content.value, "validation_type")
                    }
                  }
                  required        = lookup(body_validation.value, "required")
                  validation_mode = lookup(body_validation.value, "validation_mode")
                }
              }
              dynamic "cors" {
                for_each = lookup(request_policies.value, "cors") == null ? [] : ["cors"]
                content {
                  allowed_origins              = lookup(cors.value, "allowed_origins")
                  allowed_headers              = lookup(cors.value, "allowed_headers")
                  allowed_methods              = lookup(cors.value, "allowed_methods")
                  exposed_headers              = lookup(cors.value, "exposed_headers")
                  is_allow_credentials_enabled = lookup(cors.value, "is_allow_credentials_enabled")
                  max_age_in_seconds           = lookup(cors.value, "max_age_in_seconds")
                }
              }
              dynamic "header_transformations" {
                for_each = lookup(request_policies.value, "header_transformations") == null ? [] : ["header_transformations"]
                content {
                  dynamic "filter_headers" {
                    for_each = lookup(header_transformations.value, "filter_headers") == null ? [] : ["filter_headers"]
                    content {
                      type = lookup(filter_headers.value, "type")
                      dynamic "items" {
                        for_each = lookup(filter_headers.value, "items") == null ? [] : ["items"]
                        content {
                          name = lookup(items.value, "name")
                        }
                      }
                    }
                  }
                  dynamic "rename_headers" {
                    for_each = lookup(header_transformations.value, "rename_headers") == null ? [] : ["rename_headers"]
                    content {
                      dynamic "items" {
                        for_each = lookup(rename_headers.value, "items") == null ? [] : ["items"]
                        content {
                          from = lookup(items.value, "from")
                          to   = lookup(items.value, "to")
                        }
                      }
                    }
                  }
                  dynamic "set_headers" {
                    for_each = lookup(header_transformations.value, "set_headers") == null ? [] : ["set_headers"]
                    content {
                      dynamic "items" {
                        for_each = ""
                        content {
                          name      = lookup(set_headers.value, "name")
                          values    = lookup(set_headers.value, "values")
                          if_exists = lookup(set_headers.value, "if_exists")
                        }
                      }
                    }
                  }
                }
              }
              dynamic "header_validations" {
                for_each = lookup(request_policies.value, "header_validations") == null ? [] : ["header_validations"]
                content {
                  dynamic "headers" {
                    for_each = lookup(request_policies.value, "headers") == null ? [] : ["headers"]
                    content {
                      name     = lookup(headers.value, "name")
                      required = lookup(headers.value, "required")
                    }
                  }
                  validation_mode = lookup(header_validations.value, "validation_mode")
                }
              }
              dynamic "query_parameter_transformations" {
                for_each = lookup(request_policies.value, "query_parameter_transformations") == null ? [] : ["query_parameter_transformations"]
                content {
                  dynamic "filter_query_parameters" {
                    for_each = lookup(query_parameter_transformations.value, "filter_query_parameters") == null ? [] : ["filter_query_parameters"]
                    content {
                      type = lookup(filter_query_parameters.value, "type")
                      dynamic "items" {
                        for_each = lookup(filter_query_parameters.value, "items") == null ? [] : ["filter_query_parameters"]
                        content {
                          name = lookup(items.value, "name")
                        }
                      }
                    }
                  }
                  dynamic "rename_query_parameters" {
                    for_each = lookup(query_parameter_transformations.value, "rename_query_parameters") == null ? [] : ["rename_query_parameters"]
                    content {
                      dynamic "items" {
                        for_each = lookup(rename_query_parameters.value, "items")
                        content {
                          from = lookup(items.value, "from")
                          to   = lookup(items.value, "to")
                        }
                      }
                    }
                  }
                  dynamic "set_query_parameters" {
                    for_each = lookup(query_parameter_transformations.value, "set_query_parameters") == null ? [] : ["set_query_parameters"]
                    content {
                      dynamic "items" {
                        for_each = lookup(set_query_parameters.value, "items") == null ? [] : ["items"]
                        content {
                          name      = lookup(items.value, "name")
                          values    = lookup(items.value, "values")
                          if_exists = lookup(items.value, "if_exists")
                        }
                      }
                    }
                  }
                }
              }
              dynamic "query_parameter_validations" {
                for_each = lookup(request_policies.value, "query_parameter_validations") == null ? [] : ["query_parameter_validations"]
                content {
                  validation_mode = lookup(query_parameter_validations.value, "validation_mode")
                  dynamic "parameters" {
                    for_each = lookup(query_parameter_validations.value, "parameters") == null ? [] : ["parameters"]
                    content {
                      name     = lookup(parameters.value, "name")
                      required = lookup(parameters.value, "required")
                    }
                  }
                }
              }
              dynamic "response_cache_lookup" {
                for_each = lookup(request_policies.value, "response_cache_lookup") == null ? [] : ["response_cache_lookup"]
                content {
                  type                       = lookup(response_cache_lookup.value, "type")
                  cache_key_additions        = lookup(response_cache_lookup.value, "cache_key_additions")
                  is_enabled                 = lookup(response_cache_lookup.value, "is_enabled")
                  is_private_caching_enabled = lookup(response_cache_lookup.value, "is_private_caching_enabled")
                }
              }
            }
          }
          dynamic "response_policies" {
            for_each = lookup(routes.value, "response_policies") == null ? [] : ["response_policies"]
            content {
              dynamic "header_transformations" {
                for_each = lookup(response_policies.value, "header_transformations") == null ? [] : ["header_transformations"]
                content {
                  dynamic "filter_headers" {
                    for_each = lookup(header_transformations.value, "filter_headers") == null ? [] : ["filter_headers"]
                    content {
                      type = lookup(filter_headers.value, "type")
                      dynamic "items" {
                        for_each = lookup(filter_headers.value, "items") == null ? [] : ["items"]
                        content {
                          name = lookup(items.value, "name")
                        }
                      }
                    }
                  }
                  dynamic "rename_headers" {
                    for_each = lookup(header_transformations.value, "rename_headers") == null ? [] : ["rename_headers"]
                    content {
                      dynamic "items" {
                        for_each = lookup(rename_headers.value, "items")
                        content {
                          from = lookup(rename_headers.value, "from")
                          to   = lookup(rename_headers.value, "to")
                        }
                      }
                    }
                  }
                  dynamic "set_headers" {
                    for_each = lookup(header_transformations.value, "set_headers") == null ? [] : ["set_headers"]
                    content {
                      dynamic "items" {
                        for_each = lookup(set_headers.value, "items") == null ? [] : ["items"]
                        content {
                          name      = lookup(items.value, "name")
                          values    = lookup(items.value, "values")
                          if_exists = lookup(items.value, "if_exists")
                        }
                      }
                    }
                  }
                }
              }
              dynamic "response_cache_store" {
                for_each = lookup(response_policies.value, "response_cache_store") == null ? [] : ["response_cache_store"]
                content {
                  time_to_live_in_seconds = lookup(response_cache_store.value, "time_to_live_in_seconds")
                  type                    = lookup(response_cache_store.value, "type")
                }
              }
            }
          }
        }
      }
    }
  }
}

resource "oci_apigateway_gateway" "this" {
  count          = length(var.gateway)
  compartment_id = data.oci_identity_compartment.this.compartment_id
  endpoint_type  = lookup(var.gateway[count.index], "endpoint_type")
  subnet_id      = data.oci_core_subnet.this.subnet_id
  certificate_id = try(
    data.oci_apigateway_certificate.this.certificate_id,
    element(oci_apigateway_certificate.this.*.id, lookup(var.gateway[count.index], "certificate_id"))
  )
  defined_tags = merge(
    var.defined_tags,
    lookup(var.gateway[count.index], "defined_tags")
  )
  display_name = lookup(var.gateway[count.index], "display_name")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.gateway[count.index], "freeform_tags")
  )
  network_security_group_ids = lookup(var.gateway[count.index], "network_security_group_ids")

  dynamic "ca_bundles" {
    for_each = lookup(var.gateway[count.index], "ca_bundles") == null ? [] : ["ca_bundles"]
    content {
      type                     = lookup(ca_bundles.value, "type")
      ca_bundle_id             = lookup(ca_bundles.value, "ca_bundle_id")
      certificate_authority_id = lookup(ca_bundles.value, "certificate_authority_id")
    }
  }

  dynamic "response_cache_details" {
    for_each = lookup(var.gateway[count.index], "response_cache_details") == null ? [] : ["response_cache_details"]
    content {
      type                                 = lookup(response_cache_details.value, "type")
      authentication_secret_id             = lookup(response_cache_details.value, "authentication_secret_id")
      authentication_secret_version_number = lookup(response_cache_details.value, "authentication_secret_version_number")
      connect_timeout_in_ms                = lookup(response_cache_details.value, "connect_timeout_in_ms")
      is_ssl_enabled                       = lookup(response_cache_details.value, "is_ssl_enabled")
      is_ssl_verify_disabled               = lookup(response_cache_details.value, "is_ssl_verify_disabled")
      read_timeout_in_ms                   = lookup(response_cache_details.value, "read_timeout_in_ms")
      send_timeout_in_ms                   = lookup(response_cache_details.value, "send_timeout_in_ms")

      dynamic "servers" {
        for_each = lookup(response_cache_details.value, "servers") == null ? [] : ["servers"]
        content {
          host = lookup(servers.value, "host")
          port = lookup(servers.value, "port")
        }
      }
    }
  }
}

resource "oci_apigateway_subscriber" "this" {
  count          = length(var.subscriber) == "0" ? "0" : length(var.usage_plans)
  compartment_id = data.oci_identity_compartment.this.compartment_id
  usage_plans    = lookup(var.subscriber[count.index], "usage_plans")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.subscriber[count.index], "defined_tags")
  )
  display_name = lookup(var.subscriber[count.index], "display_name")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.subscriber[count.index], "freeform_tags")
  )

  dynamic "clients" {
    for_each = lookup(var.subscriber[count.index], "clients")
    content {
      name  = lookup(clients.value, "name")
      token = lookup(clients.value, "token")

    }
  }
}

resource "oci_apigateway_usage_plan" "this" {
  count          = length(var.usage_plans)
  compartment_id = data.oci_identity_compartment.this.compartment_id
  defined_tags = merge(
    var.defined_tags,
    lookup(var.usage_plans[count.index], "defined_tags")
  )
  display_name = lookup(var.usage_plans[count.index], "display_name")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.usage_plans[count.index], "freeform_tags")
  )

  dynamic "entitlements" {
    for_each = lookup(var.usage_plans[count.index], "entitlements")
    content {
      name        = lookup(entitlements.value, "name")
      description = lookup(entitlements.value, "description")

      dynamic "quota" {
        for_each = lookup(entitlements.value, "quota") == null ? [] : ["quota"]
        content {
          operation_on_breach = lookup(quota.value, "operation_on_breach")
          reset_policy        = lookup(quota.value, "reset_policy")
          unit                = lookup(quota.value, "unit")
          value               = lookup(quota.value, "value")
        }
      }

      dynamic "rate_limit" {
        for_each = lookup(entitlements.value, "rate_limit") == null ? [] : ["rate_limit"]
        content {
          unit  = lookup(rate_limit.value, "unit")
          value = lookup(rate_limit.value, "value")
        }
      }

      dynamic "targets" {
        for_each = lookup(entitlements.value, "targets") == null ? [] : ["targets"]
        content {
          deployment_id = try(
            data.oci_apigateway_deployment.this.deployment_id,
            element(oci_apigateway_deployment.this.*.id, lookup(targets.value, "deployment_id"))
          )
        }
      }
    }
  }
}