variable "gateway_id" {
  type    = string
  default = null
  description = "Gateway_id value to be used as datasource - if defined"
}

variable "deployment_id" {
  type    = string
  default = null
  description = "Deployment_id value to be used as datasource - if defined"
}

variable "certificate_id" {
  type    = string
  default = null
  description = "Certificate_id value to be used as datasource - if defined"
}

variable "defined_tags" {
  type    = map(string)
  default = {}
  description = "Defined tags"
}

variable "freeform_tags" {
  type    = map(string)
  default = {}
  description = "Freeform tags"
}

variable "compartment_id" {
  type = string
  description = "Compartment id - mandatory - to be used as data source"
}

variable "subnet_id" {
  type = string
  description = "Subnet id - mandatory - to be used as data source"
}

variable "api" {
  type = list(object({
    id            = number
    content       = optional(string)
    defined_tags  = optional(map(string))
    display_name  = optional(string)
    freeform_tags = optional(map(string))
  }))
  default = []
  description = <<EOF
This resource provides the Api resource in Oracle Cloud Infrastructure API Gateway service.
EOF
}

variable "certificate" {
  type = list(object({
    id                        = number
    certificate               = string
    private_key               = string
    defined_tags              = optional(map(string))
    display_name              = optional(string)
    freeform_tags             = optional(map(string))
    intermediate_certificates = optional(string)
  }))
  default = []
  description = <<EOF
This resource provides the Certificate resource in Oracle Cloud Infrastructure API Gateway service.
EOF
}

variable "deployment" {
  type = list(object({
    id            = number
    gateway_id    = number
    path_prefix   = string
    display_name  = optional(string)
    freeform_tags = optional(map(string))
    defined_tags  = optional(map(string))
    specification = optional(list(object({
      logging_policies = optional(list(object({
        access_log = optional(list(object({
          is_enabled = optional(bool)
        })), [])
        execution_log = optional(list(object({
          is_enabled = optional(bool)
          log_level  = optional(string)
        })), [])
      })), [])
      request_policies = optional(list(object({
        authentication = optional(list(object({
          type                        = string
          audiences                   = optional(list(string))
          cache_key                   = optional(list(string))
          function_id                 = optional(string)
          is_anonymous_access_allowed = optional(bool)
          issuers                     = optional(list(string))
          max_clock_skew_in_seconds   = optional(number)
          parameters                  = optional(map(string))
          token_auth_scheme           = optional(string)
          token_header                = optional(string)
          token_query_param           = optional(string)
          public_keys = optional(list(object({
            type                        = string
            is_ssl_verify_disabled      = optional(bool)
            max_cache_duration_in_hours = optional(number)
            uri                         = optional(string)
            keys = optional(list(object({
              format  = string
              alg     = optional(string)
              e       = optional(string)
              key     = optional(string)
              key_ops = optional(string)
              kid     = optional(string)
              kty     = optional(string)
              use     = optional(string)
            })), [])
          })), [])
          validation_failure_policy = optional(list(object({
            type                               = string
            fallback_redirect_path             = optional(string)
            logout_path                        = optional(string)
            max_expiry_duration_in_hours       = optional(number)
            response_code                      = optional(string)
            response_message                   = optional(string)
            response_type                      = optional(string)
            scopes                             = optional(list(string))
            use_cookies_for_intermediate_steps = optional(bool)
            use_cookies_for_session            = optional(bool)
            use_pkce                           = optional(bool)
            client_details = optional(list(object({
              type                         = string
              client_id                    = optional(string)
              client_secret_id             = optional(string)
              client_secret_version_number = optional(string)
            })), [])
            response_header_transformations = optional(list(object({
              filter_headers = optional(list(object({
                type = string
                items = optional(list(object({
                  name = optional(string)
                })), [])
              })), [])
              rename_headers = optional(list(object({
                items = optional(list(object({
                  from = optional(string)
                  to   = optional(string)
                })), [])
              })), [])
              set_headers = optional(list(object({
                items = optional(list(object({
                  if_exists = optional(string)
                  name      = optional(string)
                  values    = optional(list(string))
                })), [])
              })), [])
            })), [])
          })), [])
          validation_policy = optional(list(object({
            type                        = string
            is_ssl_verify_disabled      = optional(bool)
            max_cache_duration_in_hours = optional(number)
            additional_validation_policy = optional(list(object({
              audiences = optional(list(string))
              issuers   = optional(list(string))
              verify_claims = optional(list(object({
                is_required = optional(bool)
                key         = optional(string)
                values      = optional(list(string))
              })), [])
            })), [])
            client_details = optional(list(object({
              type                         = string
              client_id                    = optional(string)
              client_secret_id             = optional(string)
              client_secret_version_number = optional(string)
            })), [])
            keys = optional(list(object({
              format  = string
              alg     = optional(string)
              e       = optional(string)
              key     = optional(string)
              key_ops = optional(list(string))
              kid     = optional(string)
              kty     = optional(string)
              use     = optional(string)
            })), [])
            source_uri_details = optional(list(object({
              type = string
              uri  = optional(string)
            })), [])
          })), [])
        })), [])
        cors = optional(list(object({
          allowed_origins              = list(string)
          allowed_headers              = optional(list(string))
          allowed_methods              = optional(list(string))
          exposed_headers              = optional(list(string))
          is_allow_credentials_enabled = optional(bool)
          max_age_in_seconds           = optional(number)
        })), [])
        dynamic_authentication = optional(list(object({
          authentication_servers = optional(list(object({
            authentication_server_detail = optional(list(object({
              type                        = string
              audiences                   = optional(list(string))
              function_id                 = optional(string)
              is_anonymous_access_allowed = optional(bool)
              issuers                     = optional(list(string))
              max_clock_skew_in_seconds   = optional(number)
              parameters                  = optional(map(string))
              token_auth_scheme           = optional(string)
              token_header                = optional(string)
              token_query_param           = optional(string)
              cache_key                   = optional(list(string))
              public_keys = optional(list(object({
                type                        = string
                is_ssl_verify_disabled      = optional(bool)
                max_cache_duration_in_hours = optional(number)
                uri                         = optional(string)
                keys = optional(list(object({
                  format  = string
                  alg     = optional(string)
                  e       = optional(string)
                  key     = optional(string)
                  key_ops = optional(list(string))
                  kid     = optional(string)
                  kty     = optional(string)
                  use     = optional(string)
                })), [])
              })), [])
              validation_failure_policy = optional(list(object({
                type                               = string
                fallback_redirect_path             = optional(string)
                logout_path                        = optional(string)
                max_expiry_duration_in_hours       = optional(number)
                response_code                      = optional(string)
                response_message                   = optional(string)
                response_type                      = optional(string)
                scopes                             = optional(list(string))
                use_cookies_for_intermediate_steps = optional(bool)
                use_cookies_for_session            = optional(bool)
                use_pkce                           = optional(bool)
                client_details = optional(list(object({
                  type                         = string
                  client_id                    = optional(string)
                  client_secret_id             = optional(string)
                  client_secret_version_number = optional(string)
                })), [])
                response_header_transformations = optional(list(object({
                  filter_headers = optional(list(object({
                    type = string
                    items = optional(list(object({
                      name = optional(string)
                    })), [])
                  })), [])
                  rename_headers = optional(list(object({
                    items = optional(list(object({
                      from = optional(string)
                      to   = optional(string)
                    })), [])
                  })), [])
                  set_headers = optional(list(object({
                    items = optional(list(object({
                      if_exists = optional(string)
                      name      = optional(string)
                      values    = optional(list(string))
                    })), [])
                  })), [])
                })), [])
                source_uri_details = optional(list(object({
                  type = string
                  uri  = optional(string)
                })), [])
              })), [])
              validation_policy = optional(list(object({
                type                        = string
                uri                         = optional(string)
                is_ssl_verify_disabled      = optional(bool)
                max_cache_duration_in_hours = optional(number)
                additional_validation_policy = optional(list(object({
                  audiences = optional(list(string))
                  issuers   = optional(list(string))
                  verify_claims = optional(list(object({
                    is_required = bool
                    key         = optional(string)
                    values      = optional(list(string))
                  })), [])
                })), [])
                client_details = optional(list(object({
                  type                         = string
                  client_id                    = optional(string)
                  client_secret_id             = optional(string)
                  client_secret_version_number = optional(string)
                })), [])
                keys = optional(list(object({
                  format  = string
                  alg     = optional(string)
                  e       = optional(string)
                  key     = optional(string)
                  key_ops = optional(list(string))
                  kid     = optional(string)
                  kty     = optional(string)
                  use     = optional(string)
                })), [])
                source_uri_details = optional(list(object({
                  type = string
                  uri  = optional(string)
                })), [])
              })), [])
              verify_claims = optional(list(object({
                is_required = optional(bool)
                key         = optional(string)
                values      = optional(list(string))
              })), [])
            })), [])
            key = optional(list(object({
              name       = string
              expression = optional(string)
              is_default = optional(bool)
              type       = optional(string)
              values     = optional(list(string))
            })), [])
          })), [])
          selection_source = optional(list(object({
            selector = string
            type     = string
          })), [])
        })), [])
        mutual_tls = optional(list(object({
          allowed_sans                     = optional(list(string))
          is_verified_certificate_required = optional(bool)
        })), [])
        rate_limiting = optional(list(object({
          rate_in_requests_per_second = number
          rate_key                    = string
        })), [])
        usage_plans = optional(list(object({
          token_locations = list(string)
        })), [])
      })), [])
      routes = optional(list(object({
        path    = string
        methods = optional(list(string))
        backend = optional(list(object({
          type                       = string
          allowed_post_logout_uris   = optional(list(string))
          body                       = optional(string)
          connect_timeout_in_seconds = optional(number)
          function_id                = optional(string)
          is_ssl_verify_disabled     = optional(bool)
          post_logout_state          = optional(string)
          read_timeout_in_seconds    = optional(number)
          send_timeout_in_seconds    = optional(number)
          status                     = optional(number)
          url                        = optional(string)
          headers = optional(list(object({
            name  = optional(string)
            value = optional(string)
          })), [])
          routing_backends = optional(list(object({
            backend = optional(list(object({
              type                    = string
              body                    = optional(string)
              is_ssl_verify_disabled  = optional(bool)
              function_id             = optional(string)
              read_timeout_in_seconds = optional(number)
              status                  = optional(number)
              url                     = optional(string)
            })), [])
            key = optional(list(object({
              name       = string
              type       = string
              expression = optional(string)
              is_default = optional(bool)
            })), [])
          })), [])
          selection_source = optional(list(object({
            selector = string
            type     = string
          })), [])
        })), [])
        logging_policies = optional(list(object({
          access_log = optional(list(object({
            is_enabled = optional(bool)
          })), [])
          execution_log = optional(list(object({
            is_enabled = optional(bool)
            log_level  = optional(string)
          })), [])
        })), [])
        request_policies = optional(list(object({
          authorization = optional(list(object({
            allowed_scope = optional(list(string))
            type          = optional(string)
          })), [])
          body_validation = optional(list(object({
            required        = optional(bool)
            validation_mode = optional(string)
            content = optional(list(object({
              media_type      = string
              validation_type = string
            })), [])
          })), [])
          cors = optional(list(object({
            allowed_origins              = optional(list(string))
            allowed_headers              = optional(list(string))
            allowed_methods              = optional(list(string))
            exposed_headers              = optional(list(string))
            is_allow_credentials_enabled = optional(bool)
            max_age_in_seconds           = optional(number)
          })), [])
          header_transformations = optional(list(object({
            filter_headers = optional(list(object({
              type = string
              items = optional(list(object({
                name = string
              })), [])
            })), [])
            rename_headers = optional(list(object({
              items = optional(list(object({
                from = string
                to   = string
              })), [])
            })), [])
            set_headers = optional(list(object({
              items = optional(list(object({
                name      = string
                values    = list(string)
                if_exists = optional(string)
              })), [])
            })), [])
          })), [])
          header_validations = optional(list(object({
            validation_mode = optional(string)
            headers = optional(list(object({
              name     = optional(string)
              required = optional(bool)
            })), [])
          })), [])
          query_parameter_transformations = optional(list(object({
            filter_query_parameters = optional(list(object({
              type = string
              items = optional(list(object({
                name = optional(string)
              })), [])
            })), [])
            rename_query_parameters = optional(list(object({
              items = optional(list(object({
                from = string
                to   = string
              })), [])
            })), [])
            set_query_parameters = optional(list(object({
              items = optional(list(object({
                name      = string
                values    = list(string)
                if_exists = optional(string)
              })), [])
            })), [])
          })), [])
          query_parameter_validations = optional(list(object({
            validation_mode = optional(string)
            parameters = optional(list(object({
              name     = optional(string)
              required = optional(bool)
            })), [])
          })), [])
          response_cache_lookup = optional(list(object({
            type                       = string
            cache_key_additions        = optional(list(string))
            is_enabled                 = optional(bool)
            is_private_caching_enabled = optional(bool)
          })), [])
        })), [])
        response_policies = optional(list(object({
          header_transformations = optional(list(object({
            filter_headers = optional(list(object({
              items = optional(list(object({
                name = optional(string)
              })), [])
            })), [])
            rename_headers = optional(list(object({
              items = optional(list(object({
                from = string
                to   = string
              })), [])
            })), [])
            set_headers = optional(list(object({
              items = optional(list(object({
                name      = string
                values    = list(string)
                if_exists = optional(string)
              })), [])
            })), [])
          })), [])
          response_cache_store = optional(list(object({
            time_to_live_in_seconds = number
            type                    = string
          })), [])
        })), [])
      })), [])
    })), [])
  }))
  default = []
  description = <<EOF
This resource provides the Deployment resource in Oracle Cloud Infrastructure API Gateway service.
EOF
}

variable "gateway" {
  type = list(object({
    id                         = number
    endpoint_type              = string
    subnet_id                  = string
    certificate_id             = optional(number)
    defined_tags               = optional(map(string))
    display_name               = optional(string)
    freeform_tags              = optional(map(string))
    network_security_group_ids = optional(list(string))
    ca_bundles = optional(list(object({
      type                     = string
      ca_bundle_id             = optional(string)
      certificate_authority_id = optional(string)
    })), [])
    response_cache_details = optional(list(object({
      type                                 = string
      authentication_secret_id             = optional(string)
      authentication_secret_version_number = optional(string)
      connect_timeout_in_ms                = optional(number)
      is_ssl_enabled                       = optional(bool)
      is_ssl_verify_disabled               = optional(number)
      read_timeout_in_ms                   = optional(number)
      send_timeout_in_ms                   = optional(number)
      servers = optional(list(object({
        host = optional(string)
        port = optional(number)
      })), [])
    })), [])
  }))
  default = []
  description = <<EOF
This resource provides the Gateway resource in Oracle Cloud Infrastructure API Gateway service.
EOF
}

variable "subscriber" {
  type = list(object({
    id            = number
    usage_plans   = list(string)
    defined_tags  = optional(map(string))
    display_name  = optional(string)
    freeform_tags = optional(map(string))
    clients = list(object({
      name  = string
      token = string
    }))
  }))
  default = []
  description = <<EOF
This resource provides the Subscriber resource in Oracle Cloud Infrastructure API Gateway service.
EOF
}

variable "usage_plans" {
  type = list(object({
    id            = number
    defined_tags  = optional(map(string))
    display_name  = optional(string)
    freeform_tags = optional(map(string))
    entitlements = list(object({
      name        = string
      description = optional(string)
      quota = optional(list(object({
        operation_on_breach = string
        reset_policy        = string
        unit                = string
        value               = number
      })), [])
      rate_limit = optional(list(object({
        unit  = string
        value = number
      })), [])
      targets = optional(list(object({
        deployment_id = number
      })), [])
    }))
  }))
  default = []
  description = <<EOF
This resource provides the Usage Plan resource in Oracle Cloud Infrastructure API Gateway service.
EOF
}