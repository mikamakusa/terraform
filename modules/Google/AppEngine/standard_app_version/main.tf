resource "google_app_engine_standard_app_version" "standard_app_version" {
  count                     = length(var.standard_app_version)
  runtime                   = lookup(var.standard_app_version[count.index], "runtime")
  version_id                = lookup(var.standard_app_version[count.index], "version_id", null)
  service                   = lookup(var.standard_app_version[count.index], "service", null)
  threadsafe                = lookup(var.standard_app_version[count.index], "threadsafe", null)
  runtime_api_version       = lookup(var.standard_app_version[count.index], "runtime_api_version", null)
  env_variables             = lookup(var.standard_app_version[count.index], "env_variables", {})
  instance_class            = lookup(var.standard_app_version[count.index], "instance_class", null)
  project                   = var.project
  noop_on_destroy           = lookup(var.standard_app_version[count.index], "noop_on_destroy", true)
  delete_service_on_destroy = lookup(var.standard_app_version[count.index], "delete_service_on_destroy", true)

  dynamic "deployment" {
    for_each = lookup(var.standard_app_version[count.index], "deployment") == null ? [] : [for i in lookup(var.standard_app_version[count.index], "deployment") : {
      zip   = lookup(i, "zip")
      files = lookup(i, "files", null)
    }]
    content {
      dynamic "zip" {
        for_each = [for i in deployment.value.zip : {
          url   = i.source_url
        }]
        content {
          source_url  = join("/", ["https://storage.googleapis.com/", var.bucket, zip.value.url])
        }
      }
      dynamic "files" {
        for_each = [for i in deployment.value.files : {
          name       = i.name
          source_url = i.source_url
          sha1       = i.sha1_sum
        }]
        content {
          name       = files.value.name
          source_url = files.value.source_url
          sha1_sum   = files.value.sha1
        }
      }
    }
  }

  dynamic "entrypoint" {
    for_each = lookup(var.standard_app_version[count.index], "entrypoint")
    content {
      shell = lookup(entrypoint.value, "shell")
    }
  }

  dynamic "automatic_scaling" {
    for_each = lookup(var.standard_app_version[count.index], "automatic_scaling") == null ? [] : [for i in lookup(var.standard_app_version[count.index], "automatic_scaling") : {
      max_concurrent_requests     = i.max_concurrent_requests
      max_idle_instances          = i.max_idle_instances
      max_pending_latency         = i.max_pending_latency
      min_pending_latency         = i.min_pending_latency
      standard_scheduler_settings = lookup(i, "standard_scheduler_settings", null)
    }]
    content {
      max_concurrent_requests = automatic_scaling.value.max_concurrent_requests
      max_idle_instances      = automatic_scaling.value.max_idle_instances
      max_pending_latency     = automatic_scaling.value.max_pending_latency
      min_idle_instances      = automatic_scaling.value.min_idle_instances
      min_pending_latency     = automatic_scaling.value.min_pending_latency
      dynamic "standard_scheduler_settings" {
        for_each = automatic_scaling.value.standard_scheduler_settings == null ? [] : [for i in automatic_scaling.value.standard_scheduler_settings : {
          target_cpu_utilization        = i.target_cpu_utilization
          target_throughput_utilization = i.target_throughput_utilization
          max_instances                 = i.max_instances
          min_instances                 = i.min_instances
        }]
        content {
          target_cpu_utilization        = standard_scheduler_settings.value.target_cpu_utilization
          target_throughput_utilization = standard_scheduler_settings.value.target_throughput_utilization
          max_instances                 = standard_scheduler_settings.value.max_instances
          min_instances                 = standard_scheduler_settings.value.min_instances
        }
      }
    }
  }

  dynamic "basic_scaling" {
    for_each = lookup(var.standard_app_version[count.index], "automatic_scaling") != null ? [] : lookup(var.standard_app_version[count.index], "basic_scaling")
    content {
      idle_timeout  = lookup(basic_scaling.value, "idle_timeout")
      max_instances = lookup(basic_scaling.value, "max_instances")
    }
  }

  dynamic "manual_scaling" {
    for_each = lookup(var.standard_app_version[count.index], "automatic_scaling") != null ? [] : lookup(var.standard_app_version[count.index], "manual_scaling")
    content {
      instances = lookup(manual_scaling.value, "instances")
    }
  }

  dynamic "libraries" {
    for_each = lookup(var.standard_app_version[count.index], "libraries")
    content {
      name    = lookup(libraries.value, "name")
      version = lookup(libraries.value, "version")
    }
  }

  dynamic "handlers" {
    for_each = lookup(var.standard_app_version[count.index], "handlers") == null ? [] : [for i in lookup(var.standard_app_version[count.index], "handlers") : {
      url_regex                   = i.url_regex
      security_level              = i.security_level
      login                       = i.login
      auth_fail_action            = i.auth_fail_action
      redirect_http_response_code = i.redirect_http_response_code
      script                      = lookup(i, "script", null)
      static_files                = lookup(i, "static_files", null)
    }]
    content {
      url_regex                   = handlers.value.url_regex
      security_level              = handlers.value.security_level
      login                       = handlers.value.login
      auth_fail_action            = handlers.value.auth_fail_action
      redirect_http_response_code = handlers.value.redirect_http_response_code

      dynamic "script" {
        for_each = handlers.value.script == null ? [] : [for i in handlers.value.script : {
          script_path = i.script_path
        }]
        content {
          script_path = script.value.script_path
        }
      }
      dynamic "static_files" {
        for_each = handlers.value.static_files == null ? [] : [for i in handlers.value.static_files : {
          path                  = i.path
          upload_path_regex     = i.upload_path_regex
          http_headers          = i.http_headers
          mime_type             = i.mime_type
          expiration            = i.expiration
          application_readable  = i.application_readable
          require_matching_file = i.require_matching_file
        }]
        content {
          path                  = static_files.value.path
          upload_path_regex     = static_files.value.upload_path_regex
          http_headers          = static_files.value.http_headers
          mime_type             = static_files.value.mime_type
          expiration            = static_files.value.expiration
          application_readable  = static_files.value.application_readable
          require_matching_file = static_files.value.require_matching_file
        }
      }
    }
  }
}
