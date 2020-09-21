resource "google_app_engine_flexible_app_version" "flexible_app" {
  count   = ""
  runtime = ""
  version_id = ""
  inbound_services = []
  instance_class = ""
  env_variables = {}
  runtime_channel = ""
  runtime_api_version = ""
  runtime_main_executable_path = ""
  default_expiration = ""

  dynamic "api_config" {
    for_each = ""
    content {
      script = ""
      login = ""
      security_level = ""
      auth_fail_action = ""
      url = ""
    }
  }
  dynamic "deployment" {
    for_each = ""
    content {
      zip {
        source_url = ""
        files_count = ""
      }
      files {
        name = ""
        source_url = ""
        sha1_sum = ""
      }
      container {
        image = ""
      }
      cloud_build_options {
        app_yaml_path = ""
        cloud_build_timeout = ""
      }
    }
  }

  dynamic "liveness_check" {
    for_each = ""
    content {
      path              = ""
      host              = ""
      check_interval    = ""
      success_threshold = ""
      failure_threshold = ""
      timeout           = ""
      initial_delay     = ""
    }
  }

  dynamic "readiness_check" {
    for_each = ""
    content {
      path              = ""
      host              = ""
      check_interval    = ""
      failure_threshold = ""
      success_threshold = ""
      timeout           = ""
      app_start_timeout = ""
    }
  }

  dynamic "network" {
    for_each = ""
    content {
      forwarded_ports = []
      session_affinity = ""
      subnetwork = ""
      instance_tag = ""
      name = ""
    }
  }

  dynamic "resources" {
    for_each = ""
    content {
      cpu = ""
      disk_gb = ""
      memory_gb = ""

      dynamic "volumes" {
        for_each = ""
        content {
          name = ""
          size_gb = ""
          volume_type = ""
        }
      }
    }
  }

  dynamic "endpoints_api_service" {
    for_each = ""
    content {
      name = ""
      config_id = ""
      disable_trace_sampling = ""
      rollout_strategy = ""
    }
  }

  dynamic "entrypoint" {
    for_each = ""
    content {
      shell = ""
    }
  }

  dynamic "vpc_access_connector" {
    for_each = ""
    content {
      name = ""
    }
  }
}
