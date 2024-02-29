variable "labels" {
  type    = map(string)
  default = {}
}

variable "edge_cache_keyset" {
  type = list(map(object({
    id          = number
    name        = string
    description = optional(string)
    labels      = optional(map(string))
    project     = optional(string)
    public_key = optional(list(object({
      id      = string
      value   = string
      managed = optional(string)
    })), [])
    validation_shared_keys = optional(list(object({
      secret_version = string
    })), [])
  })))
  default     = []
  description = <<EOF
EdgeCacheKeyset represents a collection of public keys used for validating signed requests.
EOF
}

variable "edge_cache_origin" {
  type = list(map(object({
    id               = number
    name             = string
    origin_address   = string
    description      = optional(string)
    labels           = optional(map(string))
    protocol         = optional(string)
    port             = optional(number)
    max_attempts     = optional(number)
    failover_origin  = optional(string)
    retry_conditions = optional(list(string))
    project          = optional(string)
    timeout = optional(list(object({
      connect_timeout      = optional(string)
      max_attempts_timeout = optional(string)
      response_timeout     = optional(string)
      read_timeout         = optional(string)
    })), [])
    aws_v4_authentication = optional(list(object({
      access_key_id             = string
      secret_access_key_version = optional(string)
      origin_region             = optional(string)
    })), [])
    origin_override_action = optional(list(object({
      url_rewrite = optional(list(object({
        host_rewrite = optional(string)
      })), [])
      header_action = optional(list(object({
        request_headers_to_add = optional(list(object({
          header_name  = string
          header_value = string
          replace      = optional(string)
        })), [])
      })), [])
    })), [])
    origin_redirect = optional(list(object({
      redirect_conditions = optional(string)
    })), [])
  })))
  default     = []
  description = <<EOF
EdgeCacheOrigin represents a HTTP-reachable backend for an EdgeCacheService.
EOF
}

variable "edge_cache_service" {
  type = list(map(object({
    id                    = number
    name                  = string
    description           = optional(string)
    labels                = optional(map(string))
    disable_quic          = optional(bool)
    disable_http2         = optional(bool)
    require_tls           = optional(bool)
    edge_ssl_certificates = optional(list(string))
    ssl_policy            = optional(string)
    edge_security_policy  = optional(string)
    project               = optional(string)
    log_config = optional(list(object({
      enable      = optional(bool)
      sample_rate = optional(number)
    })), [])
    routing = list(object({
      host_rule = list(object({
        hosts        = list(string)
        path_matcher = string
        description  = optional(string)
      }))
      path_matcher = list(object({
        name        = string
        description = optional(string)
        route_rule = list(object({
          priority    = string
          description = optional(string)
          origin      = optional(string)
          match_rule = optional(list(object({
            ignore_case         = optional(bool)
            prefix_match        = optional(string)
            path_template_match = optional(string)
            full_path_match     = optional(string)
            query_parameter_match = optional(list(object({
              name          = string
              present_match = optional(bool)
              exact_match   = optional(string)
            })), [])
            header_match = optional(list(object({
              header_name   = string
              present_match = optional(bool)
              exact_match   = optional(string)
              prefix_match  = optional(string)
              suffix_match  = optional(string)
              invert_match  = optional(bool)
            })), [])
          })), [])
          header_action = optional(list(object({
            request_header_to_add = optional(list(object({
              header_name  = string
              header_value = string
              replace      = optional(bool)
            })), [])
            request_header_to_remove = optional(list(object({
              header_name = string
            })), [])
            response_header_to_add = optional(list(object({
              header_name  = string
              header_value = string
              replace      = optional(bool)
            })), [])
            response_header_to_remove = optional(list(object({
              header_name = string
            })), [])
          })), [])
          route_action = optional(list(object({
            cdn_policy = optional(list(object({
              cache_mode                            = optional(string)
              client_ttl                            = optional(string)
              default_ttl                           = optional(string)
              max_ttl                               = optional(string)
              negative_caching                      = optional(bool)
              negative_caching_policy               = optional(map(string))
              signed_request_mode                   = optional(string)
              signed_request_keyset                 = optional(string)
              signed_request_maximum_expiration_ttl = optional(string)
              add_signatures = optional(list(object({
                actions               = list(string)
                keyset                = optional(string)
                token_ttl             = optional(string)
                token_query_parameter = optional(string)
                copied_parameters     = optional(list(string))
              })), [])
              signed_token_options = optional(list(object({
                token_query_parameter        = optional(string)
                allowed_signature_algorithms = optional(list(string))
              })), [])
              cache_key_policy = optional(list(object({
                include_protocol          = optional(bool)
                exclude_query_string      = optional(bool)
                exclude_host              = optional(bool)
                included_query_parameters = optional(list(string))
                excluded_query_parameters = optional(list(string))
                included_header_names     = optional(list(string))
                included_cookie_names     = optional(list(string))
              })), [])
            })), [])
            url_rewrite = optional(list(object({
              path_prefix_rewrite   = optional(string)
              path_template_rewrite = optional(string)
              host_rewrite          = optional(string)
            })), [])
            cors_policy = optional(list(object({
              max_age           = string
              allow_credentials = optional(bool)
              allow_origins     = optional(list(string))
              allow_headers     = optional(list(string))
              allow_methods     = optional(list(string))
              expose_headers    = optional(list(string))
              disabled          = optional(bool)
            })), [])
          })), [])
          url_redirect = optional(list(object({
            host_redirect          = optional(string)
            prefix_redirect        = optional(string)
            path_redirect          = optional(string)
            redirect_response_code = optional(string)
            https_redirect         = optional(bool)
            strip_query            = optional(bool)
          })), [])
        }))
      }))
    }))
  })))
  default     = []
  description = <<EOF
EdgeCacheService defines the IP addresses, protocols, security policies, cache policies and routing configuration.
EOF
}

variable "endpoint_policy" {
  type = list(map(object({
    id                   = number
    name                 = string
    type                 = string
    labels               = optional(map(string))
    description          = optional(string)
    authorization_policy = optional(string)
    server_tls_policy    = optional(string)
    client_tls_policy    = optional(string)
    project              = optional(string)
    endpoint_matcher = list(object({
      metadata_label_matcher = list(object({
        metadata_label_match_criteria = string
        metadata_labels = optional(list(object({
          label_name  = string
          label_value = string
        })), [])
      }))
    }))
    traffic_port_selector = optional(list(object({
      ports = list(string)
    })), [])
  })))
  default     = []
  description = <<EOF
EndpointPolicy is a resource that helps apply desired configuration on the endpoints that match specific criteria.
EOF
}

variable "gateway" {
  type = list(map(object({
    id                                   = number
    name                                 = string
    ports                                = list(string)
    type                                 = string
    labels                               = optional(map(string))
    description                          = optional(string)
    scope                                = optional(string)
    server_tls_policy                    = optional(string)
    addresses                            = optional(list(string))
    subnetwork                           = optional(string)
    network                              = optional(string)
    gateway_security_policy              = optional(string)
    certificate_urls                     = optional(list(string))
    location                             = optional(string)
    project                              = optional(string)
    delete_swg_autogen_router_on_destroy = optional(bool)
  })))
  default     = []
  description = <<EOF
Gateway represents the configuration for a proxy, typically a load balancer. It captures the ip:port over which the services are exposed by the proxy, along with any policy configurations. Routes have reference to to Gateways to dictate how requests should be routed by this Gateway.
EOF
}

variable "grpc_route" {
  type = list(map(object({
    id           = number
    hostnames    = list(string)
    name         = string
    labels       = optional(map(string))
    description  = optional(string)
    meshes_ids   = optional(list(number))
    gateways_ids = optional(list(number))
    project      = optional(string)
    rules = list(object({
      matches = optional(list(object({
        headers = optional(list(object({
          key   = string
          value = string
          type  = optional(string)
        })), [])
        method = optional(list(object({
          grpc_method    = string
          grpc_service   = string
          case_sensitive = optional(bool)
        })), [])
      })), [])
      action = optional(list(object({
        timeout = string
        destinations = optional(list(object({
          service_name = optional(string)
          weight       = optional(number)
        })), [])
        fault_injection_policy = optional(list(object({
          delay = optional(list(object({
            fixed_delay = optional(string)
            percentage  = optional(number)
          })), [])
          abort = optional(list(object({
            http_status = optional(number)
            percentage  = optional(number)
          })), [])
        })), [])
        retry_policy = optional(list(object({
          retry_conditions = optional(list(string))
          num_retries      = optional(number)
        })), [])
      })), [])
    }))
  })))
  default     = []
  description = <<EOF
GrpcRoute is the resource defining how gRPC traffic routed by a Mesh or Gateway resource is routed.
EOF
}

variable "http_route" {
  type = list(map(object({
    id           = number
    hostnames    = list(string)
    name         = string
    labels       = optional(map(string))
    description  = optional(string)
    meshes_ids   = optional(list(number))
    gateways_ids = optional(list(number))
    project      = optional(string)
    rules = list(object({
      matches = optional(list(object({
        ignore_case     = optional(bool)
        full_path_match = optional(string)
        prefix_match    = optional(string)
        regex_match     = optional(string)
        query_parameters = optional(list(object({
          query_parameter = optional(string)
          exact_match     = optional(string)
          regex_match     = optional(string)
          present_match   = optional(bool)
        })), [])
        headers = optional(list(object({
          header        = optional(string)
          invert_match  = optional(bool)
          exact_match   = optional(string)
          regex_match   = optional(string)
          prefix_match  = optional(string)
          present_match = optional(bool)
          suffix_match  = optional(string)
          range_match = optional(list(object({
            end   = number
            start = number
          })), [])
        })), [])
      })), [])
      action = optional(list(object({
        timeout = string
        destinations = optional(list(object({
          service_name = optional(string)
          weight       = optional(number)
        })), [])
        redirect = optional(list(object({
          host_redirect  = optional(string)
          path_redirect  = optional(string)
          prefix_rewrite = optional(string)
          response_code  = optional(string)
          https_redirect = optional(bool)
          strip_query    = optional(bool)
          port_redirect  = optional(number)
        })), [])
        fault_injection_policy = optional(list(object({
          delay = optional(list(object({
            fixed_delay = optional(string)
            percentage  = optional(number)
          })), [])
          abort = optional(list(object({
            http_status = optional(number)
            percentage  = optional(number)
          })), [])
        })), [])
        request_header_modifier = optional(list(object({
          set    = map(string)
          add    = map(string)
          remove = optional(list(string))
        })), [])
        response_header_modifier = optional(list(object({
          set    = map(string)
          add    = map(string)
          remove = optional(list(string))
        })), [])
        url_rewrite = optional(list(object({
          path_prefix_rewrite = optional(string)
          host_rewrite        = optional(string)
        })), [])
        retry_policy = optional(list(object({
          retry_conditions = optional(list(string))
          num_retries      = optional(number)
          per_try_timeout  = optional(string)
        })), [])
        request_mirror_policy = optional(list(object({
          destination = optional(list(object({
            service_name = optional(string)
            weight       = optional(number)
          })), [])
        })), [])
        cors_policy = optional(list(object({
          allow_origins        = optional(list(string))
          allow_origin_regexes = optional(list(string))
          allow_methods        = optional(list(string))
          allow_headers        = optional(list(string))
          expose_headers       = optional(list(string))
          max_age              = optional(string)
          allow_credentials    = optional(bool)
          disabled             = optional(bool)
        })), [])
      })), [])
    }))
  })))
  default     = []
  description = <<EOF
HttpRoute is the resource defining how HTTP traffic should be routed by a Mesh or Gateway resource.
EOF
}

variable "mesh" {
  type = list(map(object({
    id                = number
    name              = string
    labels            = optional(map(string))
    description       = optional(string)
    interception_port = optional(number)
    project           = optional(string)
  })))
  default     = []
  description = <<EOF
Mesh represents a logical configuration grouping for workload to workload communication within a service mesh. Routes that point to mesh dictate how requests are routed within this logical mesh boundary.
EOF
}

variable "service_binding" {
  type = list(map(object({
    id          = number
    name        = string
    service     = string
    labels      = optional(map(string))
    description = optional(string)
    project     = optional(string)
  })))
  default     = []
  description = <<EOF
ServiceBinding is the resource that defines a Service Directory Service to be used in a BackendService resource.
EOF
}

variable "tcp_route" {
  type = list(map(object({
    id           = number
    name         = string
    labels       = optional(map(string))
    description  = optional(string)
    meshes_ids   = optional(list(number))
    gateways_ids = optional(list(number))
    project      = optional(string)
    rules = list(object({
      matches = optional(list(object({
        address = string
        port    = string
      })), [])
      action = list(object({
        original_destination = optional(bool)
        destinations = optional(list(object({
          service_name = optional(string)
          weight       = optional(number)
        })), [])
      }))
    }))
  })))
  default     = []
  description = <<EOF
TcpRoute is the resource defining how TCP traffic should be routed by a Mesh/Gateway resource.
EOF
}

variable "tls_route" {
  type = list(map(object({
    id           = number
    name         = string
    description  = optional(string)
    meshes_ids   = optional(list(number))
    gateways_ids = optional(list(number))
    project      = optional(string)
    rules = list(object({
      matches = optional(list(object({
        sni_host = optional(list(string))
        alpn     = optional(list(string))
      })), [])
      action = optional(list(object({
        destinations = optional(list(object({
          service_name = optional(string)
          weight       = optional(number)
        })), [])
      })), [])
    }))
  })))
  default     = []
  description = <<EOF
TlsRoute defines how traffic should be routed based on SNI and other matching L3 attributes.
EOF
}