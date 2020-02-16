resource "aws_api_gateway_method_settings" "settings" {
  count       = length(var.settings)
  method_path = join("/", [element(var.api_resource_path_part, lookup(var.settings[count.index], "resource_id")), element(var.http_method, lookup(var.settings[count.index], "method_id"))])
  rest_api_id = element(var.rest_api_id, lookup(var.settings[count.index], "rest_api_id"))
  stage_name  = element(var.stage_name, lookup(var.settings[count.index], "stage_id"))

  dynamic "settings" {
    for_each = lookup(var.settings[count.index], "settings")
    content {
      metrics_enabled                            = lookup(settings.value, "metrics_enabled", false)
      logging_level                              = lookup(settings.value, "logging_level", null)
      data_trace_enabled                         = lookup(settings.value, "data_trace_enabled", false)
      throttling_burst_limit                     = lookup(settings.value, "throttling_burst_limit", null)
      throttling_rate_limit                      = lookup(settings.value, "throttling_rate_limit", null)
      cache_data_encrypted                       = lookup(settings.value, "cache_data_encrypted", false)
      cache_ttl_in_seconds                       = lookup(settings.value, "cache_ttl_in_seconds", null)
      caching_enabled                            = lookup(settings.value, "caching_enabled", false)
      require_authorization_for_cache_control    = lookup(settings.value, "require_authorization_for_cache_control", false)
      unauthorized_cache_control_header_strategy = lookup(settings.value, "unauthorized_cache_control_header_strategy", null)
    }
  }
}