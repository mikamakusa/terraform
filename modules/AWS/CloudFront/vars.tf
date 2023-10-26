variable "kinesis_stream" {
  type        = string
  default     = null
  description = <<-EOT
    Kinesis stream name to be used as datasource for policy document and realtime_log_config resource for cloudfront.
EOT
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "web_acl" {
  type    = string
  default = null
}

variable "lambda_function" {
  type    = string
  default = null
}

variable "acm_certificate" {
  type    = string
  default = null
}

variable "cache_policy" {
  type = list(map(object({
    id          = number
    name        = string
    min_ttl     = number
    max_ttl     = optional(number)
    default_ttl = optional(number)
    comment     = optional(string)
    parameters_in_cache_key_and_forwarded_to_origin = optional(list(object({
      cookies_config = optional(list(object({
        cookie_behavior = optional(string)
        items           = optional(list(string))
      })), [])
      headers_config = optional(list(object({
        header_behavior = optional(string)
        items           = optional(list(string))
      })), [])
      query_strings_config = optional(list(object({
        query_string_behavior = optional(string)
        items                 = optional(list(string))
      })), [])
      enable_accept_encoding_brotli = optional(bool, false)
      enable_accept_encoding_gzip   = optional(bool, false)
    })), [])
  })))
  default = []
}

variable "distribution" {
  type = list(map(object({
    id                  = number
    enabled             = bool
    aliases             = optional(list(string))
    comment             = optional(string)
    default_root_object = optional(string)
    is_ipv6_enabled     = optional(bool, false)
    http_version        = optional(string)
    price_class         = optional(string)
    web_acl_id          = optional(string)
    retain_on_delete    = optional(bool, false)
    wait_for_deployment = optional(bool, false)
    tags                = optional(map(string))
    custom_error_response = optional(list(object({
      error_code = number
    })), [])
    default_cache_behavior = optional(list(object({
      allowed_methods            = list(string)
      cached_methods             = list(string)
      target_origin_id           = string
      viewer_protocol_policy     = string
      cache_policy_id            = optional(string)
      compress                   = optional(bool, false)
      default_ttl                = optional(number)
      field_level_encryption_id  = optional(string)
      max_ttl                    = optional(number)
      origin_request_policy_id   = optional(string)
      realtime_log_config_arn    = optional(string)
      response_headers_policy_id = optional(string)
      smooth_streaming           = optional(bool, false)
      trusted_key_groups         = optional(list(string))
      trusted_signers            = optional(list(string))
      forwarded_values = optional(list(object({
        query_string            = bool
        headers                 = optional(list(string))
        query_string_cache_keys = optional(list(string))
        cookies = optional(list(object({
          forward           = string
          whitelisted_names = optional(list(string))
        })), [])
      })), [])
      lambda_function_association = optional(list(object({
        event_type   = string
        include_body = optional(bool, false)
      })), [])
      function_association = optional(list(object({
        event_type  = string
        function_id = number
      })), [])
    })), [])
    logging_config = optional(list(object({
      bucket          = string
      include_cookies = optional(bool, false)
      prefix          = optional(string)
    })), [])
    ordered_cache_behavior = optional(list(object({
      allowed_methods            = list(string)
      cached_methods             = list(string)
      path_pattern               = string
      target_origin_id           = string
      viewer_protocol_policy     = string
      cache_policy_id            = optional(string)
      compress                   = optional(bool, false)
      default_ttl                = optional(number)
      field_level_encryption_id  = optional(string)
      max_ttl                    = optional(number)
      origin_request_policy_id   = optional(string)
      realtime_log_config_arn    = optional(string)
      response_headers_policy_id = optional(string)
      smooth_streaming           = optional(bool, false)
      trusted_key_groups         = optional(list(string))
      trusted_signers            = optional(list(string))
      forwarded_values = optional(list(object({
        query_string            = bool
        headers                 = optional(list(string))
        query_string_cache_keys = optional(list(string))
        cookies = optional(list(object({
          forward           = string
          whitelisted_names = optional(list(string))
        })), [])
      })), [])
      lambda_function_association = optional(list(object({
        event_type   = string
        lambda_arn   = string
        include_body = optional(bool, false)
      })), [])
      function_association = optional(list(object({
        event_type   = string
        function_arn = string
      })), [])
    })), [])
    origin = optional(list(object({
      domain_name              = string
      origin_id                = string
      connection_attempts      = optional(number)
      connection_timeout       = optional(number)
      origin_access_control_id = optional(string)
      origin_path              = optional(string)
      custom_origin_config = optional(list(object({
        http_port                = number
        https_port               = number
        origin_protocol_policy   = string
        origin_ssl_protocols     = list(string)
        origin_keepalive_timeout = optional(number)
        origin_read_timeout      = optional(number)
      })), [])
      custom_header = optional(list(object({
        name  = string
        value = string
      })), [])
      origin_shield = optional(list(object({
        enabled              = bool
        origin_shield_region = string
      })), [])
      s3_origin_config = optional(list(object({
        origin_access_identity = string
      })), [])
    })), [])
    origin_group = optional(list(object({
      origin_id = string
      failover_criteria = optional(list(object({
        status_codes = list(string)
      })), [])
      member = optional(list(object({
        origin_id = string
      })), [])
    })), [])
    restrictions = optional(list(object({
      geo_restrictions = optional(list(object({
        restriction_type = string
        locations        = optional(list(string))
      })), [])
    })), [])
    viewer_certificate = optional(list(object({
      acm_certificate_arn            = optional(string)
      cloudfront_default_certificate = optional(bool, false)
      iam_certificate_id             = optional(string)
      minimum_protocol_version       = optional(string)
      ssl_support_method             = optional(string)
    })), [])
  })))
  default = []
}

variable "cloudfront_fonction" {
  type = list(map(object({
    id      = number
    code    = string
    name    = string
    runtime = string
    comment = optional(string)
    publish = optional(bool, false)
  })))
  default = []
}

variable "monitoring_subscription" {
  type = list(map(object({
    id              = number
    distribution_id = number
  })))
  default = []
}

variable "response_headers_policy" {
  type = list(map(object({
    id      = number
    name    = string
    comment = optional(string)
    cors_config = optional(list(object({
      access_control_allow_credentials = optional(bool, false)
      origin_override                  = optional(bool, false)
      access_control_max_age_sec       = optional(number)
      access_control_allow_headers = optional(list(object({
        items = optional(list(string))
      })), [])
      access_control_allow_methods = optional(list(object({
        items = optional(list(string))
      })), [])
      access_control_allow_origins = optional(list(object({
        items = optional(list(string))
      })), [])
      access_control_expose_headers = optional(list(object({
        items = optional(list(string))
      })), [])
    })), [])
    custom_headers_config = optional(list(object({
      header   = optional(string)
      override = optional(string)
      value    = optional(string)
    })), [])
    remove_headers_config = optional(list(object({
      header = optional(string)
    })), [])
    security_headers_config = optional(list(object({
      content_security_policy = optional(list(object({
        content_security_policy = string
        override                = bool
      })), [])
      content_type_options = optional(list(object({
        override = bool
      })), [])
      frame_options = optional(list(object({
        frame_option = string
        override     = bool
      })), [])
      referrer_policy = optional(list(object({
        override        = bool
        referrer_policy = string
      })), [])
      strict_transport_security = optional(list(object({
        access_control_max_age_sec = number
        override                   = bool
        include_subdomains         = optional(bool, false)
        preload                    = optional(bool, false)
      })), [])
      xss_protection = optional(list(object({
        override   = bool
        protection = bool
        mode_block = optional(bool, false)
        report_uri = optional(string)
      })), [])
    })), [])
    server_timing_headers_config = optional(list(object({
      enabled       = bool
      sampling_rate = number
    })), [])
  })))
}