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
    for_each = lookup(var.cloudfont_distribution[count.index], "cache_behavior")
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

      lambda_function_association {
        event_type   = lookup(cache_behavior.value, "event_type")
        lambda_arn   = element(var.lambda_arn, lookup(cache_behavior.value, "lambda_id"))
        include_body = lookup(cache_behavior.value, "include_body", false)
      }

      forwarded_values {
        query_string            = lookup(cache_behavior.value, "query_string", false)
        headers                 = [lookup(cache_behavior.value, "headers")]
        query_string_cache_keys = [lookup(cache_behavior.value, "query_string_cache_keys")]

        cookies {
          forward           = lookup(cache_behavior.value, "forward")
          whitelisted_names = [lookup(cache_behavior.value, "whitelisted_names")]
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
    for_each = lookup(var.cloudfont_distribution[count.index], "origin")
    content {
      domain_name = lookup(origin.value, "origin_type") == "s3" ? element(var.domain_id_s3, lookup(origin.value, "domain_id")) : element(var.domain_id_alb, lookup(origin.value, "domain_id"))
      origin_id   = join("-", ["origin", lookup(origin.value, "origin_type") == "s3" ? element(var.domain_id_s3, lookup(origin.value, "domain_id")) : element(var.domain_id_alb, lookup(origin.value, "domain_id"))])

      custom_header {
        name  = lookup(origin.value, "custom_header_name")
        value = lookup(origin.value, "custom_header_value")
      }

      custom_origin_config {
        http_port              = lookup(origin.value, "http_port")
        https_port             = lookup(origin.value, "https_port")
        origin_protocol_policy = lookup(origin.value, "origin_protocol_policy")
        origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
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
    for_each = lookup(var.cloudfont_distribution[count.index], "restrictions")
    content {
      geo_restriction {
        restriction_type = lookup(restrictions.value, "restriction_type")
        locations        = [lookup(restrictions.value, "locations", null)]
      }
    }
  }

  dynamic "default_cache_behavior" {
    for_each = lookup(var.cloudfont_distribution[count.index], "default_cache_behavior")
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

      forwarded_values {
        query_string            = lookup(default_cache_behavior.value, "query_string", false)
        headers                 = [lookup(default_cache_behavior.value, "headers")]
        query_string_cache_keys = [lookup(default_cache_behavior.value, "query_string_cache_keys")]

        cookies {
          forward           = lookup(default_cache_behavior.value, "forward")
          whitelisted_names = [lookup(default_cache_behavior.value, "whitelisted_names")]
        }
      }

      lambda_function_association {
        event_type   = element(var.event_type, lookup(default_cache_behavior.value, "event_type"))
        lambda_arn   = element(var.lambda_arn, lookup(default_cache_behavior.value, "lambda_id"))
        include_body = lookup(default_cache_behavior.value, "include_body", false)
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
    for_each = lookup(var.cloudfont_distribution[count.index], "ordered_cache_behavior")
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

      forwarded_values {
        query_string            = lookup(ordered_cache_behavior.value, "query_string")
        headers                 = [lookup(ordered_cache_behavior.value, "headers")]
        query_string_cache_keys = [lookup(ordered_cache_behavior.value, "query_string_cache_keys")]

        cookies {
          forward           = lookup(ordered_cache_behavior.value, "forward")
          whitelisted_names = lookup(ordered_cache_behavior.value, "whitelisted_names")
        }
      }

      lambda_function_association {
        event_type   = element(var.event_type, lookup(ordered_cache_behavior.value, "event_type"))
        lambda_arn   = element(var.lambda_arn, lookup(ordered_cache_behavior.value, "lambda_arn"))
        include_body = lookup(ordered_cache_behavior.value, "include_body")
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