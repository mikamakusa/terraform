variable "project_id" {
  type = string
}

variable "application" {
  type = list(map(object({
    id             = number
    location_id    = string
    auth_domain    = optional(string)
    database_type  = optional(string)
    serving_status = optional(string)
    feature_settings = optional(list(object({
      split_health_checks = bool
    })), [])
    iap = optional(list(object({
      oauth2_client_id     = string
      oauth2_client_secret = string
    })), [])
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "application_url_dispatch_rules" {
  type = list(map(object({
    id = number
    dispatch_rules = optional(list(object({
      path       = string
      service_id = number
      domain     = optional(string)
    })), [])
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "domain_mapping" {
  type = list(map(object({
    id                = number
    domain_name       = string
    override_strategy = optional(string)
    ssl_settings = optional(list(object({
      ssl_management_type = string
      certificate_id      = optional(string)
    })), [])
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "firewall_rule" {
  type = list(map(object({
    id           = number
    action       = string
    source_range = string
    description  = optional(string)
    priority     = optional(number)
    project      = optional(string)
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "flexible_app_version" {
  type = list(map(object({
    id                           = number
    runtime                      = string
    service                      = string
    version_id                   = optional(string)
    inbound_services             = optional(list(string))
    instance_class               = optional(string)
    runtime_api_version          = optional(string)
    runtime_channel              = optional(string)
    runtime_main_executable_path = optional(string)
    serving_status               = optional(string)
    env_variables                = optional(map(string))
    default_expiration           = optional(string)
    nobuild_files_regex          = optional(string)
    noop_on_destroy              = optional(bool)
    liveness_check = list(object({
      path              = string
      host              = string
      failure_threshold = optional(number)
      success_threshold = optional(number)
      check_interval    = optional(string)
      timeout           = optional(string)
      initial_delay     = optional(string)
    }))
    readiness_check = list(object({
      path              = string
      host              = string
      failure_threshold = optional(number)
      success_threshold = optional(number)
      check_interval    = optional(string)
      timeout           = optional(string)
      app_start_timeout = optional(string)
    }))
    deployment = optional(list(object({
      zip = optional(list(object({
        source_url  = string
        files_count = optional(number)
      })), [])
      files = optional(list(object({
        name       = string
        source_url = string
        sha1_sum   = optional(string)
      })), [])
      container = optional(list(object({
        image = string
      })), [])
      cloud_build_options = optional(list(object({
        app_yaml_path       = string
        cloud_build_timeout = optional(string)
      })), [])
    })), [])
    api_config = optional(list(object({
      script           = string
      auth_fail_action = optional(string)
      login            = optional(string)
      security_level   = optional(string)
      url              = optional(string)
    })), [])
    automatic_scaling = optional(list(object({
      cool_down_period        = optional(string)
      max_concurrent_requests = optional(number)
      max_idle_instances      = optional(number)
      max_pending_latency     = optional(string)
      max_total_instances     = optional(number)
      min_idle_instances      = optional(number)
      min_pending_latency     = optional(string)
      min_total_instances     = optional(number)
      network_utilization = optional(list(object({
        target_received_bytes_per_second   = optional(number)
        target_received_packets_per_second = optional(number)
        target_sent_bytes_per_second       = optional(number)
        target_sent_packets_per_second     = optional(number)
      })), [])
      disk_utilization = optional(list(object({
        target_read_bytes_per_second  = optional(number)
        target_read_ops_per_second    = optional(number)
        target_write_bytes_per_second = optional(number)
        target_write_ops_per_second   = optional(number)
      })), [])
      request_utilization = optional(list(object({
        target_concurrent_requests      = optional(number)
        target_request_count_per_second = optional(string)
      })), [])
      cpu_utilization = optional(list(object({
        target_utilization        = optional(number)
        aggregation_window_length = optional(string)
      })), [])
    })), [])
    endpoints_api_service = optional(list(object({
      name                   = string
      config_id              = optional(string)
      rollout_strategy       = optional(string)
      disable_trace_sampling = optional(bool)
    })), [])
    entrypoint = optional(list(object({
      shel = string
    })), [])
    handlers = optional(list(object({
      url_regex                   = optional(string)
      security_level              = optional(string)
      login                       = optional(string)
      auth_fail_action            = optional(string)
      redirect_http_response_code = optional(string)
      static_files = optional(list(object({
        path                  = optional(string)
        upload_path_regex     = optional(string)
        http_headers          = optional(map(string))
        mime_type             = optional(string)
        expiration            = optional(string)
        require_matching_file = optional(bool)
        application_readable  = optional(bool)
      })), [])
      script = optional(list(object({
        script_path = string
      })), [])
    })), [])
    manual_scaling = optional(list(object({
      instances = number
    })), [])
    network = optional(list(object({
      name             = string
      forwarded_ports  = optional(list(string))
      instance_tag     = optional(string)
      session_affinity = optional(bool)
      subnetwork       = optional(string)
    })), [])
    resources = optional(list(object({
      cpu       = optional(number)
      disk_gb   = optional(number)
      memory_gb = optional(number)
      volumes = optional(list(object({
        name        = string
        size_gb     = number
        volume_type = string
      })), [])
    })), [])
    vpc_access_connector = optional(list(object({
      name = string
    })), [])
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "service_network_settings" {
  type = list(map(object({
    id         = number
    service_id = number
    network_settings = optional(list(object({
      ingress_traffic_allowed = optional(string)
    })), [])
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "service_split_traffic" {
  type = list(map(object({
    id         = number
    service_id = number
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "standard_app_version" {
  type = list(map(object({
    id                        = number
    runtime                   = string
    service                   = string
    version_id                = optional(string)
    threadsafe                = optional(bool)
    runtime_api_version       = optional(string)
    env_variables             = optional(map(string))
    inbound_services          = optional(list(string))
    instance_class            = optional(string)
    noop_on_destroy           = optional(bool)
    delete_service_on_destroy = optional(bool)
    entrypoint = list(object({
      shell = string
    }))
    deployment = optional(list(object({
      zip = optional(list(object({
        source_url  = string
        files_count = optional(number)
      })), [])
      files = optional(list(object({
        name       = string
        source_url = string
        sha1_sum   = optional(string)
      })), [])
    })), [])
    handlers = optional(list(object({
      url_regex                   = optional(string)
      security_level              = optional(string)
      login                       = optional(string)
      auth_fail_action            = optional(string)
      redirect_http_response_code = optional(string)
      static_files = optional(list(object({
        path                  = optional(string)
        upload_path_regex     = optional(string)
        http_headers          = optional(map(string))
        mime_type             = optional(string)
        expiration            = optional(string)
        require_matching_file = optional(bool)
        application_readable  = optional(bool)
      })), [])
      script = optional(list(object({
        script_path = string
      })), [])
    })), [])
    libraries = optional(list(object({
      name    = optional(string)
      version = optional(string)
    })), [])
    vpc_access_connector = optional(list(object({
      name = string
    })), [])
    automatic_scaling = optional(list(object({
      max_concurrent_requests = optional(number)
      max_idle_instances      = optional(number)
      max_pending_latency     = optional(string)
      min_idle_instances      = optional(number)
      min_pending_latency     = optional(string)
      standard_scheduler_settings = optional(list(object({
        target_cpu_utilization        = optional(number)
        target_throughput_utilization = optional(number)
        max_instances                 = optional(number)
        min_instances                 = optional(number)
      })), [])
    })), [])
    basic_scaling = optional(list(object({
      max_instances = number
      idle_timeout  = optional(string)
    })), [])
    manual_scaling = optional(list(object({
      instances = number
    })), [])
  })))
  default     = []
  description = <<EOF
  EOF
}
