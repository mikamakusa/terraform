resource "google_app_engine_application" "this" {
  count          = length(var.application)
  location_id    = lookup(var.application[count.index], "location_id")
  project        = data.google_project.this.project_id
  auth_domain    = lookup(var.application[count.index], "auth_domain")
  database_type  = lookup(var.application[count.index], "database_type")
  serving_status = lookup(var.application[count.index], "serving_status")

  dynamic "feature_settings" {
    for_each = lookup(var.application[count.index], "feature_settings") == null ? [] : ["feature_settings"]
    content {
      split_health_checks = lookup(feature_settings.value, "split_health_checks")
    }
  }

  dynamic "iap" {
    for_each = lookup(var.application[count.index], "iap") == null ? [] : ["iap"]
    content {
      oauth2_client_id     = lookup(iap.value, "oauth2_client_id")
      oauth2_client_secret = lookup(iap.value, "oauth2_client_secret")
    }
  }
}

resource "google_app_engine_application_url_dispatch_rules" "this" {
  count   = length(var.application_url_dispatch_rules)
  project = data.google_project.this.project_id

  dynamic "dispatch_rules" {
    for_each = lookup(var.application_url_dispatch_rules[count.index], "dispatch_rules")
    content {
      path    = lookup(dispatch_rules.value, "path")
      service = lookup(dispatch_rules.value, "service")
      domain  = lookup(dispatch_rules.value, "domain")
    }
  }
}

resource "google_app_engine_domain_mapping" "this" {
  count             = length(var.domain_mapping)
  domain_name       = lookup(var.domain_mapping[count.index], "domain_name")
  override_strategy = lookup(var.domain_mapping[count.index], "override_strategy")
  project           = data.google_project.this.project_id

  dynamic "ssl_settings" {
    for_each = lookup(var.domain_mapping[count.index], "ssl_settings") == null ? [] : ["ssl_settings"]
    content {
      ssl_management_type = lookup(ssl_settings.value, "ssl_management_type")
      certificate_id      = lookup(ssl_settings.value, "certificate_id")
    }
  }
}

resource "google_app_engine_firewall_rule" "this" {
  count        = length(var.firewall_rule)
  action       = lookup(var.firewall_rule[count.index], "action")
  source_range = lookup(var.firewall_rule[count.index], "source_range")
  description  = lookup(var.firewall_rule[count.index], "description")
  priority     = lookup(var.firewall_rule[count.index], "priority")
  project      = data.google_project.this.project_id
}

resource "google_app_engine_flexible_app_version" "this" {
  count   = length(var.flexible_app_version)
  runtime = lookup(var.flexible_app_version[count.index], "runtime")
  service = try(
    element(google_app_engine_standard_app_version.this.*.service, lookup(var.flexible_app_version[count.index], "service"))
  )
  project                      = data.google_project.this.project_id
  version_id                   = lookup(var.flexible_app_version[count.index], "version_id")
  inbound_services             = lookup(var.flexible_app_version[count.index], "inbound_services")
  instance_class               = lookup(var.flexible_app_version[count.index], "instance_class")
  runtime_api_version          = lookup(var.flexible_app_version[count.index], "runtime_api_version")
  runtime_channel              = lookup(var.flexible_app_version[count.index], "runtime_channel")
  runtime_main_executable_path = lookup(var.flexible_app_version[count.index], "runtime_main_executable_path")
  serving_status               = lookup(var.flexible_app_version[count.index], "serving_status")
  env_variables                = lookup(var.flexible_app_version[count.index], "env_variables")
  default_expiration           = lookup(var.flexible_app_version[count.index], "default_expiration")
  nobuild_files_regex          = lookup(var.flexible_app_version[count.index], "nobuild_files_regex")
  noop_on_destroy              = lookup(var.flexible_app_version[count.index], "noop_on_destroy")

  dynamic "deployment" {
    for_each = lookup(var.flexible_app_version[count.index], "deployment") == null ? [] : ["deployment"]
    content {
      dynamic "zip" {
        for_each = lookup(deployment.value, "zip") == null ? [] : ["zip"]
        content {
          source_url  = lookup(zip.value, "source_url")
          files_count = lookup(zip.value, "files_count")
        }
      }

      dynamic "files" {
        for_each = lookup(deployment.value, "files") == null ? [] : ["files"]
        content {
          name       = lookup(files.value, "name")
          source_url = lookup(files.value, "source_url")
          sha1_sum   = lookup(files.value, "sha1_sum")
        }
      }
      dynamic "container" {
        for_each = lookup(deployment.value, "container") == null ? [] : ["container"]
        content {
          image = lookup(container.value, "image")
        }
      }
      dynamic "cloud_build_options" {
        for_each = lookup(deployment.value, "cloud_build_options") == null ? [] : ["cloud_build_options"]
        content {
          app_yaml_path       = lookup(cloud_build_options.value, "app_yaml_path")
          cloud_build_timeout = lookup(cloud_build_options.value, "cloud_build_timeout")
        }
      }
    }
  }

  dynamic "api_config" {
    for_each = lookup(var.flexible_app_version[count.index], "api_config") == null ? [] : ["api_config"]
    content {
      script           = lookup(api_config.value, "script")
      auth_fail_action = lookup(api_config.value, "auth_fail_action")
      login            = lookup(api_config.value, "login")
      security_level   = lookup(api_config.value, "security_level")
      url              = lookup(api_config.value, "url")
    }
  }

  dynamic "automatic_scaling" {
    for_each = lookup(var.flexible_app_version[count.index], "automatic_scaling") == null ? [] : ["automatic_scaling"]
    content {
      cool_down_period        = lookup(automatic_scaling.value, "cool_down_period")
      max_concurrent_requests = lookup(automatic_scaling.value, "max_concurrent_requests")
      max_idle_instances      = lookup(automatic_scaling.value, "max_idle_instances")
      max_pending_latency     = lookup(automatic_scaling.value, "max_pending_latency")
      max_total_instances     = lookup(automatic_scaling.value, "max_total_instances")
      min_idle_instances      = lookup(automatic_scaling.value, "min_idle_instances")
      min_pending_latency     = lookup(automatic_scaling.value, "min_pending_latency")
      min_total_instances     = lookup(automatic_scaling.value, "min_total_instances")

      dynamic "network_utilization" {
        for_each = lookup(automatic_scaling.value, "network_utilization") == null ? [] : ["network_utilization"]
        content {
          target_received_bytes_per_second   = lookup(network_utilization.value, "target_received_bytes_per_second")
          target_received_packets_per_second = lookup(network_utilization.value, "target_received_packets_per_second")
          target_sent_bytes_per_second       = lookup(network_utilization.value, "target_sent_bytes_per_second")
          target_sent_packets_per_second     = lookup(network_utilization.value, "target_sent_packets_per_second")
        }
      }
      dynamic "disk_utilization" {
        for_each = lookup(automatic_scaling.value, "disk_utilization") == null ? [] : ["disk_utilization"]
        content {
          target_read_bytes_per_second  = lookup(disk_utilization.value, "target_read_bytes_per_second")
          target_read_ops_per_second    = lookup(disk_utilization.value, "target_read_ops_per_second")
          target_write_bytes_per_second = lookup(disk_utilization.value, "target_write_bytes_per_second")
          target_write_ops_per_second   = lookup(disk_utilization.value, "target_write_ops_per_second")
        }
      }
      dynamic "request_utilization" {
        for_each = lookup(automatic_scaling.value, "request_utilization") == null ? [] : ["request_utilization"]
        content {
          target_concurrent_requests      = lookup(request_utilization.value, "target_concurrent_requests")
          target_request_count_per_second = lookup(request_utilization.value, "target_request_count_per_second")
        }
      }
      dynamic "cpu_utilization" {
        for_each = lookup(automatic_scaling.value, "cpu_utilization") == null ? [] : ["cpu_utilization"]
        content {
          target_utilization        = lookup(cpu_utilization.value, "target_utilization")
          aggregation_window_length = lookup(cpu_utilization.value, "aggregation_window_length")
        }
      }
    }
  }

  dynamic "endpoints_api_service" {
    for_each = lookup(var.flexible_app_version[count.index], "endpoints_api_service") == null ? [] : ["endpoints_api_service"]
    content {
      name                   = lookup(endpoints_api_service.value, "name")
      config_id              = lookup(endpoints_api_service.value, "config_id")
      rollout_strategy       = lookup(endpoints_api_service.value, "rollout_strategy")
      disable_trace_sampling = lookup(endpoints_api_service.value, "disable_trace_sampling")
    }
  }

  dynamic "entrypoint" {
    for_each = lookup(var.flexible_app_version[count.index], "entrypoint") == null ? [] : ["entrypoint"]
    content {
      shell = lookup(entrypoint.value, "sheel")
    }
  }

  dynamic "handlers" {
    for_each = lookup(var.flexible_app_version[count.index], "handlers") == null ? [] : ["handlers"]
    content {
      url_regex                   = lookup(handlers.value, "url_regex")
      security_level              = lookup(handlers.value, "security_level")
      login                       = lookup(handlers.value, "login")
      auth_fail_action            = lookup(handlers.value, "auth_fail_action")
      redirect_http_response_code = lookup(handlers.value, "redirect_http_response_code")

      dynamic "static_files" {
        for_each = lookup(handlers.value, "static_files") == null ? [] : ["static_files"]
        content {
          path                  = lookup(static_files.value, "path")
          upload_path_regex     = lookup(static_files.value, "upload_path_regex")
          http_headers          = lookup(static_files.value, "http_headers")
          mime_type             = lookup(static_files.value, "mime_type")
          expiration            = lookup(static_files.value, "expiration")
          require_matching_file = lookup(static_files.value, "require_matching_file")
          application_readable  = lookup(static_files.value, "application_readable")
        }
      }

      dynamic "script" {
        for_each = lookup(handlers.value, "script") == null ? [] : ["script"]
        content {
          script_path = lookup(script.value, "script_path")
        }
      }
    }
  }

  dynamic "liveness_check" {
    for_each = lookup(var.flexible_app_version[count.index], "liveness_check")
    content {
      path              = lookup(liveness_check.value, "path")
      host              = lookup(liveness_check.value, "host")
      failure_threshold = lookup(liveness_check.value, "failure_threshold")
      success_threshold = lookup(liveness_check.value, "success_threshold")
      check_interval    = lookup(liveness_check.value, "check_interval")
      timeout           = lookup(liveness_check.value, "timeout")
      initial_delay     = lookup(liveness_check.value, "initial_delay")
    }
  }

  dynamic "manual_scaling" {
    for_each = lookup(var.flexible_app_version[count.index], "manual_scaling") == null ? [] : ["manual_scaling"]
    content {
      instances = lookup(manual_scaling.value, "instances")
    }
  }

  dynamic "network" {
    for_each = lookup(var.flexible_app_version[count.index], "network") == null ? [] : ["network"]
    content {
      name             = lookup(network.value, "name")
      forwarded_ports  = lookup(network.value, "forwarded_ports")
      instance_tag     = lookup(network.value, "instance_tag")
      session_affinity = lookup(network.value, "session_affinity")
      subnetwork       = lookup(network.value, "subnetwork")
    }
  }

  dynamic "readiness_check" {
    for_each = lookup(var.flexible_app_version[count.index], "readiness_check")
    content {
      path              = lookup(readiness_check.value, "path")
      host              = lookup(readiness_check.value, "host")
      failure_threshold = lookup(readiness_check.value, "failure_threshold")
      success_threshold = lookup(readiness_check.value, "success_threshold")
      check_interval    = lookup(readiness_check.value, "check_interval")
      timeout           = lookup(readiness_check.value, "timeout")
      app_start_timeout = lookup(readiness_check.value, "app_start_timeout")
    }
  }

  dynamic "resources" {
    for_each = lookup(var.flexible_app_version[count.index], "resources") == null ? [] : ["resources"]
    content {
      cpu       = lookup(resources.value, "cpu")
      disk_gb   = lookup(resources.value, "disk_gb")
      memory_gb = lookup(resources.value, "memory_gb")

      dynamic "volumes" {
        for_each = lookup(resources.value, "volumes")
        content {
          name        = lookup(volumes.value, "name")
          size_gb     = lookup(volumes.value, "size_gb")
          volume_type = lookup(volumes.value, "volume_type")
        }
      }
    }
  }

  dynamic "vpc_access_connector" {
    for_each = lookup(var.flexible_app_version[count.index], "vpc_access_connector") == null ? [] : ["vpc_access_connector"]
    content {
      name = lookup(vpc_access_connector.value, "name")
    }
  }
}

resource "google_app_engine_service_network_settings" "this" {
  count = length(var.service_network_settings)
  service = try(
    element(google_app_engine_standard_app_version.this.*.service, lookup(var.service_network_settings[count.index], "service_id"))
  )
  project = data.google_project.this.number

  dynamic "network_settings" {
    for_each = lookup(var.service_network_settings[count.index], "network_settings") == null ? [] : ["network_settings"]
    content {
      ingress_traffic_allowed = lookup(network_settings.value, "ingress_traffic_allowed")
    }
  }
}

resource "google_app_engine_service_split_traffic" "this" {
  count = length(var.service_split_traffic)
  service = try(
    element(google_app_engine_standard_app_version.this.*.service, lookup(var.service_split_traffic[count.index], "service_id"))
  )
  project         = data.google_project.this.project_id
  migrate_traffic = lookup(var.service_split_traffic[count.index], "migrate_traffic")

  dynamic "split" {
    for_each = lookup(var.service_split_traffic[count.index], "split") == null ? [] : ["split"]
    content {
      allocations = lookup(split.value, "allocations")
      shard_by    = lookup(split.value, "shard_by")
    }
  }
}

resource "google_app_engine_standard_app_version" "this" {
  count                     = length(var.standard_app_version)
  runtime                   = lookup(var.standard_app_version[count.index], "runtime")
  service                   = lookup(var.standard_app_version[count.index], "service")
  project                   = data.google_project.this.project_id
  version_id                = lookup(var.standard_app_version[count.index], "version_id")
  threadsafe                = lookup(var.standard_app_version[count.index], "threadsafe")
  runtime_api_version       = lookup(var.standard_app_version[count.index], "runtime_api_version")
  env_variables             = lookup(var.standard_app_version[count.index], "env_variables")
  inbound_services          = lookup(var.standard_app_version[count.index], "inbound_services")
  instance_class            = lookup(var.standard_app_version[count.index], "instance_class")
  noop_on_destroy           = lookup(var.standard_app_version[count.index], "noop_on_destroy")
  delete_service_on_destroy = lookup(var.standard_app_version[count.index], "delete_service_on_destroy")

  dynamic "entrypoint" {
    for_each = lookup(var.standard_app_version[count.index], "entrypoint")
    content {
      shell = lookup(entrypoint.value, "shell")
    }
  }

  dynamic "deployment" {
    for_each = lookup(var.standard_app_version[count.index], "deployment") == null ? [] : ["deployment"]
    content {
      dynamic "zip" {
        for_each = lookup(deployment.value, "zip") == null ? [] : ["zip"]
        content {
          source_url  = lookup(zip.value, "source_url")
          files_count = lookup(zip.value, "files_count")
        }      
      }

      dynamic "files" {
        for_each = lookup(deployment.value, "files") == null ? [] : ["files"]
        content {
          name       = lookup(files.value, "name")
          source_url = lookup(files.value, "source_url")
          sha1_sum   = lookup(files.value, "sha1_sum")
        }
      }
    }
  }

  dynamic "handlers" {
    for_each = lookup(var.standard_app_version[count.index], "handlers") == null ? [] : ["handlers"]
    content {
      url_regex                   = lookup(handlers.value, "url_regex")
      security_level              = lookup(handlers.value, "security_level")
      login                       = lookup(handlers.value, "login")
      auth_fail_action            = lookup(handlers.value, "auth_fail_action")
      redirect_http_response_code = lookup(handlers.value, "redirect_http_response_code")

      dynamic "static_files" {
        for_each = lookup(handlers.value, "static_files") == null ? [] : ["static_files"]
        content {
          path                  = lookup(static_files.value, "path")
          upload_path_regex     = lookup(static_files.value, "upload_path_regex")
          http_headers          = lookup(static_files.value, "http_headers")
          mime_type             = lookup(static_files.value, "mime_type")
          expiration            = lookup(static_files.value, "expiration")
          require_matching_file = lookup(static_files.value, "require_matching_file")
          application_readable  = lookup(static_files.value, "application_readable")
        }
      }

      dynamic "script" {
        for_each = lookup(handlers.value, "script") == null ? [] : ["script"]
        content {
          script_path = lookup(script.value, "script_path")
        }
      }
    }
  }

  dynamic "libraries" {
    for_each = lookup(var.standard_app_version[count.index], "libraries") == null ? [] : ["libraries"]
    content {
      name    = lookup(libraries.value, "name")
      version = lookup(libraries.value, "version")
    }
  }

  dynamic "vpc_access_connector" {
    for_each = lookup(var.standard_app_version[count.index], "vpc_access_connector") == null ? [] : ["vpc_access_connector"]
    content {
      name = lookup(vpc_access_connector.value, "name")
    }
  }

  dynamic "automatic_scaling" {
    for_each = lookup(var.standard_app_version[count.index], "automatic_scaling") == null ? [] : ["automatic_scaling"]
    content {
      max_concurrent_requests = lookup(automatic_scaling.value, "max_concurrent_requests")
      max_idle_instances      = lookup(automatic_scaling.value, "max_idle_instances")
      max_pending_latency     = lookup(automatic_scaling.value, "max_pending_latency")
      min_idle_instances      = lookup(automatic_scaling.value, "min_idle_instances")
      min_pending_latency     = lookup(automatic_scaling.value, "min_pending_latency")

      dynamic "standard_scheduler_settings" {
        for_each = lookup(automatic_scaling.value, "standard_scheduler_settings") == null ? [] : ["standard_scheduler_settings"]
        content {
          target_cpu_utilization        = lookup(standard_scheduler_settings.value, "target_cpu_utilization")
          target_throughput_utilization = lookup(standard_scheduler_settings.value, "target_throughput_utilization")
          max_instances                 = lookup(standard_scheduler_settings.value, "max_instances")
          min_instances                 = lookup(standard_scheduler_settings.value, "min_instances")
        }
      }
    }
  }

  dynamic "basic_scaling" {
    for_each = lookup(var.standard_app_version[count.index], "basic_scaling") == null ? [] : ["basic_scaling"]
    content {
      max_instances = lookup(basic_scaling.value, "max_instances")
      idle_timeout  = lookup(basic_scaling.value, "idle_timeout")
    }
  }

  dynamic "manual_scaling" {
    for_each = lookup(var.standard_app_version[count.index], "manual_scaling") == null ? [] : ["manual_scaling"]
    content {
      instances = lookup(manual_scaling.value, "instances")
    }
  }
}