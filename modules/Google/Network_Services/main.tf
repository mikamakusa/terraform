resource "google_network_services_edge_cache_keyset" "this" {
  count       = length(var.edge_cache_keyset)
  name        = lookup(var.edge_cache_keyset[count.index], "name")
  description = lookup(var.edge_cache_keyset[count.index], "description")
  labels      = merge(var.labels, lookup(var.edge_cache_keyset[count.index], "labels"))
  project     = lookup(var.edge_cache_keyset[count.index], "project")

  dynamic "public_key" {
    for_each = lookup(var.edge_cache_keyset[count.index], "public_key") == null ? [] : ["public_key"]
    content {
      id      = lookup(public_key.value, "id")
      value   = lookup(public_key.value, "value")
      managed = lookup(public_key.value, "managed")
    }
  }

  dynamic "validation_shared_keys" {
    for_each = lookup(var.edge_cache_keyset[count.index], "validation_shared_keys") == null ? [] : ["validation_shared_keys"]
    content {
      secret_version = lookup(validation_shared_keys.value, "secret_version")
    }
  }
}

resource "google_network_services_edge_cache_origin" "this" {
  count            = length(var.edge_cache_origin)
  name             = lookup(var.edge_cache_origin[count.index], "name")
  origin_address   = lookup(var.edge_cache_origin[count.index], "origin_address")
  description      = lookup(var.edge_cache_origin[count.index], "description")
  labels           = merge(var.labels, lookup(var.edge_cache_origin[count.index], "labels"))
  protocol         = lookup(var.edge_cache_origin[count.index], "protocol")
  port             = lookup(var.edge_cache_origin[count.index], "port")
  max_attempts     = lookup(var.edge_cache_origin[count.index], "max_attempts")
  failover_origin  = lookup(var.edge_cache_origin[count.index], "failover_origin")
  retry_conditions = lookup(var.edge_cache_origin[count.index], "retry_conditions")
  project          = lookup(var.edge_cache_origin[count.index], "project")

  dynamic "timeout" {
    for_each = lookup(var.edge_cache_origin[count.index], "timeout") == null ? [] : ["timeout"]
    content {
      connect_timeout      = lookup(timeout.value, "connect_timeout")
      max_attempts_timeout = lookup(timeout.value, "max_attempts_timeout")
      response_timeout     = lookup(timeout.value, "response_timeout")
      read_timeout         = lookup(timeout.value, "read_timeout")
    }
  }

  dynamic "aws_v4_authentication" {
    for_each = lookup(var.edge_cache_origin[count.index], "aws_v4_authentication") == null ? [] : ["aws_v4_authentication"]
    content {
      access_key_id             = lookup(aws_v4_authentication.value, "access_key_id")
      secret_access_key_version = lookup(aws_v4_authentication.value, "secret_access_key_version")
      origin_region             = lookup(aws_v4_authentication.value, "origin_region")
    }
  }

  dynamic "origin_override_action" {
    for_each = lookup(var.edge_cache_origin[count.index], "origin_override_action") == null ? [] : ["origin_override_action"]
    content {
      dynamic "url_rewrite" {
        for_each = lookup(origin_override_action.value, "url_rewrite") == null ? [] : ["url_rewrite"]
        content {
          host_rewrite = lookup(url_rewrite.value, "host_rewrite")
        }
      }
      dynamic "header_action" {
        for_each = lookup(origin_override_action.value, "header_action") == null ? [] : ["header_action"]
        content {
          dynamic "request_headers_to_add" {
            for_each = lookup(header_action.value, "request_headers_to_add") == null ? [] : ["request_headers_to_add"]
            content {
              header_name  = lookup(request_headers_to_add.value, "header_name")
              header_value = lookup(request_headers_to_add.value, "header_value")
              replace      = lookup(request_headers_to_add.value, "replace")
            }
          }
        }
      }
    }

    dynamic "origin_redirect" {
      for_each = lookup(var.edge_cache_origin[count.index], "origin_redirect") == null ? [] : ["origin_redirect"]
      content {
        redirect_conditions = lookup(origin_redirect.value, "redirect_conditions")
      }
    }
  }
}

resource "google_network_services_edge_cache_service" "this" {
  count                 = length(var.edge_cache_service)
  name                  = lookup(var.edge_cache_service[count.index], "name")
  description           = lookup(var.edge_cache_service[count.index], "description")
  labels                = merge(var.labels, lookup(var.edge_cache_service[count.index], "labels"))
  disable_quic          = lookup(var.edge_cache_service[count.index], "disable_quic")
  disable_http2         = lookup(var.edge_cache_service[count.index], "disable_http2")
  require_tls           = lookup(var.edge_cache_service[count.index], "require_tls")
  edge_ssl_certificates = lookup(var.edge_cache_service[count.index], "edge_ssl_certificates")
  ssl_policy            = lookup(var.edge_cache_service[count.index], "ssl_policy")
  edge_security_policy  = lookup(var.edge_cache_service[count.index], "edge_security_policy")
  project               = lookup(var.edge_cache_service[count.index], "project")

  dynamic "log_config" {
    for_each = lookup(var.edge_cache_service[count.index], "log_config") == null ? [] : ["log_config"]
    content {
      enable      = lookup(log_config.value, "enable")
      sample_rate = lookup(log_config.value, "sample_rate")
    }
  }

  dynamic "routing" {
    for_each = lookup(var.edge_cache_service[count.index], "routing") == null ? [] : ["routing"]
    content {
      dynamic "host_rule" {
        for_each = lookup(routing.value, "host_rule") == null ? [] : ["host_rule"]
        content {
          hosts        = lookup(host_rule.value, "hosts")
          path_matcher = lookup(host_rule.value, "path_matcher")
          description  = lookup(host_rule.value, "description")
        }
      }
      dynamic "path_matcher" {
        for_each = lookup(routing.value, "path_matcher") == null ? [] : ["path_matcher"]
        content {
          name        = lookup(path_matcher.value, "name")
          description = lookup(path_matcher.value, "description")

          dynamic "route_rule" {
            for_each = lookup(path_matcher.value, "route_rule") == null ? [] : ["route_rule"]
            content {
              priority    = lookup(route_rule.value, "priority")
              description = lookup(route_rule.value, "description")
              origin      = lookup(route_rule.value, "origin")

              dynamic "match_rule" {
                for_each = lookup(route_rule.value, "match_rule") == null ? [] : ["match_rule"]
                content {
                  ignore_case         = lookup(match_rule.value, "ignore_case")
                  prefix_match        = lookup(match_rule.value, "prefix_match")
                  path_template_match = lookup(match_rule.value, "path_template_match")
                  full_path_match     = lookup(match_rule.value, "full_path_match")

                  dynamic "query_parameter_match" {
                    for_each = lookup(match_rule.value, "query_parameter_match") == null ? [] : ["query_parameter_match"]
                    content {
                      name          = lookup(query_parameter_match.value, "name")
                      present_match = lookup(query_parameter_match.value, "present_match")
                      exact_match   = lookup(query_parameter_match.value, "exact_match")
                    }
                  }
                  dynamic "header_match" {
                    for_each = lookup(match_rule.value, "header_match") == null ? [] : ["header_match"]
                    content {
                      header_name   = lookup(header_match.value, "header_name")
                      present_match = lookup(header_match.value, "present_match")
                      exact_match   = lookup(header_match.value, "exact_match")
                      prefix_match  = lookup(header_match.value, "prefix_match")
                      suffix_match  = lookup(header_match.value, "suffix_match")
                      invert_match  = lookup(header_match.value, "invert_match")
                    }
                  }
                }
              }

              dynamic "header_action" {
                for_each = lookup(route_rule.value, "header_action") == null ? [] : ["header_action"]
                content {
                  dynamic "request_header_to_add" {
                    for_each = lookup(header_action.value, "request_header_to_add") == null ? [] : ["request_header_to_add"]
                    content {
                      header_name  = lookup(request_header_to_add.value, "header_name")
                      header_value = lookup(request_header_to_add.value, "header_value")
                      replace      = lookup(request_header_to_add.value, "replace")
                    }
                  }
                  dynamic "request_header_to_remove" {
                    for_each = lookup(header_action.value, "request_header_to_remove") == null ? [] : ["request_header_to_remove"]
                    content {
                      header_name = lookup(request_header_to_remove.value, "header_name")
                    }
                  }
                  dynamic "response_header_to_add" {
                    for_each = lookup(header_action.value, "response_header_to_add") == null ? [] : ["response_header_to_add"]
                    content {
                      header_name  = lookup(response_header_to_add.value, "header_name")
                      header_value = lookup(response_header_to_add.value, "header_value")
                      replace      = lookup(response_header_to_add.value, "replace")
                    }
                  }
                  dynamic "response_header_to_remove" {
                    for_each = lookup(header_action.value, "response_header_to_remove") == null ? [] : ["response_header_to_remove"]
                    content {
                      header_name = lookup(response_header_to_remove.value, "header_name")
                    }
                  }
                }
              }

              dynamic "route_action" {
                for_each = lookup(route_rule.value, "route_action") == null ? [] : ["route_action"]
                content {
                  dynamic "cdn_policy" {
                    for_each = lookup(route_action.value, "cdn_policy") == null ? [] : ["cdn_policy"]
                    content {
                      cache_mode                            = lookup(cdn_policy.value, "cache_mode")
                      client_ttl                            = lookup(cdn_policy.value, "client_ttl")
                      default_ttl                           = lookup(cdn_policy.value, "default_ttl")
                      max_ttl                               = lookup(cdn_policy.value, "max_ttl")
                      negative_caching                      = lookup(cdn_policy.value, "negative_caching")
                      negative_caching_policy               = lookup(cdn_policy.value, "negative_caching_policy")
                      signed_request_mode                   = lookup(cdn_policy.value, "signed_request_mode")
                      signed_request_keyset                 = lookup(cdn_policy.value, "signed_request_keyset")
                      signed_request_maximum_expiration_ttl = lookup(cdn_policy.value, "signed_request_maximum_expiration_ttl")

                      dynamic "add_signatures" {
                        for_each = lookup(cdn_policy.value, "add_signatures") == null ? [] : ["add_signatures"]
                        content {
                          actions               = lookup(add_signatures.value, "actions")
                          keyset                = lookup(add_signatures.value, "keyset")
                          token_ttl             = lookup(add_signatures.value, "token_ttl")
                          token_query_parameter = lookup(add_signatures.value, "token_query_parameter")
                          copied_parameters     = lookup(add_signatures.value, "copied_parameters")
                        }
                      }

                      dynamic "signed_token_options" {
                        for_each = lookup(cdn_policy.value, "signed_token_options") == null ? [] : ["signed_token_options"]
                        content {
                          token_query_parameter        = lookup(signed_token_options.value, "token_query_parameter")
                          allowed_signature_algorithms = lookup(signed_token_options.value, "allowed_signature_algorithms")
                        }
                      }

                      dynamic "cache_key_policy" {
                        for_each = lookup(cdn_policy.value, "cache_key_policy") == null ? [] : ["cache_key_policy"]
                        content {
                          include_protocol          = lookup(cache_key_policy.value, "include_protocol")
                          exclude_query_string      = lookup(cache_key_policy.value, "exclude_query_string")
                          exclude_host              = lookup(cache_key_policy.value, "exclude_host")
                          included_query_parameters = lookup(cache_key_policy.value, "included_query_parameters")
                          excluded_query_parameters = lookup(cache_key_policy.value, "excluded_query_parameters")
                          included_header_names     = lookup(cache_key_policy.value, "included_header_names")
                          included_cookie_names     = lookup(cache_key_policy.value, "included_cookie_names")
                        }
                      }
                    }
                  }
                  dynamic "url_rewrite" {
                    for_each = lookup(route_action.value, "url_rewrite") == null ? [] : ["url_rewrite"]
                    content {
                      path_prefix_rewrite   = lookup(url_rewrite.value, "path_prefix_rewrite")
                      path_template_rewrite = lookup(url_rewrite.value, "path_template_rewrite")
                      host_rewrite          = lookup(url_rewrite.value, "host_rewrite")
                    }
                  }
                  dynamic "cors_policy" {
                    for_each = lookup(route_action.value, "cors_policy") == null ? [] : ["cors_policy"]
                    content {
                      max_age           = lookup(cors_policy.value, "max_age")
                      allow_credentials = lookup(cors_policy.value, "allow_credentials")
                      allow_origins     = lookup(cors_policy.value, "allow_origins")
                      allow_headers     = lookup(cors_policy.value, "allow_headers")
                      allow_methods     = lookup(cors_policy.value, "allow_methods")
                      expose_headers    = lookup(cors_policy.value, "expose_headers")
                      disabled          = lookup(cors_policy.value, "disabled")
                    }
                  }
                }
              }

              dynamic "url_redirect" {
                for_each = lookup(route_rule.value, "url_redirect") == null ? [] : ["url_redirect"]
                content {
                  host_redirect          = lookup(url_redirect.value, "host_redirect")
                  prefix_redirect        = lookup(url_redirect.value, "prefix_redirect")
                  path_redirect          = lookup(url_redirect.value, "path_redirect")
                  redirect_response_code = lookup(url_redirect.value, "redirect_response_code")
                  https_redirect         = lookup(url_redirect.value, "https_redirect")
                  strip_query            = lookup(url_redirect.value, "strip_query")
                }
              }
            }
          }
        }
      }
    }
  }
}

resource "google_network_services_endpoint_policy" "this" {
  count                = length(var.endpoint_policy)
  name                 = lookup(var.endpoint_policy[count.index], "name")
  type                 = lookup(var.endpoint_policy[count.index], "type")
  labels               = merge(var.labels, lookup(var.endpoint_policy[count.index], "labels"))
  description          = lookup(var.endpoint_policy[count.index], "description")
  authorization_policy = lookup(var.endpoint_policy[count.index], "authorization_policy")
  server_tls_policy    = lookup(var.endpoint_policy[count.index], "server_tls_policy")
  client_tls_policy    = lookup(var.endpoint_policy[count.index], "client_tls_policy")
  project              = lookup(var.endpoint_policy[count.index], "project")

  dynamic "endpoint_matcher" {
    for_each = lookup(var.endpoint_policy[count.index], "endpoint_matcher") == null ? [] : ["endpoint_matcher"]
    content {
      dynamic "metadata_label_matcher" {
        for_each = lookup(endpoint_matcher.value, "metadata_label_matcher") == null ? [] : ["metadata_label_matcher"]
        content {
          metadata_label_match_criteria = lookup(metadata_label_matcher.value, "metadata_label_match_criteria")

          dynamic "metadata_labels" {
            for_each = lookup(metadata_label_matcher.value, "metadata_labels") == null ? [] : ["metadata_labels"]
            content {
              label_name  = lookup(metadata_labels.value, "label_name")
              label_value = lookup(metadata_labels.value, "label_value")
            }
          }
        }
      }
    }
  }

  dynamic "traffic_port_selector" {
    for_each = lookup(var.endpoint_policy[count.index], "traffic_port_selector") == null ? [] : ["traffic_port_selector"]
    content {
      ports = lookup(traffic_port_selector.value, "ports")
    }
  }
}

resource "google_network_services_gateway" "this" {
  count                                = length(var.gateway)
  name                                 = lookup(var.gateway[count.index], "name")
  ports                                = lookup(var.gateway[count.index], "ports")
  type                                 = lookup(var.gateway[count.index], "type")
  labels                               = merge(var.labels, lookup(var.gateway[count.index], "labels"))
  description                          = lookup(var.gateway[count.index], "description")
  scope                                = lookup(var.gateway[count.index], "scope")
  server_tls_policy                    = lookup(var.gateway[count.index], "server_tls_policy")
  addresses                            = lookup(var.gateway[count.index], "addresses")
  subnetwork                           = lookup(var.gateway[count.index], "subnetwork")
  network                              = lookup(var.gateway[count.index], "network")
  gateway_security_policy              = lookup(var.gateway[count.index], "gateway_security_policy")
  certificate_urls                     = lookup(var.gateway[count.index], "certificate_urls")
  location                             = lookup(var.gateway[count.index], "location")
  project                              = lookup(var.gateway[count.index], "project")
  delete_swg_autogen_router_on_destroy = lookup(var.gateway[count.index], "delete_swg_autogen_router_on_destroy")
}

resource "google_network_services_grpc_route" "this" {
  count       = length(var.grpc_route)
  hostnames   = lookup(var.grpc_route[count.index], "hostnames")
  name        = lookup(var.grpc_route[count.index], "name")
  labels      = merge(var.labels, lookup(var.grpc_route[count.index], "labels"))
  description = lookup(var.grpc_route[count.index], "description")
  meshes      = lookup(var.grpc_route[count.index], "meshes")
  gateways    = lookup(var.grpc_route[count.index], "gateways")
  project     = lookup(var.grpc_route[count.index], "project")

  dynamic "rules" {
    for_each = lookup(var.grpc_route[count.index], "rules")
    content {
      dynamic "matches" {
        for_each = lookup(rules.value, "matches") == null ? [] : ["matches"]
        content {
          dynamic "headers" {
            for_each = lookup(matches.value, "headers") == null ? [] : ["headers"]
            content {
              key   = lookup(headers.value, "key")
              value = lookup(headers.value, "value")
              type  = lookup(headers.value, "type")
            }
          }
          dynamic "method" {
            for_each = lookup(matches.value, "method") == null ? [] : ["method"]
            content {
              grpc_method    = lookup(method.value, "grpc_method")
              grpc_service   = lookup(method.value, "grpc_service")
              case_sensitive = lookup(method.value, "case_sensitive")
            }
          }
        }
      }
      dynamic "action" {
        for_each = lookup(rules.value, "action") == null ? [] : ["action"]
        content {
          timeout = lookup(action.value, "timeout")
          dynamic "destinations" {
            for_each = lookup(action.value, "destinations") == null ? [] : ["destinations"]
            content {
              service_name = lookup(destinations.value, "service_name")
              weight       = lookup(destinations.value, "weight")
            }
          }
          dynamic "fault_injection_policy" {
            for_each = lookup(action.value, "fault_injection_policy") == null ? [] : ["fault_injection_policy"]
            content {
              dynamic "delay" {
                for_each = lookup(fault_injection_policy.value, "delay") == null ? [] : ["delay"]
                content {
                  fixed_delay = lookup(delay.value, "fixed_delay")
                  percentage  = lookup(delay.value, "percentage")
                }
              }
              dynamic "abort" {
                for_each = lookup(fault_injection_policy.value, "abort") == null ? [] : ["abort"]
                content {
                  http_status = lookup(abort.value, "http_status")
                  percentage  = lookup(abort.value, "percentage")
                }
              }
            }
          }
          dynamic "retry_policy" {
            for_each = lookup(action.value, "retry_policy") == null ? [] : ["retry_policy"]
            content {
              retry_conditions = lookup(retry_policy.value, "retry_conditions")
              num_retries      = lookup(retry_policy.value, "num_retries")
            }
          }
        }
      }
    }
  }
}

resource "google_network_services_http_route" "this" {
  count       = length(var.http_route)
  hostnames   = lookup(var.http_route[count.index], "hostnames")
  name        = lookup(var.http_route[count.index], "name")
  labels      = {}
  description = lookup(var.http_route[count.index], "description")
  meshes      = lookup(var.http_route[count.index], "meshes")
  gateways    = lookup(var.http_route[count.index], "gateways")
  project     = lookup(var.http_route[count.index], "project")

  dynamic "rules" {
    for_each = lookup(var.http_route[count.index], "rules")
    content {
      dynamic "matches" {
        for_each = lookup(rules.value, "matches") == null ? [] : ["matches"]
        content {
          ignore_case     = lookup(matches.value, "ignore_case")
          full_path_match = lookup(matches.value, "full_path_match")
          prefix_match    = lookup(matches.value, "prefix_match")
          regex_match     = lookup(matches.value, "regex_match")
          dynamic "query_parameters" {
            for_each = lookup(matches.value, "query_parameters") == null ? [] : ["query_parameters"]
            content {
              query_parameter = lookup(query_parameters.value, "query_parameter")
              exact_match     = lookup(query_parameters.value, "exact_match")
              regex_match     = lookup(query_parameters.value, "regex_match")
              present_match   = lookup(query_parameters.value, "present_match")
            }
          }
          dynamic "headers" {
            for_each = lookup(matches.value, "headers") == null ? [] : ["headers"]
            content {
              header        = lookup(headers.value, "header")
              invert_match  = lookup(headers.value, "invert_match")
              exact_match   = lookup(headers.value, "exact_match")
              regex_match   = lookup(headers.value, "regex_match")
              prefix_match  = lookup(headers.value, "prefix_match")
              present_match = lookup(headers.value, "present_match")
              suffix_match  = lookup(headers.value, "suffix_match")
              dynamic "range_match" {
                for_each = lookup(headers.value, "range_match") == null ? [] : ["range_match"]
                content {
                  end   = lookup(range_match.value, "end")
                  start = lookup(range_match.value, "start")
                }
              }
            }
          }
        }
      }
      dynamic "action" {
        for_each = lookup(rules.value, "action") == null ? [] : ["action"]
        content {
          timeout = lookup(action.value, "timeout")
          dynamic "destinations" {
            for_each = lookup(action.value, "destinations") == null ? [] : ["destinations"]
            content {
              service_name = lookup(destinations.value, "service_name")
              weight       = lookup(destinations.value, "weight")
            }
          }
          dynamic "redirect" {
            for_each = lookup(action.value, "redirect") == null ? [] : ["redirect"]
            content {
              host_redirect  = lookup(redirect.value, "host_redirect")
              path_redirect  = lookup(redirect.value, "path_redirect")
              prefix_rewrite = lookup(redirect.value, "prefix_rewrite")
              response_code  = lookup(redirect.value, "response_code")
              https_redirect = lookup(redirect.value, "https_redirect")
              strip_query    = lookup(redirect.value, "strip_query")
              port_redirect  = lookup(redirect.value, "port_redirect")
            }
          }
          dynamic "fault_injection_policy" {
            for_each = lookup(action.value, "fault_injection_policy") == null ? [] : ["fault_injection_policy"]
            content {
              dynamic "delay" {
                for_each = lookup(fault_injection_policy.value, "delay") == null ? [] : ["delay"]
                content {
                  fixed_delay = lookup(delay.value, "fixed_delay")
                  percentage  = lookup(delay.value, "percentage")
                }
              }
              dynamic "abort" {
                for_each = lookup(fault_injection_policy.value, "abort") == null ? [] : ["abort"]
                content {
                  http_status = lookup(abort.value, "http_status")
                  percentage  = lookup(abort.value, "percentage")
                }
              }
            }
          }
          dynamic "request_header_modifier" {
            for_each = lookup(action.value, "request_header_modifier") == null ? [] : ["request_header_modifier"]
            content {
              set    = lookup(request_header_modifier.value, "set")
              add    = lookup(request_header_modifier.value, "add")
              remove = lookup(request_header_modifier.value, "remove")
            }
          }
          dynamic "response_header_modifier" {
            for_each = lookup(action.value, "response_header_modifier") == null ? [] : ["response_header_modifier"]
            content {
              set    = lookup(response_header_modifier.value, "set")
              add    = lookup(response_header_modifier.value, "add")
              remove = lookup(response_header_modifier.value, "remove")
            }
          }
          dynamic "url_rewrite" {
            for_each = lookup(action.value, "url_rewrite") == null ? [] : ["url_rewrite"]
            content {
              path_prefix_rewrite = lookup(url_rewrite.value, "path_prefix_rewrite")
              host_rewrite        = lookup(url_rewrite.value, "host_rewrite")
            }
          }
          dynamic "retry_policy" {
            for_each = lookup(action.value, "retry_policy") == null ? [] : ["retry_policy"]
            content {
              retry_conditions = lookup(retry_policy.value, "retry_conditions")
              num_retries      = lookup(retry_policy.value, "num_retries")
              per_try_timeout  = lookup(retry_policy.value, "per_try_timeout")
            }
          }
          dynamic "request_mirror_policy" {
            for_each = lookup(action.value, "request_mirror_policy") == null ? [] : ["request_mirror_policy"]
            content {
              dynamic "destination" {
                for_each = lookup(request_mirror_policy.value, "destination") == null ? [] : ["destination"]
                content {
                  service_name = lookup(destination.value, "service_name")
                  weight       = lookup(destination.value, "weight")
                }
              }
            }
          }
          dynamic "cors_policy" {
            for_each = lookup(action.value, "cors_policy") == null ? [] : ["cors_policy"]
            content {
              allow_origins        = lookup(cors_policy.value, "allow_origins")
              allow_origin_regexes = lookup(cors_policy.value, "allow_origin_regexes")
              allow_methods        = lookup(cors_policy.value, "allow_methods")
              allow_headers        = lookup(cors_policy.value, "allow_headers")
              expose_headers       = lookup(cors_policy.value, "expose_headers")
              max_age              = lookup(cors_policy.value, "max_age")
              allow_credentials    = lookup(cors_policy.value, "allow_credentials")
              disabled             = lookup(cors_policy.value, "disabled")
            }
          }
        }
      }
    }
  }
}

resource "google_network_services_mesh" "this" {
  count             = length(var.mesh)
  name              = lookup(var.mesh[count.index], "name")
  labels            = merge(var.labels, lookup(var.mesh[count.index], "labels"))
  description       = lookup(var.mesh[count.index], "description")
  interception_port = lookup(var.mesh[count.index], "interception_port")
  project           = lookup(var.mesh[count.index], "project")
}

resource "google_network_services_service_binding" "this" {
  count       = length(var.service_binding)
  name        = lookup(var.service_binding[count.index], "name")
  service     = lookup(var.service_binding[count.index], "service")
  labels      = merge(var.labels, lookup(var.service_binding[count.index], "labels"))
  description = lookup(var.service_binding[count.index], "description")
  project     = lookup(var.service_binding[count.index], "project")
}

resource "google_network_services_tcp_route" "this" {
  count       = length(var.tcp_route)
  name        = lookup(var.tcp_route[count.index], "name")
  labels      = merge(var.labels, lookup(var.tcp_route[count.index], "labels"))
  description = lookup(var.tcp_route[count.index], "description")
  meshes      = lookup(var.tcp_route[count.index], "meshes")
  gateways    = lookup(var.tcp_route[count.index], "gateways")
  project     = lookup(var.tcp_route[count.index], "project")

  dynamic "rules" {
    for_each = lookup(var.tcp_route[count.index], "rules")
    content {
      dynamic "matches" {
        for_each = lookup(rules.value, "matches") == null ? [] : ["matches"]
        content {
          address = lookup(matches.value, "address")
          port    = lookup(matches.value, "port")
        }
      }

      dynamic "action" {
        for_each = lookup(rules.value, "action") == null ? [] : ["action"]
        content {
          original_destination = lookup(action.value, "original_destination")
          dynamic "destinations" {
            for_each = lookup(action.value, "destinations") == null ? [] : ["destinations"]
            content {
              service_name = lookup(destinations.value, "service_name")
              weight       = lookup(destinations.value, "weight")
            }
          }
        }
      }
    }
  }
}

resource "google_network_services_tls_route" "this" {
  count       = length(var.tls_route)
  name        = lookup(var.tls_route[count.index], "name")
  description = lookup(var.tls_route[count.index], "description")
  meshes      = lookup(var.tls_route[count.index], "meshes")
  gateways    = lookup(var.tls_route[count.index], "gateways")
  project     = lookup(var.tls_route[count.index], "project")

  dynamic "rules" {
    for_each = lookup(var.tls_route[count.index], "rules")
    content {
      dynamic "matches" {
        for_each = lookup(rules.value, "matches") == null ? [] : ["matches"]
        content {
          sni_host = lookup(matches.value, "sni_host")
          alpn     = lookup(matches.value, "alpn")
        }
      }
      dynamic "action" {
        for_each = lookup(rules.value, "action") == null ? [] : ["action"]
        content {
          dynamic "destinations" {
            for_each = lookup(action.value, "destinations") == null ? [] : ["destinations"]
            content {
              service_name = lookup(destinations.value, "service_name")
              weight       = lookup(destinations.value, "weight")
            }
          }
        }
      }
    }
  }
}

