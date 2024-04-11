variable "resource_group" {
  type = string
}

variable "tags" {
  type = string
}

variable "endpoint" {
  type = list(map(object({
    id                            = number
    name                          = string
    profile_id                    = number
    is_http_allowed               = optional(bool)
    is_https_allowed              = optional(bool)
    is_compression_enabled        = optional(bool)
    content_types_to_compress     = optional(list(string))
    querystring_caching_behaviour = optional(string)
    optimization_type             = optional(string)
    origin_host_header            = optional(string)
    origin_path                   = optional(string)
    probe_path                    = optional(string)
    tags                          = optional(map(string))
    geo_filter = optional(list(object({
      action        = string
      country_codes = list(string)
      relative_path = string
    })), [])
    origin = list(object({
      host_name  = string
      name       = string
      http_port  = number
      https_port = optional(number)
    }))
    global_delivery_rule = optional(list(object({
      cache_expiration_action = optional(list(object({
        behavior = string
      })), [])
      cache_key_query_string_action = optional(list(object({
        behavior = string
      })), [])
      modify_request_header_action = optional(list(object({
        action = string
        name   = string
        value  = optional(string)
      })), [])
      modify_response_header_action = optional(list(object({
        action = string
        name   = string
        value  = optional(string)
      })), [])
      url_redirect_action = optional(list(object({
        redirect_type = string
        protocol      = string
        hostname      = optional(string)
        path          = optional(string)
        fragment      = optional(string)
        query_string  = optional(string)
      })), [])
      url_rewrite_action = optional(list(object({
        destination             = string
        source_pattern          = string
        preserve_unmatched_path = optional(bool)
      })), [])
    })))
    delivery_rule = optional(list(object({
      name  = string
      order = number
      cache_expiration_action = optional(list(object({
        behavior = string
      })), [])
      cache_key_query_string_action = optional(list(object({
        behavior = string
      })), [])
      cookies_condition = optional(list(object({
        operator = string
        selector = string
      })), [])
      device_condition = optional(list(object({
        match_values = list(string)
      })), [])
      http_version_condition = optional(list(object({
        match_values = list(string)
      })), [])
      modify_request_header_action = optional(list(object({
        action = string
        name   = string
        value  = optional(string)
      })), [])
      modify_response_header_action = optional(list(object({
        action = string
        name   = string
        value  = optional(string)
      })), [])
      post_arg_condition = optional(list(object({
        operator = string
        selector = string
      })), [])
      query_string_condition = optional(list(object({
        operator = string
      })), [])
      remote_address_condition = optional(list(object({
        operator = string
      })), [])
      request_body_condition = optional(list(object({
        operator = string
      })), [])
      request_header_condition = optional(list(object({
        operator = string
        selector = string
      })), [])
      request_method_condition = optional(list(object({
        match_values = list(string)
      })), [])
      request_scheme_condition = optional(list(object({
        match_values = list(string)
      })), [])
      request_uri_condition = optional(list(object({
        operator = string
      })), [])
      url_file_extension_condition = optional(list(object({
        operator = string
      })), [])
      url_file_name_condition = optional(list(object({
        operator = string
      })), [])
      url_path_condition = optional(list(object({
        operator = string
      })), [])
      url_redirect_action = optional(list(object({
        redirect_type = string
        protocol      = string
        hostname      = optional(string)
        path          = optional(string)
        fragment      = optional(string)
        query_string  = optional(string)
      })), [])
      url_rewrite_action = optional(list(object({
        destination             = string
        source_pattern          = string
        preserve_unmatched_path = optional(bool)
      })), [])
    })))
  })))
  default     = []
  description = <<EOF
A CDN Endpoint is the entity within a CDN Profile containing configuration information regarding caching behaviours and origins. The CDN Endpoint is exposed using the URL format <endpointname>.azureedge.net
EOF
}

variable "endpoint_custom_domain" {
  type = list(map(object({
    id              = number
    cdn_endpoint_id = number
    host_name       = string
    name            = string
    cdn_managed_https = optional(list(object({
      certificate_type = string
      protocol_type    = string
      tls_version      = optional(string)
    })), [])
    user_managed_https = optional(list(object({
      key_vault_certificate_id = optional(string)
      key_vault_secret_id      = optional(string)
      tls_version              = optional(string)
    })), [])
  })))
  default     = []
  description = <<EOF
Manages a Custom Domain for a CDN Endpoint.
EOF
}

variable "frontdoor_custom_domain" {
  type = list(map(object({
    id                       = number
    cdn_frontdoor_profile_id = number
    host_name                = string
    name                     = string
    dns_zone_id              = optional(string)
    tls = optional(list(object({
      certificate_type        = optional(string)
      minimum_tls_version     = optional(string)
      cdn_frontdoor_secret_id = optional(string)
    })), [])
  })))
  default     = []
  description = <<EOF
Manages a Front Door (standard/premium) Custom Domain.
EOF
}

variable "frontdoor_custom_domain_association" {
  type = list(map(object({
    id                             = number
    cdn_frontdoor_custom_domain_id = number
    cdn_frontdoor_route_ids        = list(number)
  })))
  default     = []
  description = <<EOF
Manages the association between a Front Door (standard/premium) Custom Domain and one or more Front Door (standard/premium) Routes.
EOF
}

variable "frontdoor_endpoint" {
  type = list(map(object({
    id                       = number
    cdn_frontdoor_profile_id = number
    name                     = string
    enabled                  = optional(bool)
    tags                     = optional(map(string))
  })))
  default     = []
  description = <<EOF
Manages a Front Door (standard/premium) Endpoint.
EOF
}

variable "frontdoor_firewall_policy" {
  type = list(map(object({
    id                                = number
    mode                              = string
    name                              = string
    sku_name                          = string
    enabled                           = optional(bool)
    redirect_url                      = optional(string)
    custom_block_response_body        = optional(string)
    custom_block_response_status_code = optional(number)
    tags                              = optional(map(string))
    custom_rule = optional(list(object({
      action                         = string
      name                           = string
      type                           = string
      enabled                        = optional(bool)
      priority                       = optional(number)
      rate_limit_duration_in_minutes = optional(number)
      rate_limit_threshold           = optional(number)
      match_condition = optional(list(object({
        match_values       = list(string)
        match_variable     = string
        operator           = string
        selector           = optional(string)
        negation_condition = optional(bool)
        transforms         = optional(list(string))
      })), [])
    })), [])
    managed_rule = optional(list(object({
      action  = string
      type    = string
      version = string
      exclusion = optional(list(object({
        match_variable = string
        operator       = string
        selector       = string
      })), [])
      override = optional(list(object({
        rule_group_name = string
        exclusion = optional(list(object({
          match_variable = string
          operator       = string
          selector       = string
        })), [])
        rule = optional(list(object({
          action  = string
          rule_id = string
          enabled = bool
          exclusion = optional(list(object({
            match_variable = string
            operator       = string
            selector       = string
          })), [])
        })), [])
      })), [])
    })), [])
  })))
  default     = []
  description = <<EOF
Manages a Front Door (standard/premium) Firewall Policy instance.
EOF
}

variable "frontdoor_origin" {
  type = list(map(object({
    id                             = number
    cdn_frontdoor_origin_group_id  = number
    certificate_name_check_enabled = bool
    host_name                      = string
    name                           = string
    enabled                        = optional(bool)
    http_port                      = optional(number)
    https_port                     = optional(number)
    origin_host_header             = optional(string)
    priority                       = optional(number)
    weight                         = optional(number)
    private_link = optional(list(object({
      location               = string
      private_link_target_id = string
      request_message        = optional(string)
      target_type            = optional(string)
    })), [])
  })))
  default     = []
  description = <<EOF
Manages a Front Door (standard/premium) Origin.
EOF
}

variable "frontdoor_origin_group" {
  type = list(map(object({
    id                                                        = number
    cdn_frontdoor_profile_id                                  = number
    name                                                      = string
    restore_traffic_time_to_healed_or_new_endpoint_in_minutes = optional(number)
    session_affinity_enabled                                  = optional(bool)
    load_balancing = list(object({
      additional_latency_in_milliseconds = optional(number)
      sample_size                        = optional(number)
      successful_samples_required        = optional(number)
    }))
    health_probe = optional(list(object({
      interval_in_seconds = number
      protocol            = string
      request_type        = optional(string)
      path                = optional(string)
    })), [])
  })))
  default     = []
  description = <<EOF
Manages a Front Door (standard/premium) Origin Group.
EOF
}

variable "frontdoor_profile" {
  type = list(map(object({
    id                       = number
    name                     = string
    sku_name                 = string
    response_timeout_seconds = optional(number)
    tags                     = optional(map(string))
  })))
  default     = []
  description = <<EOF
Manages a Front Door (standard/premium) Profile which contains a collection of endpoints and origin groups.
EOF
}

variable "frontdoor_route" {
  type = list(map(object({
    id                              = number
    cdn_frontdoor_endpoint_id       = number
    cdn_frontdoor_origin_group_id   = number
    cdn_frontdoor_origin_ids        = list(number)
    name                            = string
    patterns_to_match               = list(string)
    supported_protocols             = list(string)
    forwarding_protocol             = optional(string)
    cdn_frontdoor_custom_domain_ids = optional(list(string))
    cdn_frontdoor_origin_path       = optional(string)
    cdn_frontdoor_rule_set_ids      = optional(list(string))
    enabled                         = optional(bool)
    https_redirect_enabled          = optional(bool)
    link_to_default_domain          = optional(bool)
    cache = optional(list(object({
      query_string_caching_behavior = optional(string)
      query_strings                 = optional(list(string))
      compression_enabled           = optional(bool)
      content_types_to_compress     = optional(list(string))
    })), [])
  })))
  default     = []
  description = <<EOF
EOF
}

variable "frontdoor_route_disable_link_to_default_domain" {
  type = list(map(object({
    id                              = number
    cdn_frontdoor_custom_domain_ids = list(number)
    cdn_frontdoor_route_id          = number
  })))
  default     = []
  description = <<EOF
Manages the Link To Default Domain property of a Front Door (standard/premium) Route.
EOF
}

variable "frontdoor_rule" {
  type = list(map(object({
    id                        = number
    cdn_frontdoor_rule_set_id = number
    name                      = string
    order                     = number
    behavior_on_match         = optional(string)
    action = list(object({
      url_redirect_action = optional(list(object({
        destination_hostname = string
        redirect_type        = string
        redirect_protocol    = optional(string)
        destination_fragment = optional(string)
        query_string         = optional(string)
        destination_path     = optional(string)
      })), [])
      url_rewrite_action = optional(list(object({
        destination             = string
        source_pattern          = string
        preserve_unmatched_path = optional(bool)
      })), [])
      request_header_action = optional(list(object({
        header_action = string
        header_name   = string
        value         = optional(string)
      })), [])
      route_configuration_override_action = optional(list(object({
        cache_behavior                = string
        cache_duration                = string
        cdn_frontdoor_origin_group_id = optional(string)
        forwarding_protocol           = optional(string)
        query_string_caching_behavior = optional(string)
        query_string_parameters       = optional(list(string))
        compression_enabled           = optional(bool)
      })), [])
      response_header_action = optional(list(object({
        header_action = string
        header_name   = string
        value         = optional(string)
      })), [])
    }))
    conditions = optional(list(object({
      remote_address_condition = optional(list(object({
        operator         = string
        negate_condition = bool
        match_values     = list(string)
      })), [])
      request_body_condition = optional(list(object({
        match_values     = list(string)
        operator         = string
        transforms       = list(string)
        negate_condition = bool
      })), [])
      request_header_condition = optional(list(object({
        header_name      = string
        operator         = string
        transforms       = list(string)
        negate_condition = bool
      })), [])
      request_method_condition = optional(list(object({
        match_values     = list(string)
        negate_condition = bool
        operator         = string
      })), list(string))
      request_scheme_condition = optional(list(object({
        match_values     = list(string)
        negate_condition = bool
        operator         = string
      })), list(string))
      request_uri_condition = optional(list(object({
        operator         = string
        match_values     = list(string)
        transforms       = list(string)
        negate_condition = bool
      })), list(string))
      query_string_condition = optional(list(object({
        operator         = string
        match_values     = list(string)
        transforms       = list(string)
        negate_condition = bool
      })), list(string))
      post_args_condition = optional(list(object({
        operator         = string
        post_args_name   = string
        negate_condition = bool
        transforms       = list(string)
      })), list(string))
      client_port_condition = optional(list(object({
        operator         = string
        match_values     = list(string)
        negate_condition = bool
      })), list(string))
      http_version_condition = optional(list(object({
        operator         = string
        match_values     = list(string)
        negate_condition = bool
      })), list(string))
      host_name_condition = optional(list(object({
        operator         = string
        match_values     = list(string)
        negate_condition = bool
        transforms       = list(string)
      })), list(string))
      server_port_condition = optional(list(object({
        match_values     = list(string)
        operator         = string
        negate_condition = bool
      })), list(string))
      ssl_protocol_condition = optional(list(object({
        match_values     = list(string)
        operator         = string
        negate_condition = bool
      })), list(string))
      socket_address_condition = optional(list(object({
        match_values     = list(string)
        operator         = string
        negate_condition = bool
      })), list(string))
      url_path_condition = optional(list(object({
        operator         = string
        match_values     = list(string)
        transforms       = list(string)
        negate_condition = bool
      })), list(string))
      url_file_extension_condition = optional(list(object({
        operator         = string
        match_values     = list(string)
        transforms       = list(string)
        negate_condition = bool
      })), list(string))
      url_filename_condition = optional(list(object({
        operator         = string
        match_values     = list(string)
        transforms       = list(string)
        negate_condition = bool
      })), [])
    })), [])
  })))
  default     = []
  description = <<EOF
Manages a Front Door (standard/premium) Rule.
EOF
}

variable "frontdoor_rule_set" {
  type = list(map(object({
    id                       = number
    cdn_frontdoor_profile_id = number
    name                     = string
  })))
  default     = []
  description = <<EOF
Manages a Front Door (standard/premium) Rule Set.
EOF
}

variable "frontdoor_secret" {
  type = list(map(object({
    id                       = number
    cdn_frontdoor_profile_id = number
    name                     = string
    secret = list(object({
      customer_certificate = list(object({
        key_vault_certificate_id = string
      }))
    }))
  })))
  default     = []
  description = <<EOF
EOF
}

variable "frontdoor_security_policy" {
  type = list(map(object({
    id                       = number
    cdn_frontdoor_profile_id = number
    name                     = string
    security_policies = list(object({
      cdn_frontdoor_firewall_policy_id = number
      association = list(object({
        patterns_to_match = list(string)
        domain = list(object({
          cdn_frontdoor_domain_id = number
        }))
      }))
    }))
  })))
  default     = []
  description = <<EOF
Manages a Front Door (standard/premium) Security Policy.
EOF
}

variable "profile" {
  type = list(map(object({
    id   = number
    name = string
    sku  = string
    tags = optional(map(string))
  })))
  default     = []
  description = <<EOF
Manages a CDN Profile to create a collection of CDN Endpoints.
EOF
}
