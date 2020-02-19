resource "aws_cloudfront_distribution" "cloudfont_distribution" {
  count               = length(var.cloudfont_distribution)
  enabled             = lookup(var.cloudfont_distribution[count.index], "enabled")
  aliases             = [lookup(var.cloudfont_distribution[count.index], "aliases", null)]
  comment             = lookup(var.cloudfont_distribution[count.index], "comment", null)
  default_root_object = lookup(var.cloudfont_distribution[count.index], "default_root_object", null)
  is_ipv6_enabled     = lookup(var.cloudfont_distribution[count.index], "is_ipv6_enabled", null)
  http_version        = lookup(var.cloudfont_distribution[count.index], "http_version", null)
  price_class         = lookup(var.cloudfont_distribution[count.index], "price_class", null)
  retain_on_delete    = lookup(var.cloudfont_distribution[count.index], "retain_on_delete", null)
  tags                = lookup(var.cloudfont_distribution[count.index], "tags", null)
  web_acl_id          = lookup(var.cloudfont_distribution[count.index], "web_acl_id", null)
  wait_for_deployment = lookup(var.cloudfont_distribution[count.index], "wait_for_deployment", null)

  dynamic "cache_behavior" {
    for_each = [for i in lookup(var.cloudfont_distribution[count.index], "cache_behavior") : {
      lambda_function_association = lookup(i, "lambda_function_association")
      forwarded_values            = lookup(i, "forwarded_values")
    }]
    content {
      allowed_methods           = [lookup(cache_behavior.value, "allowed_methods")]
      cached_methods            = [lookup(cache_behavior.value, "cached_methods")]
      path_pattern              = lookup(cache_behavior.value, "path_patterns")
      target_origin_id          = element(var.target_origin_id, lookup(cache_behavior.value, "target_origin_id"))
      viewer_protocol_policy    = lookup(cache_behavior.value, "viewer_protocol_policy")
      compress                  = lookup(cache_behavior.value, "compress", false)
      default_ttl               = lookup(cache_behavior.value, "default_ttl", null)
      field_level_encryption_id = lookup(cache_behavior.value, "field_level_encryption", null)
      max_ttl                   = lookup(cache_behavior.value, "max_ttl", null)
      min_ttl                   = lookup(cache_behavior.value, "min_ttl", null)
      trusted_signers           = [lookup(cache_behavior.value, "trusted_signers", null)]

      dynamic "lambda_function_association" {
        for_each = cache_behavior.value.lambda_function_association == null ? [] : [for i in cache_behavior.value.lambda_function_association : {
          event_id     = i.event_id
          lambda_id    = i.lambda_id
          include_body = i.include_body
        }]
        content {
          event_type   = element(var.event_type, lambda_function_association.value.event_id)
          lambda_arn   = element(var.lambda_arn, lambda_function_association.value.lambda_id)
          include_body = lambda_function_association.value.include_body
        }
      }

      dynamic "forwarded_values" {
        for_each = cache_behavior.value.forwarded_values == null ? [] : [for i in cache_behavior.value.forwarded_values : {
          query_string            = i.query_string
          headers                 = i.headers
          query_string_cache_keys = i.query_string_cache_keys
        }]
        content {
          query_string            = forwarded_values.value.query_string
          headers                 = forwarded_values.value.headers
          query_string_cache_keys = [forwarded_values.value.query_string_cache_keys]

          dynamic "cookies" {
            for_each = forwarded_values.value.cookies == null ? [] : [for i in forwarded_values.value.cookies : {
              forward           = i.forward
              whitelisted_names = i.whitelisted_names
            }]
            content {
              forward           = cookies.value.forward
              whitelisted_names = [cookies.value.whitelisted_names]
            }
          }
        }
      }
    }
  }

  dynamic "custom_error_response" {
    for_each = lookup(var.cloudfont_distribution[count.index], "custom_error_response")
    content {
      error_code            = lookup(custom_error_response.value, "error_code")
      error_caching_min_ttl = lookup(custom_error_response.value, "error_caching_min_ttl")
      response_code         = lookup(custom_error_response.value, "response_code")
      response_page_path    = lookup(custom_error_response.value, "response_page_path")
    }
  }

  dynamic "origin" {
    for_each = [for i in lookup(var.cloudfont_distribution[count.index], "origin") : {
      custom_header        = lookup(i, "custom_header")
      custom_origin_config = lookup(i, "custom_origin_config")
      s3_origin_config     = lookup(i, "s3_origin_config")
    }]
    content {
      domain_name = lookup(origin.value, "origin_type") == "s3" ? element(var.domain_id_s3, lookup(origin.value, "domain_id")) : element(var.domain_id_alb, lookup(origin.value, "domain_id"))
      origin_id   = join("-", ["origin", lookup(origin.value, "origin_type") == "s3" ? element(var.domain_id_s3, lookup(origin.value, "domain_id")) : element(var.domain_id_alb, lookup(origin.value, "domain_id"))])

      dynamic "custom_header" {
        for_each = origin.value.custom_header == null ? [] : [for i in origin.value.custom_header : {
          name  = i.name
          value = i.value
        }]
        content {
          name  = custom_header.value.name
          value = custom_header.value.value
        }
      }

      dynamic "custom_origin_config" {
        for_each = origin.value.custom_origin_config == null ? [] : [for i in origin.value.custom_origin_config : {
          http_port              = i.http_port
          https_port             = i.https_port
          origin_protocol_policy = i.origin_protocol_policy
          origin_ssl_protocols   = i.origin_ssl_protocols
        }]
        content {
          http_port              = custom_origin_config.value.http_port
          https_port             = custom_origin_config.value.https_port
          origin_protocol_policy = custom_origin_config.value.origin_protocol_policy
          origin_ssl_protocols   = [custom_origin_config.value.origin_ssl_protocols]
        }
      }

      s3_origin_config {
        origin_access_identity = lookup(origin.value, "origin_type") == "s3" ? element(var.origin_access_identity_id, lookup(origin.value, "origin_access_identity_id", "")) : ""
      }
    }
  }

  dynamic "origin_group" {
    for_each = [for i in lookup(var.cloudfont_distribution[count.index], "origin_group") : {
      id           = i.origin_id
      status_codes = i.status_codes
      member       = lookup(i, "member", null)
    }]
    content {
      origin_id = origin_group.value.id
      failover_criteria {
        status_codes = origin_group.value.status_codes
      }
      dynamic "member" {
        for_each = origin_group.value.member == null ? [] : [for i in origin_group.value.member : {
          id   = i.origin_id
          type = i.origin_type
        }]
        content {
          origin_id = member.value.type == "s3" ? element(var.domain_id_s3, member.value.id) : member.value.type == "alb" ? element(var.domain_id_alb, member.value.id) : element(var.domain_id_ec2, member.value.id)
        }
      }
    }
  }

  dynamic "restrictions" {
    for_each = [for i in lookup(var.cloudfont_distribution[count.index], "restrictions") : {
      geo_restriction = lookup(i, "geo_restriction")
    }]
    content {
      dynamic "geo_restriction" {
        for_each = [for i in restrictions.value.geo_restriction : {
          restriction_type = i.restriction_type
          locations        = i.locations
        }]
        content {
          restriction_type = geo_restriction.value.restriction_type
          locations        = [geo_restriction.value.locations]
        }
      }
    }
  }

  dynamic "default_cache_behavior" {
    for_each = [for i in lookup(var.cloudfont_distribution[count.index], "default_cache_behavior") : {
      forwarded_values            = lookup(i, "forwarded_values", null)
      lambda_function_association = lookup(i, "lambda_function_association", null)
    }]
    content {
      allowed_methods           = [lookup(default_cache_behavior.value, "allowed_methods")]
      cached_methods            = [lookup(default_cache_behavior.value, "cached_methods")]
      target_origin_id          = lookup(default_cache_behavior.value, "target_origin_id")
      viewer_protocol_policy    = lookup(default_cache_behavior.value, "viewer_protocol_policy")
      compress                  = lookup(default_cache_behavior.value, "compress", null)
      default_ttl               = lookup(default_cache_behavior.value, "default_ttl", null)
      field_level_encryption_id = lookup(default_cache_behavior.value, "field_level_encryption_id", null)
      max_ttl                   = lookup(default_cache_behavior.value, "max_ttl", null)
      min_ttl                   = lookup(default_cache_behavior.value, "min_ttl", null)
      trusted_signers           = [lookup(default_cache_behavior.value, "trusted_signers", null)]

      dynamic "forwarded_values" {
        for_each = [for i in default_cache_behavior.value.forwarded_values : {
          query_string            = i.query_string
          headers                 = i.headers
          query_string_cache_keys = i.query_string_cache_keys
          cookies                 = lookup(i, "cookies")
        }]
        content {
          query_string            = forwarded_values.value.query_string
          headers                 = [forwarded_values.value.headers]
          query_string_cache_keys = [forwarded_values.value.query_string_cache_keys]
          dynamic "cookies" {
            for_each = [for i in forwarded_values.value.cookies : {
              forward           = i.forward
              whitelisted_names = i.whitelisted_names
            }]
            content {
              forward           = cookies.value.forward
              whitelisted_names = [cookies.value.whitelisted_names]
            }
          }
        }
      }

      dynamic "lambda_function_association" {
        for_each = [for i in default_cache_behavior.value.lambda_function_association : {
          event_id     = i.event_id
          lambda_id    = i.lambda_id
          include_body = i.include_body
        }]
        content {
          event_type   = element(var.event_type, lambda_function_association.value.event_id)
          lambda_arn   = element(var.lambda_arn, lambda_function_association.value.lambda_id)
          include_body = lambda_function_association.value.include_body
        }
      }
    }
  }

  dynamic "logging_config" {
    for_each = lookup(var.cloudfont_distribution[count.index], "logging_config")
    content {
      bucket = element(var.bucket_id, lookup(logging_config.value, "bucket_id"))
    }
  }

  dynamic "ordered_cache_behavior" {
    for_each = [for i in lookup(var.cloudfont_distribution[count.index], "ordered_cache_behavior") : {
      forwarded_value             = lookup(i, "forwarded_values")
      lambda_function_association = lookup(i, "lambda_function_association")
    }]
    content {
      allowed_methods           = [lookup(ordered_cache_behavior.value, "allowed_methods")]
      cached_methods            = [lookup(ordered_cache_behavior.value, "cached_methods")]
      path_pattern              = lookup(ordered_cache_behavior.value, "path_pattern")
      target_origin_id          = lookup(ordered_cache_behavior.value, "target_origin_id")
      viewer_protocol_policy    = lookup(ordered_cache_behavior.value, "viewer_protocol_policy")
      compress                  = lookup(ordered_cache_behavior.value, "compress", null)
      default_ttl               = lookup(ordered_cache_behavior.value, "default_ttl", null)
      field_level_encryption_id = lookup(ordered_cache_behavior.value, "field_level_encryption_id", null)
      max_ttl                   = lookup(ordered_cache_behavior.value, "max_ttl", null)
      min_ttl                   = lookup(ordered_cache_behavior.value, "min_ttl", null)
      trusted_signers           = [lookup(ordered_cache_behavior.value, "trusted_signers"), null]

      dynamic "forwarded_values" {
        for_each = [for i in ordered_cache_behavior.value.forwarded_value : {
          query_string            = i.query_string
          headers                 = i.headers
          query_string_cache_keys = i.query_string_cache_keys
          cookies                 = lookup(i, "cookies")
        }]
        content {
          query_string            = forwarded_values.value.query_string
          headers                 = [forwarded_values.value.headers]
          query_string_cache_keys = [forwarded_values.value.query_string_cache_keys]
          dynamic "cookies" {
            for_each = [for i in forwarded_values.value.cookies : {
              forward           = i.forward
              whitelisted_names = i.whitelisted_names
            }]
            content {
              forward           = cookies.value.forward
              whitelisted_names = [cookies.value.whitelisted_names]
            }
          }
        }
      }

      dynamic "lambda_function_association" {
        for_each = [for i in ordered_cache_behavior.value.lambda_function_association : {
          event_id     = i.event_id
          lambda_id    = i.lambda_id
          include_body = i.include_body
        }]
        content {
          event_type   = element(var.event_type, lambda_function_association.value.event_id)
          lambda_arn   = element(var.lambda_arn, lambda_function_association.value.lambda_id)
          include_body = lambda_function_association.value.include_body
        }
      }
    }
  }

  dynamic "viewer_certificate" {
    for_each = lookup(var.cloudfont_distribution[count.index], "viewer_certificate")
    content {
      acm_certificate_arn            = element(var.acm_certificate_arn, lookup(viewer_certificate.value, "acm_certificate_id"))
      cloudfront_default_certificate = lookup(viewer_certificate.value, "cloudfront_default_certificate", true)
      iam_certificate_id             = element(var.iam_certificate_id, lookup(viewer_certificate.value, "iam_certificate_id"))
      minimum_protocol_version       = lookup(viewer_certificate.value, "minimum_protocol_version")
      ssl_support_method             = lookup(viewer_certificate.value, "ssl_support_method")
    }
  }
}