# How to use this module

## The resources
```hcl-terraform
module "api_gateway" {
  source                   = "../modules/AWS/APIGateway"
  api_integration          = var.api_integration
  api_integration_response = var.api_integration_response
  api_resource             = var.api_resource
  base_path_mapping        = var.base_path_mapping
  certificate_arn          = var.certificate_arn
  deployment               = var.deployment
  domain_name              = var.domain_name
  method                   = var.method
  method_response          = var.method_response
  rest_api                 = var.rest_api
  settings                 = var.settings
  stage                    = var.stage
}
```

## The vars
```hcl-terraform
variable "api_integration" {
  type = "list"
}

variable "api_integration_response" {
  type = "list"
}

variable "api_resource" {
  type = "list"
}

variable "base_path_mapping" {
  type = "list"
}

variable "certificate_arn" {}

variable "deployment" {
  type = "list"
}

variable "domain_name" {
  type = "list"
}

variable "method" {
  type = "list"
}

variable "method_response" {
  type = "list"
}

variable "rest_api" {
  type = "list"
}

variable "settings" {
  type = "list"
}

variable "stage" {
  type = "list"
}
```

## The tfvars file
```hcl-terraform
domain_name = [
  {
    id              = ""
    domain_name     = ""
    security_policy = ""
  }
]

rest_api = [
  {
    id   = ""
    name = ""
    endpoint_configuration = [
      {
        types = ""
      }
    ]
    binary_medium_types      = ""
    minimum_compression_size = ""
    body                     = ""
    policy                   = ""
    api_key_source           = ""
  }
]

api_resource = [
  {
    id          = ""
    parent_id   = ""
    path_part   = ""
    rest_api_id = ""
  }
]

method = [
  {
    authorization        = ""
    http_method          = ""
    resource_id          = ""
    rest_api_id          = ""
    authorizer_id        = ""
    authorization_scopes = ""
    api_key_required     = ""
    request_models       = ""
    request_parameters   = ""
    request_validator_id = ""
  }
]

api_integration = [
  {
    id             = ""
    http_method_id = ""
    resource_id    = ""
    rest_api_id    = ""
    type           = ""
  }
]

method_response = [
  {
    id             = ""
    http_method_id = ""
    resource_id    = ""
    rest_api_id    = ""
    status_code    = ""
  }
]

deployment = [
  {
    id          = ""
    rest_api_id = ""
    stage_name  = ""
  }
]

stage = [
  {
    id            = ""
    deployment_id = ""
    rest_api_id   = ""
    deployment_id = ""
  }
]

settings = [
  {
    id          = ""
    resource_id = ""
    method_id   = ""
    rest_api_id = ""
    stage_id    = ""
    settings = [
      {
        metrics_enabled                            = ""
        logging_level                              = ""
        data_trace_enabled                         = ""
        throttling_burst_limit                     = ""
        throttling_rate_limit                      = ""
        cache_data_encrypted                       = ""
        cache_ttl_in_seconds                       = ""
        caching_enabled                            = ""
        require_authorization_for_cache_control    = ""
        unauthorized_cache_control_header_strategy = ""
      }
    ]
  }
]

api_integration_response = [
  {
    id                  = ""
    http_method_id      = ""
    resource_id         = ""
    rest_api_id         = ""
    http_method_id      = ""
    response_templates  = ""
    response_parameters = ""
    content_handling    = ""
  }
]
base_path_mapping = [
  {
    id        = ""
    api_id    = ""
    domain_id = ""
    stage_id  = ""
  }
]
```