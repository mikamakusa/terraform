resource "aws_api_gateway_domain_name" "domain_name" {
  count           = length(var.domain_name)
  domain_name     = lookup(var.domain_name[count.index], "domain_name")
  certificate_arn = var.certificate_arn
  security_policy = lookup(var.domain_name[count.index], "security_policy", null)

  dynamic "endpoint_configuration" {
    for_each = lookup(var.domain_name[count.index], "endpoint_configuration")
    content {
      types = [lookup(endpoint_configuration.value, "types", null)]
    }
  }
}

resource "aws_api_gateway_rest_api" "rest_api" {
  count = length(var.rest_api)
  name  = lookup(var.rest_api[count.index], "name")

  dynamic "endpoint_configuration" {
    for_each = lookup(var.rest_api[count.index], "endpoint_configuration")
    content {
      types = [lookup(endpoint_configuration.value, "types")]
    }
  }

  binary_media_types       = [lookup(var.rest_api[count.index], "binary_medium_types", null)]
  minimum_compression_size = lookup(var.rest_api[count.index], "minimum_compression_size", null)
  body                     = lookup(var.rest_api[count.index], "body", null)
  policy                   = lookup(var.rest_api[count.index], "policy", null)
  api_key_source           = lookup(var.rest_api[count.index], "api_key_source", null)
}

resource "aws_api_gateway_resource" "api_resource" {
  count       = length(var.api_resource)
  parent_id   = element(aws_api_gateway_rest_api.rest_api.*.root_resource_id, lookup(var.api_resource[count.index], "parent_id"))
  path_part   = lookup(var.api_resource[count.index], "path_part")
  rest_api_id = element(aws_api_gateway_rest_api.rest_api.*.id, lookup(var.api_resource[count.index], "rest_api_id"))
}

resource "aws_api_gateway_method" "api_method" {
  count                = length(var.api_resource) == "0" ? "0" : length(var.method)
  authorization        = lookup(var.method[count.index], "authorization")
  http_method          = lookup(var.method[count.index], "http_method")
  resource_id          = element(aws_api_gateway_resource.api_resource.*.id, lookup(var.method[count.index], "resource_id"))
  rest_api_id          = element(aws_api_gateway_rest_api.rest_api.*.id, lookup(var.method[count.index], "rest_api_id"))
  authorizer_id        = lookup(var.method[count.index], "authorizer_id", null)
  authorization_scopes = [lookup(var.method[count.index], "authorization_scopes", null)] ? aws_api_gateway_method.api_method.*.authorizer_id : "COGNITO_USER_POOLS"
  api_key_required     = lookup(var.method[count.index], "api_key_required", null)
  request_models       = lookup(var.method[count.index], "request_models", null)
  request_parameters   = lookup(var.method[count.index], "request_parameters", null)
  request_validator_id = lookup(var.method[count.index], "request_validator_id", null)
}

resource "aws_api_gateway_integration" "api_integration" {
  count       = length(var.rest_api) == "0" ? "0" : length(var.api_integration)
  http_method = element(aws_api_gateway_method.api_method.*.http_method, lookup(var.api_integration[count.index], "http_method_id"))
  resource_id = element(aws_api_gateway_resource.api_resource.*.id, lookup(var.api_integration[count.index], "resource_id"))
  rest_api_id = element(aws_api_gateway_rest_api.rest_api.*.id, lookup(var.api_integration[count.index], "rest_api_id"))
  type        = lookup(var.api_integration[count.index], "type")
}

resource "aws_api_gateway_method_response" "method_response" {
  count       = length(var.rest_api) == "0" ? "0" : length(var.method_response)
  http_method = element(aws_api_gateway_method.api_method.*.http_method, lookup(var.method_response[count.index], "http_method_id"))
  resource_id = element(aws_api_gateway_resource.api_resource.*.id, lookup(var.method_response[count.index], "resource_id"))
  rest_api_id = element(aws_api_gateway_rest_api.rest_api.*.id, lookup(var.method_response[count.index], "rest_api_id"))
  status_code = lookup(var.method_response[count.index], "status_code")
}

resource "aws_api_gateway_deployment" "deployment" {
  count       = length(var.rest_api) == "0" ? "0" : length(var.deployment)
  rest_api_id = element(aws_api_gateway_rest_api.rest_api.*.id, lookup(var.deployment[count.index], "rest_api_id"))
  stage_name  = lookup(var.deployment[count.index], "stage_name")
}

resource "aws_api_gateway_stage" "stage" {
  count         = length(var.rest_api) == "0" ? "0" : length(var.stage)
  deployment_id = element(aws_api_gateway_deployment.deployment.*.id, lookup(var.stage[count.index], "deployment_id"))
  rest_api_id   = element(aws_api_gateway_rest_api.rest_api.*.id, lookup(var.stage[count.index], "rest_api_id"))
  stage_name    = element(aws_api_gateway_deployment.deployment.*.stage_name, lookup(var.stage[count.index], "deployment_id"))
}

resource "aws_api_gateway_method_settings" "settings" {
  count       = length(var.settings)
  method_path = join("/", [element(aws_api_gateway_resource.api_resource.*.path_part, lookup(var.settings[count.index], "resource_id")), element(aws_api_gateway_method.api_method.*.http_method, lookup(var.settings[count.index], "method_id"))])
  rest_api_id = element(aws_api_gateway_rest_api.rest_api.*.id, lookup(var.settings[count.index], "rest_api_id"))
  stage_name  = element(aws_api_gateway_stage.stage.*.stage_name, lookup(var.settings[count.index], "stage_id"))

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

resource "aws_api_gateway_integration_response" "integration_response" {
  count               = length(var.rest_api) == "0" ? "0" : length(var.api_integration_response)
  http_method         = element(aws_api_gateway_method.api_method.*.http_method, lookup(var.api_integration_response[count.index], "http_method_id"))
  resource_id         = element(aws_api_gateway_resource.api_resource.*.id, lookup(var.api_integration_response[count.index], "resource_id"))
  rest_api_id         = element(aws_api_gateway_rest_api.rest_api.*.id, lookup(var.api_integration_response[count.index], "rest_api_id"))
  status_code         = element(aws_api_gateway_method_response.method_response.*.status_code, lookup(var.api_integration_response[count.index], "http_method_id"))
  response_templates  = lookup(var.api_integration_response[count.index], "response_templates", null)
  response_parameters = lookup(var.api_integration_response[count.index], "response_parameters", null)
  content_handling    = lookup(var.api_integration_response[count.index], "content_handling", null)
}

resource "aws_api_gateway_base_path_mapping" "base_path_mapping" {
  count       = length(var.rest_api) == "0" ? "0" : length(var.base_path_mapping)
  api_id      = element(aws_api_gateway_rest_api.rest_api.*.id, lookup(var.base_path_mapping[count.index], "api_id"))
  domain_name = element(aws_api_gateway_domain_name.domain_name.*.domain_name, lookup(var.base_path_mapping[count.index], "domain_id"))
  stage_name  = element(aws_api_gateway_stage.stage.*.stage_name, lookup(var.base_path_mapping[count.index], "stage_id"))
}