resource "azurerm_cdn_endpoint" "this" {
  count                         = length(var.endpoint) == "0" ? "0" : length(var.profile)
  location                      = data.azurerm_resource_group.this.location
  name                          = lookup(var.endpoint[count.index], "name")
  profile_name                  = try(element(azurerm_cdn_profile.this.*.name, lookup(var.endpoint[count.index], "profile_id")))
  resource_group_name           = data.azurerm_resource_group.this.name
  is_http_allowed               = lookup(var.endpoint[count.index], "is_http_allowed")
  is_https_allowed              = lookup(var.endpoint[count.index], "is_https_allowed")
  is_compression_enabled        = lookup(var.endpoint[count.index], "is_compression_enabled")
  content_types_to_compress     = lookup(var.endpoint[count.index], "content_types_to_compress")
  querystring_caching_behaviour = lookup(var.endpoint[count.index], "querystring_caching_behaviour")
  optimization_type             = lookup(var.endpoint[count.index], "optimization_type")
  origin_host_header            = lookup(var.endpoint[count.index], "origin_host_header")
  origin_path                   = lookup(var.endpoint[count.index], "origin_path")
  probe_path                    = lookup(var.endpoint[count.index], "probe_path")
  tags = merge(
    var.tags,
    lookup(var.endpoint[count.index], "tags")
  )

  dynamic "geo_filter" {
    for_each = lookup(var.endpoint[count.index], "geo_filter") == null ? [] : ["geo_filter"]
    content {
      action        = lookup(geo_filter.value, "action")
      country_codes = lookup(geo_filter.value, "country_codes")
      relative_path = lookup(geo_filter.value, "relative_path")
    }
  }

  dynamic "origin" {
    for_each = lookup(var.endpoint[count.index], "origin") == null ? [] : ["origin"]
    content {
      host_name  = lookup(origin.value, "host_name")
      name       = lookup(origin.value, "name")
      http_port  = lookup(origin.value, "http_port")
      https_port = lookup(origin.value, "https_port")
    }
  }

  dynamic "global_delivery_rule" {
    for_each = lookup(var.endpoint[count.index], "global_delivery_rule")
    content {
      dynamic "cache_expiration_action" {
        for_each = lookup(global_delivery_rule.value, "cache_expiration_action") == null ? [] : ["cache_expiration_action"]
        content {
          behavior = lookup(cache_expiration_action.value, "behavior")
        }
      }

      dynamic "cache_key_query_string_action" {
        for_each = lookup(global_delivery_rule.value, "cache_key_query_string_action") == null ? [] : ["cache_key_query_string_action"]
        content {
          behavior = lookup(cache_key_query_string_action.value, "behavior")
        }
      }

      dynamic "modify_request_header_action" {
        for_each = lookup(global_delivery_rule.value, "modify_request_header_action") == null ? [] : ["modify_request_header_action"]
        content {
          action = lookup(modify_request_header_action.value, "action")
          name   = lookup(modify_request_header_action.value, "name")
          value  = lookup(modify_request_header_action.value, "value")
        }
      }

      dynamic "modify_response_header_action" {
        for_each = lookup(global_delivery_rule.value, "modify_response_header_action") == null ? [] : ["modify_response_header_action"]
        content {
          action = lookup(modify_response_header_action.value, "action")
          name   = lookup(modify_response_header_action.value, "name")
          value  = lookup(modify_response_header_action.value, "value")
        }
      }

      dynamic "url_redirect_action" {
        for_each = lookup(global_delivery_rule.value, "url_redirect_action") == null ? [] : ["url_redirect_action"]
        content {
          redirect_type = lookup(url_redirect_action.value, "redirect_type")
          protocol      = lookup(url_redirect_action.value, "protocol")
          hostname      = lookup(url_redirect_action.value, "hostname")
          path          = lookup(url_redirect_action.value, "path")
          fragment      = lookup(url_redirect_action.value, "fragment")
          query_string  = lookup(url_redirect_action.value, "query_string")
        }
      }

      dynamic "url_rewrite_action" {
        for_each = ""
        content {
          destination             = lookup(url_rewrite_action.value, "destination")
          source_pattern          = lookup(url_rewrite_action.value, "source_pattern")
          preserve_unmatched_path = lookup(url_rewrite_action.value, "preserve_unmatched_path")
        }

      }
    }
  }

  dynamic "delivery_rule" {
    for_each = lookup(var.endpoint[count.index], "delivery_rule")
    content {
      name  = lookup(delivery_rule.value, "name")
      order = lookup(delivery_rule.value, "order")

      dynamic "cache_expiration_action" {
        for_each = lookup(delivery_rule.value, "cache_expiration_action") == null ? [] : ["cache_expiration_action"]
        content {
          behavior = lookup(cache_expiration_action.value, "behavior")
        }
      }

      dynamic "cache_key_query_string_action" {
        for_each = lookup(delivery_rule.value, "cache_key_query_string_action") == null ? [] : ["cache_key_query_string_action"]
        content {
          behavior = lookup(cache_key_query_string_action.value, "behavior")
        }
      }

      dynamic "cookies_condition" {
        for_each = lookup(delivery_rule.value, "cookies_condition") == null ? [] : ["cookies_condition"]
        content {
          operator = lookup(cookies_condition.value, "operator")
          selector = lookup(cookies_condition.value, "selector")
        }
      }

      dynamic "device_condition" {
        for_each = lookup(delivery_rule.value, "device_condition") == null ? [] : ["device_condition"]
        content {
          match_values = lookup(device_condition.value, "match_values")
        }
      }

      dynamic "http_version_condition" {
        for_each = lookup(delivery_rule.value, "http_version_condition") == null ? [] : ["http_version_condition"]
        content {
          match_values = lookup(http_version_condition.value, "match_values")
        }
      }

      dynamic "modify_request_header_action" {
        for_each = lookup(delivery_rule.value, "modify_request_header_action") == null ? [] : ["modify_request_header_action"]
        content {
          action = lookup(modify_request_header_action.value, "action")
          name   = lookup(modify_request_header_action.value, "name")
          value  = lookup(modify_request_header_action.value, "value")
        }
      }

      dynamic "modify_response_header_action" {
        for_each = lookup(delivery_rule.value, "modify_response_header_action") == null ? [] : ["modify_response_header_action"]
        content {
          action = lookup(modify_response_header_action.value, "action")
          name   = lookup(modify_response_header_action.value, "name")
          value  = lookup(modify_response_header_action.value, "value")
        }
      }

      dynamic "post_arg_condition" {
        for_each = lookup(delivery_rule.value, "post_arg_condition") == null ? [] : ["post_arg_condition"]
        content {
          operator = lookup(post_arg_condition.value, "operator")
          selector = lookup(post_arg_condition.value, "selector")
        }
      }

      dynamic "query_string_condition" {
        for_each = lookup(delivery_rule.value, "query_string_condition") == null ? [] : ["query_string_condition"]
        content {
          operator = lookup(query_string_condition.value, "operator")
        }
      }

      dynamic "remote_address_condition" {
        for_each = lookup(delivery_rule.value, "remote_address_condition") == null ? [] : ["remote_address_condition"]
        content {
          operator = lookup(remote_address_condition.value, "operator")
        }
      }

      dynamic "request_body_condition" {
        for_each = lookup(delivery_rule.value, "request_body_condition") == null ? [] : ["request_body_condition"]
        content {
          operator = lookup(request_body_condition.value, "operator")
        }
      }

      dynamic "request_header_condition" {
        for_each = lookup(delivery_rule.value, "request_header_condition") == null ? [] : ["request_header_condition"]
        content {
          operator = lookup(request_header_condition.value, "operator")
          selector = lookup(request_header_condition.value, "selector")
        }
      }

      dynamic "request_method_condition" {
        for_each = lookup(delivery_rule.value, "request_method_condition") == null ? [] : ["request_method_condition"]
        content {
          match_values = lookup(request_method_condition.value, "match_values")
        }
      }

      dynamic "request_scheme_condition" {
        for_each = lookup(delivery_rule.value, "request_scheme_condition") == null ? [] : ["request_scheme_condition"]
        content {
          match_values = lookup(request_scheme_condition.value, "match_values")
        }
      }

      dynamic "request_uri_condition" {
        for_each = lookup(delivery_rule.value, "request_uri_condition") == null ? [] : ["request_uri_condition"]
        content {
          operator = lookup(request_uri_condition.value, "operator")
        }
      }

      dynamic "url_file_extension_condition" {
        for_each = lookup(delivery_rule.value, "url_file_extension_condition") == null ? [] : ["url_file_extension_condition"]
        content {
          operator = lookup(url_file_extension_condition.value, "operator")
        }
      }

      dynamic "url_file_name_condition" {
        for_each = lookup(delivery_rule.value, "url_file_name_condition") == null ? [] : ["url_file_name_condition"]
        content {
          operator = lookup(url_file_name_condition.value, "operator")
        }
      }

      dynamic "url_path_condition" {
        for_each = lookup(delivery_rule.value, "url_path_condition") == null ? [] : ["url_path_condition"]
        content {
          operator = lookup(url_path_condition.value, "operator")
        }
      }

      dynamic "url_redirect_action" {
        for_each = lookup(delivery_rule.value, "url_redirect_action") == null ? [] : ["url_redirect_action"]
        content {
          redirect_type = lookup(url_redirect_action.value, "redirect_type")
          protocol      = lookup(url_redirect_action.value, "protocol")
          hostname      = lookup(url_redirect_action.value, "hostname")
          path          = lookup(url_redirect_action.value, "path")
          fragment      = lookup(url_redirect_action.value, "fragment")
          query_string  = lookup(url_redirect_action.value, "query_string")
        }
      }

      dynamic "url_rewrite_action" {
        for_each = lookup(delivery_rule.value, "url_rewrite_action") == null ? [] : ["url_rewrite_action"]
        content {
          destination             = lookup(url_rewrite_action.value, "destination")
          source_pattern          = lookup(url_rewrite_action.value, "source_pattern")
          preserve_unmatched_path = lookup(url_rewrite_action.value, "preserve_unmatched_path")
        }
      }
    }
  }
}

resource "azurerm_cdn_endpoint_custom_domain" "this" {
  count           = length(var.endpoint_custom_domain) == "0" ? "0" : length(var.endpoint)
  cdn_endpoint_id = try(element(azurerm_cdn_endpoint.this.*.id, lookup(var.endpoint_custom_domain[count.index], "cdn_endpoint_id")))
  host_name       = lookup(var.endpoint_custom_domain[count.index], "host_name")
  name            = lookup(var.endpoint_custom_domain[count.index], "name")

  dynamic "cdn_managed_https" {
    for_each = lookup(var.endpoint_custom_domain[count.index], "cdn_managed_https") == null ? [] : ["cdn_managed_https"]
    content {
      certificate_type = lookup(cdn_managed_https.value, "certificate_type")
      protocol_type    = lookup(cdn_managed_https.value, "protocol_type")
      tls_version      = lookup(cdn_managed_https.value, "tls_version")
    }
  }

  dynamic "user_managed_https" {
    for_each = lookup(var.endpoint_custom_domain[count.index], "user_managed_https") == null ? [] : ["user_managed_https"]
    content {
      key_vault_certificate_id = lookup(user_managed_https.value, "key_vault_certificate_id")
      key_vault_secret_id      = lookup(user_managed_https.value, "key_vault_secret_id")
      tls_version              = lookup(user_managed_https.value, "tls_version")
    }
  }
}

resource "azurerm_cdn_frontdoor_custom_domain" "this" {
  count                    = length(var.frontdoor_custom_domain) == "0" ? "0" : length(var.frontdoor_profile)
  cdn_frontdoor_profile_id = try(element(azurerm_cdn_frontdoor_profile.this.*.id, lookup(var.frontdoor_custom_domain[count.index], "cdn_frontdoor_profile_id")))
  host_name                = lookup(var.frontdoor_custom_domain[count.index], "host_name")
  name                     = lookup(var.frontdoor_custom_domain[count.index], "name")
  dns_zone_id              = lookup(var.frontdoor_custom_domain[count.index], "dns_zone_id")

  dynamic "tls" {
    for_each = lookup(var.frontdoor_custom_domain[count.index], "tls") == null ? [] : ["tls"]
    content {
      certificate_type        = lookup(tls.value, "certificate_type")
      minimum_tls_version     = lookup(tls.value, "minimum_tls_version")
      cdn_frontdoor_secret_id = lookup(tls.value, "cdn_frontdoor_secret_id")
    }
  }
}

resource "azurerm_cdn_frontdoor_custom_domain_association" "this" {
  count                          = length(var.frontdoor_custom_domain_association) == "0" ? "0" : (length(var.frontdoor_custom_domain) && length(var.frontdoor_route))
  cdn_frontdoor_custom_domain_id = try(element(azurerm_cdn_frontdoor_custom_domain.this.*.id, lookup(var.frontdoor_custom_domain_association[count.index], "cdn_frontdoor_custom_domain_id")))
  cdn_frontdoor_route_ids        = try(element(azurerm_cdn_frontdoor_route.this.*.id, lookup(var.frontdoor_custom_domain_association[count.index], "cdn_frontdoor_route_ids")))
}

resource "azurerm_cdn_frontdoor_endpoint" "this" {
  count                    = length(var.frontdoor_endpoint) == "0" ? "0" : length(var.frontdoor_profile)
  cdn_frontdoor_profile_id = try(element(azurerm_cdn_frontdoor_endpoint.this.*.id, lookup(var.frontdoor_endpoint[count.index], "cdn_frontdoor_profile_id")))
  name                     = lookup(var.frontdoor_endpoint[count.index], "name")
  enabled                  = lookup(var.frontdoor_endpoint[count.index], "enabled")
  tags = merge(
    var.tags,
    lookup(var.frontdoor_endpoint[count.index], "tags")
  )
}

resource "azurerm_cdn_frontdoor_firewall_policy" "this" {
  count                             = length(var.frontdoor_firewall_policy)
  mode                              = lookup(var.frontdoor_firewall_policy[count.index], "mode")
  name                              = lookup(var.frontdoor_firewall_policy[count.index], "name")
  resource_group_name               = data.azurerm_resource_group.this.name
  sku_name                          = lookup(var.frontdoor_firewall_policy[count.index], "sku_name")
  enabled                           = lookup(var.frontdoor_firewall_policy[count.index], "enabled")
  redirect_url                      = lookup(var.frontdoor_firewall_policy[count.index], "redirect_url")
  custom_block_response_body        = lookup(var.frontdoor_firewall_policy[count.index], "custom_block_response_body")
  custom_block_response_status_code = lookup(var.frontdoor_firewall_policy[count.index], "custom_block_response_status_code")
  tags = merge(
    var.tags,
    lookup(var.frontdoor_firewall_policy[count.index], "tags")
  )

  dynamic "custom_rule" {
    for_each = lookup(var.frontdoor_firewall_policy[count.index], "custom_rule") == null ? [] : ["custom_rule"]
    content {
      action                         = lookup(custom_rule.value, "action")
      name                           = lookup(custom_rule.value, "name")
      type                           = lookup(custom_rule.value, "type")
      enabled                        = lookup(custom_rule.value, "enabled")
      priority                       = lookup(custom_rule.value, "priority")
      rate_limit_duration_in_minutes = lookup(custom_rule.value, "rate_limit_duration_in_minutes")
      rate_limit_threshold           = lookup(custom_rule.value, "rate_limit_threshold")

      dynamic "match_condition" {
        for_each = lookup(custom_rule.value, "match_condition") == null ? [] : ["match_condition"]
        content {
          match_values       = lookup(match_condition.value, "match_values")
          match_variable     = lookup(match_condition.value, "match_variable")
          operator           = lookup(match_condition.value, "operator")
          selector           = lookup(match_condition.value, "selector")
          negation_condition = lookup(match_condition.value, "negation_condition")
          transforms         = lookup(match_condition.value, "transforms")
        }
      }
    }
  }

  dynamic "managed_rule" {
    for_each = lookup(var.frontdoor_firewall_policy[count.index], "managed_rule") == null ? [] : ["managed_rule"]
    content {
      action  = lookup(managed_rule.value, "action")
      type    = lookup(managed_rule.value, "type")
      version = lookup(managed_rule.value, "version")

      dynamic "exclusion" {
        for_each = lookup(managed_rule.value, "exclusion") == null ? [] : ["exclusion"]
        content {
          match_variable = lookup(exclusion.value, "match_variable")
          operator       = lookup(exclusion.value, "operator")
          selector       = lookup(exclusion.value, "selector")
        }
      }

      dynamic "override" {
        for_each = lookup(managed_rule.value, "override") == null ? [] : ["override"]
        content {
          rule_group_name = lookup(override.value, rule_group_name)

          dynamic "exclusion" {
            for_each = lookup(override.value, "exclusion") == null ? [] : ["exclusion"]
            content {
              match_variable = lookup(exclusion.value, "match_variable")
              operator       = lookup(exclusion.value, "operator")
              selector       = lookup(exclusion.value, "selector")
            }
          }
          dynamic "rule" {
            for_each = lookup(override.value, "rule") == null ? [] : ["rule"]
            content {
              action  = lookup(rule.value, "action")
              rule_id = lookup(rule.value, "rule_id")
              enabled = lookup(rule.value, "enabled")

              dynamic "exclusion" {
                for_each = lookup(rule.value, "exclusion") == null ? [] : ["exclusion"]
                content {
                  match_variable = lookup(exclusion.value, "match_variable")
                  operator       = lookup(exclusion.value, "operator")
                  selector       = lookup(exclusion.value, "selector")
                }
              }
            }
          }
        }
      }
    }
  }
}

resource "azurerm_cdn_frontdoor_origin" "this" {
  count                          = length(var.frontdoor_origin) == "0" ? "0" : length(var.frontdoor_origin_group)
  cdn_frontdoor_origin_group_id  = try(element(azurerm_cdn_frontdoor_origin_group.this.*.id, lookup(var.frontdoor_origin[count.index], "cdn_frontdoor_origin_group_id")))
  certificate_name_check_enabled = lookup(var.frontdoor_origin[count.index], "certificate_name_check_enabled")
  host_name                      = lookup(var.frontdoor_origin[count.index], "host_name")
  name                           = lookup(var.frontdoor_origin[count.index], "name")
  enabled                        = lookup(var.frontdoor_origin[count.index], "enabled")
  http_port                      = lookup(var.frontdoor_origin[count.index], "http_port")
  https_port                     = lookup(var.frontdoor_origin[count.index], "https_port")
  origin_host_header             = lookup(var.frontdoor_origin[count.index], "origin_host_header")
  priority                       = lookup(var.frontdoor_origin[count.index], "priority")
  weight                         = lookup(var.frontdoor_origin[count.index], "weight")

  dynamic "private_link" {
    for_each = lookup(var.frontdoor_origin[count.index], "private_link") == null ? [] : ["private_link"]
    content {
      location               = lookup(private_link.value, "location")
      private_link_target_id = lookup(private_link.value, "private_link_target_id")
      request_message        = lookup(private_link.value, "request_message")
      target_type            = lookup(private_link.value, "target_type")
    }
  }
}

resource "azurerm_cdn_frontdoor_origin_group" "this" {
  count                                                     = length(var.frontdoor_origin_group) == "0" ? "0" : length(var.frontdoor_profile)
  cdn_frontdoor_profile_id                                  = try(element(azurerm_cdn_frontdoor_profile.this.*.id, lookup(var.frontdoor_origin_group[count.index], "cdn_frontdoor_profile_id")))
  name                                                      = lookup(var.frontdoor_origin_group[count.index], "name")
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = lookup(var.frontdoor_origin_group[count.index], "restore_traffic_time_to_healed_or_new_endpoint_in_minutes")
  session_affinity_enabled                                  = lookup(var.frontdoor_origin_group[count.index], "session_affinity_enabled")

  dynamic "load_balancing" {
    for_each = lookup(var.frontdoor_origin_group[count.index], "load_balancing")
    content {
      additional_latency_in_milliseconds = lookup(load_balancing.value, "additional_latency_in_milliseconds")
      sample_size                        = lookup(load_balancing.value, "sample_size")
      successful_samples_required        = lookup(load_balancing.value, "successful_samples_required")
    }
  }

  dynamic "health_probe" {
    for_each = lookup(var.frontdoor_origin_group[count.index], "health_probe") == null ? [] : ["health_probe"]
    content {
      interval_in_seconds = lookup(health_probe.value, "interval_in_seconds")
      protocol            = lookup(health_probe.value, "protocol")
      request_type        = lookup(health_probe.value, "request_type")
      path                = lookup(health_probe.value, "path")
    }
  }
}

resource "azurerm_cdn_frontdoor_profile" "this" {
  count                    = length(var.frontdoor_profile)
  name                     = lookup(var.frontdoor_profile[count.index], "name")
  resource_group_name      = data.azurerm_resource_group.this.name
  sku_name                 = lookup(var.frontdoor_profile[count.index], "sku_name")
  response_timeout_seconds = lookup(var.frontdoor_profile[count.index], "response_timeout_seconds")
  tags = merge(
    var.tags,
    lookup(var.frontdoor_profile[count.index], "tags")
  )
}

resource "azurerm_cdn_frontdoor_route" "this" {
  count                           = length(var.frontdoor_route) == "0" ? "0" : (length(var.frontdoor_endpoint) && length(var.frontdoor_origin_group) && length(var.frontdoor_origin))
  cdn_frontdoor_endpoint_id       = try(element(azurerm_cdn_frontdoor_endpoint.this.*.id, lookup(var.frontdoor_route[count.index], "cdn_frontdoor_endpoint_id")))
  cdn_frontdoor_origin_group_id   = try(element(azurerm_cdn_frontdoor_origin_group.this.*.id, lookup(var.frontdoor_route[count.index], "cdn_frontdoor_origin_group_id")))
  cdn_frontdoor_origin_ids        = try(element(azurerm_cdn_frontdoor_origin.this.*.id, lookup(var.frontdoor_route[count.index], "cdn_frontdoor_origin_ids")))
  name                            = lookup(var.frontdoor_route[count.index], "name")
  patterns_to_match               = lookup(var.frontdoor_route[count.index], "patterns_to_match")
  supported_protocols             = lookup(var.frontdoor_route[count.index], "supported_protocols")
  forwarding_protocol             = lookup(var.frontdoor_route[count.index], "forwarding_protocol")
  cdn_frontdoor_custom_domain_ids = lookup(var.frontdoor_route[count.index], "cdn_frontdoor_custom_domain_ids")
  cdn_frontdoor_origin_path       = lookup(var.frontdoor_route[count.index], "cdn_frontdoor_origin_path")
  cdn_frontdoor_rule_set_ids      = lookup(var.frontdoor_route[count.index], "cdn_frontdoor_rule_set_ids")
  enabled                         = lookup(var.frontdoor_route[count.index], "enabled")
  https_redirect_enabled          = lookup(var.frontdoor_route[count.index], "https_redirect_enabled")
  link_to_default_domain          = lookup(var.frontdoor_route[count.index], "link_to_default_domain")

  dynamic "cache" {
    for_each = lookup(var.frontdoor_route[count.index], "cache") == null ? [] : ["cache"]
    content {
      query_string_caching_behavior = lookup(cache.value, "query_string_caching_behavior")
      query_strings                 = lookup(cache.value, "query_strings")
      compression_enabled           = lookup(cache.value, "compression_enabled")
      content_types_to_compress     = lookup(cache.value, "content_types_to_compress")
    }
  }
}

resource "azurerm_cdn_frontdoor_route_disable_link_to_default_domain" "this" {
  count                           = length(var.frontdoor_route_disable_link_to_default_domain) == "0" ? "0" : (length(var.frontdoor_custom_domain) && length(var.frontdoor_route))
  cdn_frontdoor_custom_domain_ids = try(element(azurerm_cdn_frontdoor_custom_domain.this.*.id, lookup(var.frontdoor_route_disable_link_to_default_domain[count.index], "cdn_frontdoor_custom_domain_ids")))
  cdn_frontdoor_route_id          = try(element(azurerm_cdn_frontdoor_route.this.*.id, lookup(var.frontdoor_route_disable_link_to_default_domain[count.index], "cdn_frontdoor_route_id")))
}

resource "azurerm_cdn_frontdoor_rule" "this" {
  count                     = length(var.frontdoor_rule) == "0" ? "0" : length(var.frontdoor_rule_set)
  cdn_frontdoor_rule_set_id = try(element(azurerm_cdn_frontdoor_rule_set.this.*.id, lookup(var.frontdoor_rule[count.index], "cdn_frontdoor_rule_set_id")))
  name                      = lookup(var.frontdoor_rule[count.index], "name")
  order                     = lookup(var.frontdoor_rule[count.index], "order")
  behavior_on_match         = lookup(var.frontdoor_rule[count.index], "behavior_on_match")

  dynamic "actions" {
    for_each = lookup(var.frontdoor_rule[count.index], "actions") == null ? [] : ["actions"]
    content {
      dynamic "url_redirect_action" {
        for_each = lookup(actions.value, "url_redirect_action") == null ? [] : ["url_redirect_action"]
        content {
          destination_hostname = lookup(url_redirect_action.value, "destination_hostname")
          redirect_type        = lookup(url_redirect_action.value, "redirect_type")
          redirect_protocol    = lookup(url_redirect_action.value, "redirect_protocol")
          destination_fragment = lookup(url_redirect_action.value, "destination_fragment")
          query_string         = lookup(url_redirect_action.value, "query_string")
          destination_path     = lookup(url_redirect_action.value, "destination_path")
        }
      }

      dynamic "url_rewrite_action" {
        for_each = lookup(actions.value, "url_rewrite_action") == null ? [] : ["url_rewrite_action"]
        content {
          destination             = lookup(url_rewrite_action.value, "destination")
          source_pattern          = lookup(url_rewrite_action.value, "source_pattern")
          preserve_unmatched_path = lookup(url_rewrite_action.value, "preserve_unmatched_path")
        }
      }

      dynamic "request_header_action" {
        for_each = lookup(actions.value, "request_header_action") == null ? [] : ["request_header_action"]
        content {
          header_action = lookup(request_header_action.value, "header_action")
          header_name   = lookup(request_header_action.value, "header_name")
          value         = lookup(request_header_action.value, "value")
        }
      }

      dynamic "route_configuration_override_action" {
        for_each = lookup(actions.value, "route_configuration_override_action") == null ? [] : ["route_configuration_override_action"]
        content {
          cache_behavior                = lookup(route_configuration_override_action.value, "cache_behavior")
          cache_duration                = lookup(route_configuration_override_action.value, "cache_duration")
          cdn_frontdoor_origin_group_id = lookup(route_configuration_override_action.value, "cdn_frontdoor_origin_group_id")
          forwarding_protocol           = lookup(route_configuration_override_action.value, "forwarding_protocol")
          query_string_caching_behavior = lookup(route_configuration_override_action.value, "query_string_caching_behavior")
          query_string_parameters       = lookup(route_configuration_override_action.value, "query_string_parameters")
          compression_enabled           = lookup(route_configuration_override_action.value, "compression_enabled")
        }
      }

      dynamic "response_header_action" {
        for_each = lookup(actions.value, "response_header_action") == null ? [] : ["response_header_action"]
        content {
          header_action = lookup(response_header_action.value, "header_action")
          header_name   = lookup(response_header_action.value, "header_name")
          value         = lookup(response_header_action.value, "value")
        }
      }
    }
  }

  dynamic "conditions" {
    for_each = lookup(var.frontdoor_rule[count.index], "conditions") == null ? [] : ["conditions"]
    content {
      dynamic "remote_address_condition" {
        for_each = lookup(conditions.value, "remote_address_condition") == null ? [] : ["remote_address_condition"]
        content {
          operator         = lookup(remote_address_condition.value, "operator")
          negate_condition = lookup(remote_address_condition.value, "negate_condition")
          match_values     = lookup(remote_address_condition.value, "match_values")
        }
      }
      dynamic "request_body_condition" {
        for_each = lookup(conditions.value, "request_body_condition") == null ? [] : ["request_body_condition"]
        content {
          match_values     = lookup(request_body_condition.value, "match_values")
          operator         = lookup(request_body_condition.value, "operator")
          transforms       = lookup(request_body_condition.value, "transforms")
          negate_condition = lookup(request_body_condition.value, "negate_condition")
        }
      }
      dynamic "request_header_condition" {
        for_each = lookup(conditions.value, "request_header_condition") == null ? [] : ["request_header_condition"]
        content {
          header_name      = lookup(request_header_condition.value, "header_name")
          operator         = lookup(request_header_condition.value, "operator")
          transforms       = lookup(request_header_condition.value, "transforms")
          negate_condition = lookup(request_header_condition.value, "negate_condition")
        }
      }
      dynamic "request_method_condition" {
        for_each = lookup(conditions.value, "request_method_condition") == null ? [] : ["request_method_condition"]
        content {
          match_values     = lookup(request_method_condition.value, "match_values")
          negate_condition = lookup(request_method_condition.value, "negate_condition")
          operator         = lookup(request_method_condition.value, "operator")
        }
      }
      dynamic "request_scheme_condition" {
        for_each = lookup(conditions.value, "request_scheme_condition") == null ? [] : ["request_scheme_condition"]
        content {
          match_values     = lookup(request_scheme_condition.value, "match_values")
          operator         = lookup(request_scheme_condition.value, "operator")
          negate_condition = lookup(request_scheme_condition.value, "negate_condition")
        }
      }
      dynamic "request_uri_condition" {
        for_each = lookup(conditions.value, "request_uri_condition") == null ? [] : ["request_uri_condition"]
        content {
          operator         = lookup(request_uri_condition.value, "operator")
          match_values     = lookup(request_uri_condition.value, "match_values")
          transforms       = lookup(request_uri_condition.value, "transforms")
          negate_condition = lookup(request_uri_condition.value, "negate_condition")
        }
      }
      dynamic "query_string_condition" {
        for_each = lookup(conditions.value, "query_string_condition") == null ? [] : ["query_string_condition"]
        content {
          operator         = lookup(query_string_condition.value, "operator")
          match_values     = lookup(query_string_condition.value, "match_values")
          transforms       = lookup(query_string_condition.value, "transforms")
          negate_condition = lookup(query_string_condition.value, "negate_condition")
        }
      }
      dynamic "post_args_condition" {
        for_each = lookup(conditions.value, "post_args_condition") == null ? [] : ["post_args_condition"]
        content {
          operator         = lookup(post_args_condition.value, "operator")
          post_args_name   = lookup(post_args_condition.value, "post_args_name")
          negate_condition = lookup(post_args_condition.value, "negate_condition")
          transforms       = lookup(post_args_condition.value, "transforms")
        }
      }
      dynamic "client_port_condition" {
        for_each = lookup(conditions.value, "client_port_condition") == null ? [] : ["client_port_condition"]
        content {
          operator         = lookup(client_port_condition.value, "operator")
          match_values     = lookup(client_port_condition.value, "match_values")
          negate_condition = lookup(client_port_condition.value, "negate_condition")
        }
      }
      dynamic "http_version_condition" {
        for_each = lookup(conditions.value, "http_version_condition") == null ? [] : ["http_version_condition"]
        content {
          operator         = lookup(http_version_condition.value, "operator")
          match_values     = lookup(http_version_condition.value, "match_values")
          negate_condition = lookup(http_version_condition.value, "negate_condition")
        }
      }
      dynamic "host_name_condition" {
        for_each = lookup(conditions.value, "host_name_condition") == null ? [] : ["host_name_condition"]
        content {
          operator         = lookup(host_name_condition.value, "operator")
          match_values     = lookup(host_name_condition.value, "match_values")
          negate_condition = lookup(host_name_condition.value, "negate_condition")
          transforms       = lookup(host_name_condition.value, "transforms")
        }
      }
      dynamic "server_port_condition" {
        for_each = lookup(conditions.value, "server_port_condition") == null ? [] : ["server_port_condition"]
        content {
          match_values     = lookup(server_port_condition.value, "match_values")
          operator         = lookup(server_port_condition.value, "operator")
          negate_condition = lookup(server_port_condition.value, "negate_condition")
        }
      }
      dynamic "ssl_protocol_condition" {
        for_each = lookup(conditions.value, "ssl_protocol_condition") == null ? [] : ["ssl_protocol_condition"]
        content {
          match_values     = lookup(ssl_protocol_condition.value, "match_values")
          operator         = lookup(ssl_protocol_condition.value, "operator")
          negate_condition = lookup(ssl_protocol_condition.value, "negate_condition")
        }
      }
      dynamic "socket_address_condition" {
        for_each = lookup(conditions.value, "socket_address_condition") == null ? [] : ["socket_address_condition"]
        content {
          match_values     = lookup(socket_address_condition.value, "match_values")
          operator         = lookup(socket_address_condition.value, "operator")
          negate_condition = lookup(socket_address_condition.value, "negate_condition")
        }
      }
      dynamic "url_path_condition" {
        for_each = lookup(conditions.value, "url_path_condition") == null ? [] : ["url_path_condition"]
        content {
          operator         = lookup(url_path_condition.value, "operator")
          match_values     = lookup(url_path_condition.value, "match_values")
          transforms       = lookup(url_path_condition.value, "negate_condition")
          negate_condition = lookup(url_path_condition.value, "transforms")
        }
      }
      dynamic "url_file_extension_condition" {
        for_each = lookup(conditions.value, "url_file_extension_condition") == null ? [] : ["url_file_extension_condition"]
        content {
          operator         = lookup(url_file_extension_condition.value, "operator")
          match_values     = lookup(url_file_extension_condition.value, "match_values")
          transforms       = lookup(url_file_extension_condition.value, "negate_condition")
          negate_condition = lookup(url_file_extension_condition.value, "transforms")
        }
      }
      dynamic "url_filename_condition" {
        for_each = lookup(conditions.value, "url_filename_condition") == null ? [] : ["url_filename_condition"]
        content {
          operator         = lookup(url_filename_condition.value, "operator")
          match_values     = lookup(url_filename_condition.value, "match_values")
          transforms       = lookup(url_filename_condition.value, "negate_condition")
          negate_condition = lookup(url_filename_condition.value, "transforms")
        }
      }
    }
  }
}

resource "azurerm_cdn_frontdoor_rule_set" "this" {
  count                    = length(var.frontdoor_rule_set) == "0" ? "0" : length(var.frontdoor_profile)
  cdn_frontdoor_profile_id = try(element(azurerm_cdn_frontdoor_profile.this.*.id, lookup(var.frontdoor_rule_set[count.index], "cdn_frontdoor_profile_id")))
  name                     = lookup(var.frontdoor_rule_set[count.index], "name")
}

resource "azurerm_cdn_frontdoor_secret" "this" {
  count                    = length(var.frontdoor_secret) == "0" ? "0" : length(var.frontdoor_profile)
  cdn_frontdoor_profile_id = try(element(azurerm_cdn_frontdoor_profile.this.*.id, lookup(var.frontdoor_secret[count.index], "cdn_frontdoor_profile_id")))
  name                     = lookup(var.frontdoor_secret[count.index], "name")

  dynamic "secret" {
    for_each = lookup(var.frontdoor_secret[count.index], "secret")
    content {
      dynamic "customer_certificate" {
        for_each = lookup(secret.value, "customer_certificate")
        content {
          key_vault_certificate_id = lookup(customer_certificate.value, "key_vault_certificate_id")
        }
      }
    }
  }
}

resource "azurerm_cdn_frontdoor_security_policy" "this" {
  count                    = length(var.frontdoor_security_policy) == "0" ? "0" : (length(var.frontdoor_profile) && length(var.frontdoor_firewall_policy) && length(var.frontdoor_custom_domain))
  cdn_frontdoor_profile_id = try(element(azurerm_cdn_frontdoor_profile.this.*.id, lookup(var.frontdoor_security_policy[count.index], "cdn_frontdoor_profile_id")))
  name                     = lookup(var.frontdoor_security_policy[count.index], "name")

  dynamic "security_policies" {
    for_each = lookup(var.frontdoor_security_policy[count.index], "security_policies")
    content {
      dynamic "firewall" {
        for_each = lookup(security_policies.value, "firewall")
        content {
          cdn_frontdoor_firewall_policy_id = try(element(azurerm_cdn_frontdoor_firewall_policy.this.*.id, lookup(firewall.value, "cdn_frontdoor_firewall_policy_id")))

          dynamic "association" {
            for_each = lookup(firewall.value, "association")
            content {
              patterns_to_match = lookup(association.value, "patterns_to_match")

              dynamic "domain" {
                for_each = lookup(association.value, "domain")
                content {
                  cdn_frontdoor_domain_id = try(element(azurerm_cdn_frontdoor_custom_domain.this.*.id, lookup(domain.value, "cdn_frontdoor_domain_id")))
                }
              }
            }
          }
        }
      }
    }
  }
}

resource "azurerm_cdn_profile" "this" {
  count               = length(var.profile)
  location            = data.azurerm_resource_group.this.location
  name                = lookup(var.profile[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.name
  sku                 = lookup(var.profile[count.index], "sku")
  tags                = merge(
    var.tags,
    lookup(var.profile[count.index], "tags")
  )
}