resource "aws_cloudfront_cache_policy" "this" {
  count       = length(var.cache_policy)
  name        = lookup(var.cache_policy[count.index], "name")
  min_ttl     = lookup(var.cache_policy[count.index], "min_ttl")
  max_ttl     = lookup(var.cache_policy[count.index], "max_ttl")
  default_ttl = lookup(var.cache_policy[count.index], "default_ttl")
  comment     = lookup(var.cache_policy[count.index], "comment")

  dynamic "parameters_in_cache_key_and_forwarded_to_origin" {
    for_each = lookup(var.cache_policy[count.index], "parameters_in_cache_key_and_forwarded_to_origin") == null ? [] : ["parameters_in_cache_key_and_forwarded_to_origin"]
    content {
      dynamic "cookies_config" {
        for_each = lookup(parameters_in_cache_key_and_forwarded_to_origin.value, "cookies_config") == null ? [] : ["cookies_config"]
        content {
          cookie_behavior = lookup(cookies_config.value, "cookie_behavior")
          cookies {
            items = lookup(cookies_config.value, "items")
          }
        }
      }
      dynamic "headers_config" {
        for_each = lookup(parameters_in_cache_key_and_forwarded_to_origin.value, "headers_config") == null ? [] : ["headers_config"]
        content {
          header_behavior = lookup(headers_config.value, "header_behavior")
          headers {
            items = lookup(headers_config.value, "items")
          }
        }
      }
      dynamic "query_strings_config" {
        for_each = lookup(parameters_in_cache_key_and_forwarded_to_origin.value, "query_strings_config") == null ? [] : ["query_strings_config"]
        content {
          query_string_behavior = lookup(query_strings_config.value, "query_string_behavior")
          query_strings {
            items = lookup(query_strings_config.value, "items")
          }
        }
      }
      enable_accept_encoding_brotli = lookup(parameters_in_cache_key_and_forwarded_to_origin.value, "enable_accept_encoding_brotli")
      enable_accept_encoding_gzip   = lookup(parameters_in_cache_key_and_forwarded_to_origin.value, "enable_accept_encoding_gzip")
    }
  }
}

resource "aws_s3_bucket" "this" {
  bucket = "s3_cloudfront"
}

resource "aws_s3_bucket" "logging" {
  bucket = "s3_cloudfront_logging"
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "this" {
  depends_on = [aws_s3_bucket_ownership_controls.this]
  bucket     = aws_s3_bucket.this.id
  acl        = "private"
}

resource "aws_s3_bucket_ownership_controls" "logging" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "logging" {
  depends_on = [aws_s3_bucket_ownership_controls.logging]
  bucket     = aws_s3_bucket.logging.id
  acl        = "private"
}

resource "aws_cloudfront_distribution" "this" {
  count               = length(var.distribution)
  enabled             = lookup(var.distribution[count.index], "enabled")
  aliases             = lookup(var.distribution[count.index], "aliases")
  comment             = lookup(var.distribution[count.index], "comment")
  default_root_object = lookup(var.distribution[count.index], "default_root_project")
  is_ipv6_enabled     = lookup(var.distribution[count.index], "is_ipv6_enabled")
  http_version        = lookup(var.distribution[count.index], "http_version")
  price_class         = lookup(var.distribution[count.index], "price_classe")
  web_acl_id          = var.web_acl ? data.aws_wafv2_web_acl.this.id : lookup(var.distribution[count.index], "web_acl_id")
  retain_on_delete    = lookup(var.distribution[count.index], "retain_on_delete")
  wait_for_deployment = lookup(var.distribution[count.index], "wait_for_deployment")
  tags = merge(
    var.tags,
    lookup(var.distribution[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )

  dynamic "custom_error_response" {
    for_each = lookup(var.distribution[count.index], "custom_error_response") == null ? [] : ["custom_error_response"]
    content {
      error_code = lookup(custom_error_response.value, "error_code")
    }
  }

  dynamic "default_cache_behavior" {
    for_each = lookup(var.distribution[count.index], "default_cache_behavior") == null ? [] : ["default_cache_behavior"]
    content {
      allowed_methods            = lookup(default_cache_behavior.value, "allowed_methods")
      cached_methods             = lookup(default_cache_behavior.value, "cached_methods")
      target_origin_id           = lookup(default_cache_behavior.value, "target_origin_id")
      viewer_protocol_policy     = lookup(default_cache_behavior.value, "viewer_protocol_policy")
      cache_policy_id            = lookup(default_cache_behavior.value, "cache_policy_id")
      compress                   = lookup(default_cache_behavior.value, "compress")
      default_ttl                = lookup(default_cache_behavior.value, "default_ttl")
      field_level_encryption_id  = lookup(default_cache_behavior.value, "field_level_encryption_id")
      max_ttl                    = lookup(default_cache_behavior.value, "max_ttl")
      origin_request_policy_id   = lookup(default_cache_behavior.value, "origin_request_policy_id")
      realtime_log_config_arn    = element(aws_cloudfront_realtime_log_config.this.*.arn, lookup(default_cache_behavior.value, "realtime_log_config_id"))
      response_headers_policy_id = lookup(default_cache_behavior.value, "response_headers_policy_id")
      smooth_streaming           = lookup(default_cache_behavior.value, "smooth_streaming")
      trusted_key_groups         = lookup(default_cache_behavior.value, "trusted_key_groups")
      trusted_signers            = lookup(default_cache_behavior.value, "trusted_signers")

      dynamic "forwarded_values" {
        for_each = lookup(default_cache_behavior.value, "forwarded_values") == null ? [] : ["forwarded_values"]
        content {
          query_string            = lookup(forwarded_values.value, "query_string")
          headers                 = lookup(forwarded_values.value, "headers")
          query_string_cache_keys = lookup(forwarded_values.value, "query_string_cache_keys")

          dynamic "cookies" {
            for_each = lookup(forwarded_values.value, "cookies") == null ? [] : ["cookies"]
            content {
              forward           = lookup(cookies.value, "forward")
              whitelisted_names = lookup(cookies.value, "whitelisted_names")
            }
          }
        }
      }

      dynamic "lambda_function_association" {
        for_each = var.lambda_function && lookup(default_cache_behavior.value, "lambda_function_association") == null ? [] : ["lambda_function_association"]
        content {
          event_type   = lookup(lambda_function_association.value, "event_type")
          lambda_arn   = data.aws_lambda_function.this.arn
          include_body = lookup(lambda_function_association.value, "include_body")
        }
      }

      dynamic "function_association" {
        for_each = lookup(default_cache_behavior.value, "function_association") == null ? [] : ["function_association"]
        content {
          event_type   = lookup(function_association.value, "event_type")
          function_arn = element(aws_cloudfront_function.this.*.id, lookup(function_association.value, "function_id"))
        }
      }
    }
  }

  dynamic "logging_config" {
    for_each = lookup(var.distribution[count.index], "logging_config") == null ? [] : ["logging_config"]
    content {
      bucket          = aws_s3_bucket.this.bucket
      include_cookies = lookup(logging_config.value, "include_cookies")
      prefix          = lookup(logging_config.value, "prefix")
    }
  }

  dynamic "ordered_cache_behavior" {
    for_each = lookup(var.distribution[count.index], "ordered_cache_behavior") == null ? [] : ["ordered_cache_behavior"]
    content {
      allowed_methods            = lookup(ordered_cache_behavior.value, "allowed_methods")
      cached_methods             = lookup(ordered_cache_behavior.value, "cached_methods")
      path_pattern               = lookup(ordered_cache_behavior.value, "path_pattern")
      target_origin_id           = lookup(ordered_cache_behavior.value, "target_origin_id")
      viewer_protocol_policy     = lookup(ordered_cache_behavior.value, "viewer_protocol_policy")
      cache_policy_id            = lookup(ordered_cache_behavior.value, "cache_policy_id")
      default_ttl                = lookup(ordered_cache_behavior.value, "default_ttl")
      max_ttl                    = lookup(ordered_cache_behavior.value, "max_ttl")
      realtime_log_config_arn    = element(aws_cloudfront_realtime_log_config.this.*.arn, lookup(ordered_cache_behavior.value, "realtime_log_config_id"))
      smooth_streaming           = lookup(ordered_cache_behavior.value, "smooth_streaming")
      compress                   = lookup(ordered_cache_behavior.value, "compress")
      field_level_encryption_id  = lookup(ordered_cache_behavior.value, "field_level_encryption_id")
      origin_request_policy_id   = lookup(ordered_cache_behavior.value, "origin_requestion_policy_id")
      response_headers_policy_id = lookup(ordered_cache_behavior.value, "response_headers_policy_id")
      trusted_key_groups         = lookup(ordered_cache_behavior.value, "trusted_key_groups")
      trusted_signers            = lookup(ordered_cache_behavior.value, "trusted_signers")

      dynamic "forwarded_values" {
        for_each = lookup(ordered_cache_behavior.value, "forwarded_value") == null ? [] : ["forwarded_value"]
        content {
          query_string            = lookup(forwarded_values.value, "query_string")
          headers                 = lookup(forwarded_values.value, "headers")
          query_string_cache_keys = lookup(forwarded_values.value, "query_string_cache_keys")

          dynamic "cookies" {
            for_each = lookup(forwarded_values.value, "cookies") == null ? [] : ["cookies"]
            content {
              forward           = lookup(cookies.value, "forward")
              whitelisted_names = lookup(cookies.value, "whitelisted_names")
            }
          }
        }
      }

      dynamic "lambda_function_association" {
        for_each = lookup(ordered_cache_behavior.value, "lambda_function_association") == null ? [] : ["lambda_function_association"]
        content {
          event_type   = lookup(lambda_function_association.value, "event_type")
          lambda_arn   = data.aws_lambda_function.this.arn
          include_body = lookup(lambda_function_association.value, "include_body")
        }
      }

      dynamic "function_association" {
        for_each = lookup(ordered_cache_behavior.value, "function_association") == null ? [] : ["function_association"]
        content {
          event_type   = lookup(function_association.value, "event_type")
          function_arn = element(aws_cloudfront_function.this.*.id, lookup(function_association.value, "function_id"))
        }
      }
    }
  }

  dynamic "origin" {
    for_each = lookup(var.distribution[count.index], "origin") == null ? [] : ["origin"]
    content {
      domain_name              = lookup(origin.value, "domain_name")
      origin_id                = lookup(origin.value, "origin_id")
      connection_attempts      = lookup(origin.value, "connection_attempts")
      connection_timeout       = lookup(origin.value, "connection_timeout")
      origin_access_control_id = lookup(origin.value, "origine_access_control_id")
      origin_path              = lookup(origin.value, "origin_path")

      dynamic "custom_origin_config" {
        for_each = lookup(origin.value, "custom_origin_config") == null ? [] : ["custom_origin_config"]
        content {
          http_port                = lookup(custom_origin_config.value, "http_port")
          https_port               = lookup(custom_origin_config.value, "https_port")
          origin_protocol_policy   = lookup(custom_origin_config.value, "origin_protocol_policy")
          origin_ssl_protocols     = lookup(custom_origin_config.value, "origin_ssl_protocols")
          origin_keepalive_timeout = lookup(custom_origin_config.value, "origin_keepalive_timeout")
          origin_read_timeout      = lookup(custom_origin_config.value, "origin_read_timeout")
        }
      }

      dynamic "custom_header" {
        for_each = lookup(origin.value, "custom_header") == null ? [] : ["custom_header"]
        content {
          name  = lookup(custom_header.value, "name")
          value = lookup(custom_header.value, "value")
        }
      }

      dynamic "origin_shield" {
        for_each = lookup(origin.value, "origin_shield") == null ? [] : ["origin_shield"]
        content {
          enabled              = lookup(origin_shield.value, "enabled")
          origin_shield_region = lookup(origin_shield.value, "origin_shield_region")
        }
      }

      dynamic "s3_origin_config" {
        for_each = lookup(origin.value, "s3_origin_config") == null ? [] : ["s2_origin_config"]
        content {
          origin_access_identity = lookup(s3_origin_config.value, "origin_access_identity")
        }
      }
    }
  }

  dynamic "origin_group" {
    for_each = lookup(var.distribution[count.index], "origin_group") == null ? [] : ["origin_group"]
    content {
      origin_id = lookup(origin_group.value, "origin_id")

      dynamic "failover_criteria" {
        for_each = lookup(origin_group.value, "failover_criteria") == null ? [] : ["failover_criteria"]
        content {
          status_codes = lookup(failover_criteria.value, "status_code")
        }
      }

      dynamic "member" {
        for_each = lookup(origin_group.value, "member") == null ? [] : ["member"]
        content {
          origin_id = lookup(member.value, "origin_id")
        }
      }
    }
  }

  dynamic "restrictions" {
    for_each = lookup(var.distribution[count.index], "restrictions") == null ? [] : ["restrictions"]
    content {
      dynamic "geo_restriction" {
        for_each = lookup(restrictions.value, "geo_restrictions") == null ? [] : ["geo_restrictions"]
        content {
          restriction_type = lookup(geo_restriction.value, "restriction_type")
          locations        = lookup(geo_restriction.value, "locations")
        }
      }
    }
  }

  dynamic "viewer_certificate" {
    for_each = lookup(var.distribution[count.index], "viewer_certificate") == null ? [] : ["viewer_certificate"]
    content {
      acm_certificate_arn            = data.aws_acm_certificate.this.arn
      cloudfront_default_certificate = lookup(viewer_certificate.value, "cloudfront_default_certificate")
      iam_certificate_id             = lookup(viewer_certificate.value, "iam_certificate_id")
      minimum_protocol_version       = lookup(viewer_certificate.value, "minimum_protocol_version")
      ssl_support_method             = lookup(viewer_certificate.value, "ssl_support_method")
    }
  }
}

resource "aws_cloudfront_function" "this" {
  count   = length(var.cloudfront_fonction)
  code    = join("/", [path.cwd, "code", file(lookup(var.cloudfront_fonction[count.index], "code"))])
  name    = lookup(var.cloudfront_fonction[count.index], "name")
  runtime = lookup(var.cloudfront_fonction[count.index], "runtime")
  comment = lookup(var.cloudfront_fonction[count.index], "comment")
  publish = lookup(var.cloudfront_fonction[count.index], "publish")
}

resource "aws_cloudfront_monitoring_subscription" "this" {
  count           = length(var.monitoring_subscription)
  distribution_id = element(aws_cloudfront_distribution.this.*.id, lookup(var.monitoring_subscription[count.index], "distribution_id"))
  monitoring_subscription {
    realtime_metrics_subscription_config {
      realtime_metrics_subscription_status = "Enabled"
    }
  }
}

resource "aws_iam_role" "kinesis_for_cloudfront" {
  count              = var.kinesis_stream ? 1 : 0
  name               = "cloudfront-realtime-log-config"
  assume_role_policy = data.aws_iam_policy_document.assumerole_cloufront.json
}

resource "aws_iam_role_policy" "kinesis_for_cloudfront" {
  count  = var.kinesis_stream ? 1 : 0
  name   = "cloudfront-realtime-log-config"
  role   = aws_iam_role.kinesis_for_cloudfront.id
  policy = data.aws_iam_policy_document.kinesis_stream.json
}

resource "aws_cloudfront_realtime_log_config" "this" {
  count         = var.kinesis_stream ? 1 : 0
  fields        = ["timestamp", "c-ip"]
  name          = "cloudfront_log_config"
  sampling_rate = 100

  endpoint {
    stream_type = "Kinesis"

    kinesis_stream_config {
      role_arn   = aws_iam_role.kinesis_for_cloudfront.arn
      stream_arn = data.aws_kinesis_stream.this.arn
    }
  }
  depends_on = [aws_iam_role_policy.kinesis_for_cloudfront]
}

resource "aws_cloudfront_response_headers_policy" "this" {
  count   = length(var.response_headers_policy)
  name    = lookup(var.response_headers_policy[count.index], "name")
  comment = lookup(var.response_headers_policy[count.index], "comment")

  dynamic "cors_config" {
    for_each = lookup(var.response_headers_policy[count.index], "cors_config") == null ? [] : ["cors_config"]
    content {
      access_control_allow_credentials = false
      origin_override                  = false
      access_control_max_age_sec       = 0

      dynamic "access_control_allow_headers" {
        for_each = lookup(cors_config.value, "access_control_allow_headers") == null ? [] : ["access_control_allow_headers"]
        content {
          items = lookup(access_control_allow_headers.value, "items")
        }
      }

      dynamic "access_control_allow_methods" {
        for_each = lookup(cors_config.value, "access_control_allow_methods") == null ? [] : ["access_control_allow_methods"]
        content {
          items = lookup(access_control_allow_methods.value, "items")
        }
      }

      dynamic "access_control_allow_origins" {
        for_each = lookup(cors_config.value, "access_control_allow_origins") == null ? [] : ["access_control_allow_origins"]
        content {
          items = lookup(access_control_allow_origins.value, "items")
        }
      }

      dynamic "access_control_expose_headers" {
        for_each = lookup(cors_config.value, "access_control_expose_headers") == null ? [] : ["access_control_expose_headers"]
        content {
          items = lookup(access_control_expose_headers.value, "items")
        }
      }
    }
  }

  dynamic "custom_headers_config" {
    for_each = lookup(var.response_headers_policy[count.index], "custom_headers_config") == null ? [] : ["custom_headers_config"]
    content {
      header   = lookup(custom_headers_config.value, "header")
      override = lookup(custom_headers_config.value, "override")
      value    = lookup(custom_headers_config.value, "value")
    }
  }

  dynamic "remove_headers_config" {
    for_each = lookup(var.response_headers_policy[count.index], "remove_headers_config") == null ? [] : ["remove_headers_config"]
    content {
      header = lookup(remove_headers_config.value, "header")
    }
  }

  dynamic "security_headers_config" {
    for_each = lookup(var.response_headers_policy[count.index], "security_headers_config") == null ? [] : ["security_headers_config"]
    content {
      dynamic "content_security_policy" {
        for_each = lookup(security_headers_config.value, "content_security_policy") == null ? [] : ["content_security_policy"]
        content {
          content_security_policy = lookup(content_security_policy.value, "content_security_policy")
          override                = lookup(content_security_policy.value, "override")
        }
      }
      dynamic "content_type_options" {
        for_each = lookup(security_headers_config.value, "content_type_options") == null ? [] : ["content_type_options"]
        content {
          override = lookup(content_type_options.value, "override")
        }
      }
      dynamic "frame_options" {
        for_each = lookup(security_headers_config.value, "frame_options") == null ? [] : ["frame_options"]
        content {
          frame_option = lookup(frame_options.value, "frame_option")
          override     = lookup(frame_options.value, "override")
        }
      }
      dynamic "referrer_policy" {
        for_each = lookup(security_headers_config.value, "referrer_policy") == null ? [] : ["referrer_policy"]
        content {
          override        = lookup(referrer_policy.value, "override")
          referrer_policy = lookup(referrer_policy.value, "referrer_policy")
        }
      }
      dynamic "strict_transport_security" {
        for_each = lookup(security_headers_config.value, "strict_transport_security") == null ? [] : ["strict_transport_security"]
        content {
          access_control_max_age_sec = lookup(strict_transport_security.value, "access_control_max_age_sec")
          override                   = lookup(strict_transport_security.value, "override")
          include_subdomains         = lookup(strict_transport_security.value, "include_subdomains")
          preload                    = lookup(strict_transport_security.value, "preload")
        }
      }
      dynamic "xss_protection" {
        for_each = lookup(security_headers_config.value, "xss_protection") == null ? [] : ["xss_protection"]
        content {
          override   = lookup(xss_protection.value, "override")
          protection = lookup(xss_protection.value, "protection")
          mode_block = lookup(xss_protection.value, "mode_block")
          report_uri = lookup(xss_protection.value, "report_uri")
        }
      }
    }
  }

  dynamic "server_timing_headers_config" {
    for_each = lookup(var.response_headers_policy[count.index], "server_timing_headers_config") == null ? [] : ["server_timing_headers_config"]
    content {
      enabled       = lookup(server_timing_headers_config.value, "enabled")
      sampling_rate = lookup(server_timing_headers_config.value, "sampling_rate")
    }
  }
}