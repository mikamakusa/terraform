resource "oci_apm_apm_domain" "this" {
  count          = length(var.domain)
  compartment_id = data.oci_identity_compartment.this.id
  display_name   = lookup(var.domain[count.index], "display_name")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.domain[count.index], "defined_tags")
  )
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.domain[count.index], "freeform_tags")
  )
  is_free_tier = lookup(var.domain[count.index], "is_free_tier")
  description  = lookup(var.domain[count.index], "description")
}

resource "oci_apm_config_config" "this" {
  count = length(var.config) == "0" ? "0" : length(var.domain)
  apm_domain_id = try(
    element(oci_apm_apm_domain.this.*.id, lookup(var.config[count.index], "apm_domain_id"))
  )
  config_type  = lookup(var.config[count.index], "config_type")
  display_name = lookup(var.config[count.index], "display_name")
  filter_id    = lookup(var.config[count.index], "filter_id")
  filter_text  = lookup(var.config[count.index], "filter_text")
  group        = lookup(var.config[count.index], "group")
  namespace    = lookup(var.config[count.index], "namespace")
  opc_dry_run  = lookup(var.config[count.index], "opc_dry_run")
  options      = lookup(var.config[count.index], "options")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.config[count.index], "defined_tags")
  )
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.config[count.index], "freeform_tags")
  )
  description = lookup(var.config[count.index], "config_type") == "OPTIONS" || "SPAN_FILTER" ? lookup(var.config[count.index], "description") : null

  dynamic "dimensions" {
    for_each = lookup(var.config[count.index], "config_type") == "METRIC_GROUP" ? lookup(var.config[count.index], "dimensions") : []
    content {
      name         = lookup(dimensions.value, "name")
      value_source = lookup(dimensions.value, "value_source")
    }
  }

  dynamic "metrics" {
    for_each = lookup(var.config[count.index], "config_type") == "METRIC_GROUP" ? lookup(var.config[count.index], "metrics") : []
    content {
      description  = lookup(metrics.value, "description")
      name         = lookup(metrics.value, "name")
      unit         = lookup(metrics.value, "unit")
      value_source = lookup(metrics.value, "value_source")
    }
  }

  dynamic "rules" {
    for_each = lookup(var.config[count.index], "config_type") == "APDEX" ? lookup(var.config[count.index], "rules") : []
    content {
      display_name             = lookup(rules.value, "display_name")
      filter_text              = lookup(rules.value, "filter_text")
      is_apply_to_error_spans  = lookup(rules.value, "is_apply_to_error_spans")
      is_enabled               = lookup(rules.value, "is_enabled")
      priority                 = lookup(rules.value, "priority")
      satisfied_response_time  = lookup(rules.value, "satisfied_response_time")
      tolerating_response_time = lookup(rules.value, "tolerating_response_time")
    }
  }
}

resource "oci_apm_synthetics_dedicated_vantage_point" "this" {
  count = length(var.synthetics_dedicated_vantage_point) == "0" ? "0" : length(var.domain)
  apm_domain_id = try(
    element(oci_apm_apm_domain.this.*.id, lookup(var.synthetics_dedicated_vantage_point[count.index], "apm_domain_id"))
  )
  display_name = lookup(var.synthetics_dedicated_vantage_point[count.index], "display_name")
  region       = lookup(var.synthetics_dedicated_vantage_point[count.index], "region")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.synthetics_dedicated_vantage_point[count.index], "defined_tags")
  )
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.synthetics_dedicated_vantage_point[count.index], "freeform_tags")
  )
  status = lookup(var.synthetics_dedicated_vantage_point[count.index], "status")

  dynamic "dvp_stack_details" {
    for_each = lookup(var.synthetics_dedicated_vantage_point[count.index], "dvp_stack_details")
    content {
      dvp_stack_id   = lookup(dvp_stack_details.value, "dvp_stack_id")
      dvp_stack_type = lookup(dvp_stack_details.value, "dvp_stack_type")
      dvp_stream_id  = lookup(dvp_stack_details.value, "dvp_stream_id")
      dvp_version    = lookup(dvp_stack_details.value, "dvp_version")
    }
  }
}

resource "oci_apm_synthetics_monitor" "this" {
  count = length(var.synthetics_monitor) == "0" ? "0" : length(var.domain)
  apm_domain_id = try(
    element(oci_apm_apm_domain.this.*.id, lookup(var.synthetics_monitor[count.index], "apm_domain_id"))
  )
  display_name               = lookup(var.synthetics_monitor[count.index], "display_name")
  monitor_type               = lookup(var.synthetics_monitor[count.index], "monitor_type")
  repeat_interval_in_seconds = lookup(var.synthetics_monitor[count.index], "repeat_interval_in_seconds")
  batch_interval_in_seconds  = lookup(var.synthetics_monitor[count.index], "batch_interval_in_seconds")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.synthetics_monitor[count.index], "defined_tags")
  )
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.synthetics_monitor[count.index], "freeform_tags")
  )
  is_run_now  = lookup(var.synthetics_monitor[count.index], "is_run_now")
  is_run_once = lookup(var.synthetics_monitor[count.index], "is_run_once")

  dynamic "availability_configuration" {
    for_each = lookup(var.synthetics_monitor[count.index], "availability_configuration") == null ? [] : ["availability_configuration"]
    content {
      max_allowed_failures_per_interval = lookup(availability_configuration.value, "max_allowed_failures_per_interval")
      min_allowed_runs_per_interval     = lookup(availability_configuration.value, "min_allowed_runs_per_interval")
    }
  }

  dynamic "vantage_points" {
    for_each = lookup(var.synthetics_monitor[count.index], "vantage_points")
    content {
      name         = lookup(vantage_points.value, "name")
      display_name = lookup(vantage_points.value, "display_name")
    }
  }

  dynamic "configuration" {
    for_each = lookup(var.synthetics_monitor[count.index], "configuration") == null ? [] : ["configuration"]
    content {
      config_type                       = lookup(configuration.value, "config_type")
      is_certificate_validation_enabled = lookup(configuration.value, "config_type") == "BROWSER_CONFIG" || "REST_CONFIG" || "SCRIPTED_BROWSER_CONFIG" ? lookup(configuration.value, "is_certificate_validation_enabled") : null
      is_default_snapshot_enabled       = lookup(configuration.value, "config_type") == "BROWSER_CONFIG" || "SCRIPTED_BROWSER_CONFIG" ? lookup(configuration.value, "is_default_snapshot_enabled") : null
      is_failure_retried                = lookup(configuration.value, "is_failure_retried")
      is_redirection_enabled            = lookup(configuration.value, "config_type") == "REST_CONFIG" ? lookup(configuration.value, "is_redirection_enabled") : null
      req_authentication_scheme         = lookup(configuration.value, "req_authentication_scheme")
      request_method                    = lookup(configuration.value, "request_method")
      request_post_body                 = lookup(configuration.value, "request_post_body")
      verify_response_codes             = lookup(configuration.value, "config_type") == "BROWSER_CONFIG" || "REST_CONFIG" || "SCRIPTED_REST_CONFIG" ? lookup(configuration.value, "verify_response_codes") : null
      verify_response_content           = lookup(configuration.value, "config_type") == "DNSSEC_CONFIG" || "DNS_SERVER_CONFIG" || "DNS_TRACE_CONFIG" || "REST_CONFIG" ? lookup(configuration.value, "verify_response_content") : null

      dynamic "client_certificate_details" {
        for_each = lookup(configuration.value, "config_type") == "REST_CONFIG" ? lookup(configuration.value, "client_certificate_details") : []
        content {
          dynamic "client_certificate" {
            for_each = lookup(client_certificate_details.value, "client_certificate")
            content {
              content   = lookup(client_certificate.value, "content")
              file_name = lookup(client_certificate.value, "file_name")
            }
          }

          dynamic "private_key" {
            for_each = lookup(client_certificate_details.value, "private_key")
            content {
              content   = lookup(private_key.value, "content")
              file_name = lookup(private_key.value, "file_name")
            }
          }
        }
      }

      dynamic "dns_configuration" {
        for_each = lookup(configuration.value, "dns_configuration") == null ? [] : ["dns_configuration"]
        content {
          is_override_dns = lookup(dns_configuration.value, "is_override_dns")
          override_dns_ip = lookup(dns_configuration.value, "override_dns_ip")
        }
      }

      dynamic "network_configuration" {
        for_each = lookup(configuration.value, "config_type") == "BROWSER_CONFIG" || "DNS_SERVER_CONFIG" || "NETWORK_CONFIG" || "REST_CONFIG" || "SCRIPTED_BROWSER_CONFIG" || "SCRIPTED_REST_CONFIG" ? lookup(configuration.value, "network_configuration") : []
        content {
          number_of_hops    = lookup(network_configuration.value, "number_of_hops")
          probe_mode        = lookup(network_configuration.value, "probe_mode")
          probe_per_hop     = lookup(network_configuration.value, "probe_per_hop")
          protocol          = lookup(network_configuration.value, "protocol")
          transmission_rate = lookup(network_configuration.value, "transmission_rate")
        }
      }

      dynamic "req_authentication_details" {
        for_each = lookup(configuration.value, "config_type") == "REST_CONFIG" ? lookup(configuration.value, "req_authentication_details") : []
        content {
          auth_request_method    = lookup(req_authentication_details.value, "auth_request_method")
          auth_request_post_body = lookup(req_authentication_details.value, "auth_request_post_body")
          auth_token             = lookup(req_authentication_details.value, "auth_token")
          auth_url               = lookup(req_authentication_details.value, "auth_url")
          auth_user_name         = lookup(req_authentication_details.value, "auth_user_name")
          auth_user_password     = lookup(req_authentication_details.value, "auth_user_password")
          oauth_scheme           = lookup(req_authentication_details.value, "oauth_scheme")
        }
      }

      dynamic "request_headers" {
        for_each = lookup(configuration.value, "config_type") == "REST_CONFIG" ? lookup(configuration.value, "request_headers") : []
        content {
          header_name  = lookup(request_headers.value, "header_name")
          header_value = lookup(request_headers.value, "header_value")
        }
      }

      dynamic "request_query_params" {
        for_each = lookup(configuration.value, "config_type") == "REST_CONFIG" ? lookup(configuration.value, "request_query_params") : []
        content {
          param_name  = lookup(request_query_params.value, "param_name")
          param_value = lookup(request_query_params.value, "param_value")
        }
      }

      dynamic "verify_texts" {
        for_each = lookup(configuration.value, "config_type") == "REST_CONFIG" ? lookup(configuration.value, "verify_texts") : []
        content {
          text = lookup(verify_texts.value, "text")
        }
      }
    }
  }
}

resource "oci_apm_synthetics_script" "this" {
  count             = length(var.synthetics_script) == "0" ? "0" : length(var.domain)
  apm_domain_id     = try(
    element(oci_apm_apm_domain.this.*.id, lookup(var.synthetics_script[count.index], "apm_domain_id"))
  )
  content           = lookup(var.synthetics_script[count.index], "content")
  content_type      = lookup(var.synthetics_script[count.index], "content_type")
  display_name      = lookup(var.synthetics_script[count.index], "display_name")
  content_file_name = lookup(var.synthetics_script[count.index], "content_file_name")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.synthetics_script[count.index], "defined_tags")
  )
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.synthetics_script[count.index], "freeform_tags")
  )

  dynamic "parameters" {
    for_each = lookup(var.synthetics_script[count.index], "parameters") == null ? [] : ["parameters"]
    content {
      param_name  = lookup(parameters.value, "param_name")
      is_secret   = lookup(parameters.value, "is_secret")
      param_value = lookup(parameters.value, "param_value")
    }
  }
}
