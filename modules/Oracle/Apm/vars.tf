variable "defined_tags" {
  type    = map(string)
  default = {}
}

variable "freeform_tags" {
  type    = map(string)
  default = {}
}

variable "compartment_id" {
  type        = string
  description = <<EOF
This data source provides details about a specific Compartment resource in Oracle Cloud Infrastructure Identity service.
Gets the specified compartment's information.
EOF
}

variable "domain" {
  type = list(object({
    id            = number
    display_name  = string
    defined_tags  = optional(map(string))
    freeform_tags = optional(map(string))
    is_free_tier  = optional(bool)
    description   = optional(string)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "config" {
  type = list(object({
    id            = number
    apm_domain_id = number
    config_type   = string
    display_name  = string
    filter_id     = optional(string)
    filter_text   = optional(string)
    group         = optional(string)
    namespace     = optional(string)
    opc_dry_run   = optional(string)
    options       = optional(string)
    defined_tags  = optional(map(string))
    freeform_tags = optional(map(string))
    description   = optional(string)
    dimensions = optional(list(object({
      name         = string
      value_source = string
    })), [])
    metrics = optional(list(object({
      description  = string
      name         = string
      unit         = string
      value_source = string
    })), [])
    rules = optional(list(object({
      display_name             = string
      filter_text              = string
      is_apply_to_error_spans  = bool
      is_enabled               = bool
      priority                 = number
      satisfied_response_time  = number
      tolerating_response_time = number
    })), [])
  }))
  default     = []
  description = <<EOF
This resource provides the Config resource in Oracle Cloud Infrastructure Apm Config service.
EOF
}

variable "synthetics_dedicated_vantage_point" {
  type = list(object({
    id            = number
    apm_domain_id = number
    display_name  = string
    region        = string
    defined_tags  = optional(map(string))
    freeform_tags = optional(map(string))
    status        = optional(string)
    dvp_stack_details = list(object({
      dvp_stack_id   = string
      dvp_stack_type = string
      dvp_stream_id  = string
      dvp_version    = string
    }))
  }))
  default     = []
  description = <<EOF
This resource provides the Dedicated Vantage Point resource in Oracle Cloud Infrastructure Apm Synthetics service.
EOF
}

variable "synthetics_monitor" {
  type = list(object({
    id                         = number
    apm_domain_id              = number
    display_name               = string
    monitor_type               = string
    repeat_interval_in_seconds = number
    batch_interval_in_seconds  = optional(number)
    defined_tags               = optional(map(string))
    freeform_tags              = optional(map(string))
    is_run_now                 = optional(bool)
    is_run_once                = optional(bool)
    availability_configuration = optional(list(object({
      max_allowed_failures_per_interval = optional(number)
      min_allowed_runs_per_interval     = optional(number)
    })), [])
    vantage_points = list(object({
      name         = string
      display_name = string
    }))
    configuration = optional(list(object({
      config_type                       = optional(string)
      is_certificate_validation_enabled = optional(bool)
      is_default_snapshot_enabled       = optional(bool)
      is_failure_retried                = optional(bool)
      is_redirection_enabled            = optional(bool)
      req_authentication_scheme         = optional(string)
      request_method                    = optional(string)
      request_post_body                 = optional(string)
      verify_response_codes             = optional(list(string))
      verify_response_content           = optional(string)
      client_certificate_details = optional(list(object({
        client_certificate = optional(list(object({
          content   = optional(string)
          file_name = optional(string)
        })), [])
        private_key = optional(list(object({
          content   = optional(string)
          file_name = optional(string)
        })), [])
      })), [])
      dns_configuration = optional(list(object({
        is_override_dns = optional(bool)
        override_dns_ip = optional(string)
      })), [])
      network_configuration = optional(list(object({
        number_of_hops    = optional(number)
        probe_mode        = optional(string)
        probe_per_hop     = optional(number)
        protocol          = optional(string)
        transmission_rate = optional(number)
      })), [])
      req_authentication_details = optional(list(object({
        auth_request_method    = optional(string)
        auth_request_post_body = optional(string)
        auth_token             = optional(string)
        auth_url               = optional(string)
        auth_user_name         = optional(string)
        auth_user_password     = optional(string)
        oauth_scheme           = optional(string)
      })), [])
      request_headers = optional(list(object({
        header_name  = optional(string)
        header_value = optional(string)
      })), [])
      request_query_params = optional(list(object({
        param_name  = optional(string)
        param_value = optional(string)
      })), [])
      verify_texts = optional(list(object({
        text = optional(string)
      })), [])
    })), [])
  }))
  default     = []
  description = <<EOF
This resource provides the Monitor resource in Oracle Cloud Infrastructure Apm Synthetics service.
EOF
}

variable "synthetics_script" {
  type = list(object({
    id                = number
    apm_domain_id     = string
    content           = string
    content_type      = string
    display_name      = string
    content_file_name = optional(string)
    defined_tags      = optional(map(string))
    freeform_tags     = optional(map(string))
    parameters = optional(list(object({
      param_name  = string
      is_secret   = optional(bool)
      param_value = optional(string)
    })), [])
  }))
  default     = []
  description = <<EOF
This resource provides the Script resource in Oracle Cloud Infrastructure Apm Synthetics service.
EOF
}