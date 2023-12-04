variable "resource_group_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "app_service" {
  type = list(map(object({
    id                              = number
    app_service_plan_id             = any
    name                            = string
    app_settings                    = optional(map(string))
    client_affinity_enabled         = optional(bool)
    client_cert_enabled             = optional(bool)
    client_cert_mode                = optional(string)
    enabled                         = optional(bool)
    https_only                      = optional(bool)
    key_vault_reference_identity_id = optional(string)
    tags                            = optional(map(string))
    storage_account = optional(list(object({
      access_key   = string
      account_name = string
      name         = string
      share_name   = string
      type         = string
      mount_path   = optional(string)
    })), [])
    connection_string = optional(list(object({
      name  = string
      type  = string
      value = string
    })), [])
    identity = optional(list(object({
      type         = string
      identity_ids = optional(list(string))
    })), {})
    logs = optional(list(object({
      detailed_error_messages_enabled = optional(bool)
      failed_request_tracing_enabled  = optional(bool)
      application_logs = optional(list(object({
        file_system_level = optional(string)
        azure_blob_storage = optional(list(object({
          level             = string
          retention_in_days = number
          sas_url           = string
        })), [])
      })), [])
      http_logs = optional(list(object({
        file_system = optional(list(object({
          retention_in_days = number
          retention_in_mb   = number
        })), [])
        azure_blob_storage = optional(list(object({
          retention_in_days = number
          sas_url           = string
          level             = optional(string)
        })), [])
      })), [])
    })), [])
    auth_settings = optional(list(object({
      enabled                        = bool
      additional_login_params        = optional(map(string))
      allowed_external_redirect_urls = optional(list(string))
      default_provider               = optional(string)
      issuer                         = optional(string)
      runtime_version                = optional(string)
      token_refresh_extension_hours  = optional(number)
      token_store_enabled            = optional(bool)
      unauthenticated_client_action  = optional(string)
      twitter = optional(list(object({
        consumer_key    = string
        consumer_secret = string
      })), [])
      microsoft = optional(list(object({
        client_id     = string
        client_secret = string
        oauth_scopes  = optional(list(string))
      })), [])
      facebook = optional(list(object({
        app_id       = string
        app_secret   = string
        oauth_scopes = optional(list(string))
      })), [])
      google = optional(list(object({
        client_id     = string
        client_secret = string
        oauth_scopes  = optional(list(string))
      })), [])
      active_directory = optional(list(object({
        client_id         = string
        client_secret     = optional(string)
        allowed_audiences = optional(list(string))
      })), [])
    })), [])
    backup = optional(list(object({
      name                = string
      storage_account_url = string
      enabled             = optional(bool)
      schedule = optional(list(object({
        frequency_interval       = number
        frequency_unit           = string
        keep_at_least_one_backup = optional(bool)
        retention_period_in_days = optional(number)
        start_time               = optional(string)
      })), [])
    })), [])
    site_config = optional(list(object({
      acr_use_managed_identity_credentials = optional(bool)
      acr_user_managed_identity_client_id  = optional(string)
      always_on                            = optional(bool)
      app_command_line                     = optional(string)
      auto_swap_slot_name                  = optional(string)
      default_documents                    = optional(list(string))
      dotnet_framework_version             = optional(string)
      ftps_state                           = optional(string)
      health_check_path                    = optional(string)
      number_of_workers                    = optional(number)
      http2_enabled                        = optional(bool)
      java_version                         = optional(string)
      java_container_version               = optional(string)
      local_mysql_enabled                  = optional(bool)
      linux_fx_version                     = optional(string)
      windows_fx_version                   = optional(string)
      managed_pipeline_mode                = optional(string)
      min_tls_version                      = optional(string)
      php_version                          = optional(string)
      python_version                       = optional(string)
      remote_debugging_enabled             = optional(bool)
      remote_debugging_version             = optional(string)
      scm_type                             = optional(string)
      use_32_bit_worker_process            = optional(bool)
      vnet_route_all_enabled               = optional(bool)
      websockets_enabled                   = optional(bool)
      scm_ip_restriction = optional(list(object({
        ip_address                = optional(string)
        action                    = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        headers                   = optional(list(string))
      })), [])
      ip_restriction = optional(list(object({
        ip_address                = optional(string)
        action                    = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        headers                   = optional(list(string))
      })), [])
      cors = optional(list(object({
        allowed_origins     = list(string)
        support_credentials = optional(bool)
      })), [])
    })), [])
    source_control = optional(list(object({
      repo_url           = optional(string)
      branch             = optional(string)
      manual_integration = optional(bool)
      rollback_enabled   = optional(bool)
      use_mercurial      = optional(bool)
    })), [])
  })))
  default = []
}

variable "app_service_active_slot" {
  type = list(map(object({
    id                  = number
    app_service_id      = any
    app_service_slot_id = any
  })))
  default = []
}

variable "app_service_certificate" {
  type = list(map(object({
    id                  = number
    name                = string
    pfx_blob            = optional(string)
    password            = optional(string)
    app_service_plan_id = optional(any)
    key_vault_secret_id = optional(any)
    tags                = optional(map(string))
  })))
  default = []
}

variable "app_service_certificate_binding" {
  type = list(map(object({
    id                  = number
    certificate_id      = any
    hostname_binding_id = any
    ssl_state           = string
  })))
  default = []
}

variable "app_service_certificate_order" {
  type = list(map(object({
    id                 = number
    name               = string
    auto_renew         = optional(bool)
    csr                = optional(string)
    distinguished_name = optional(string)
    key_size           = optional(number)
    product_type       = optional(string)
    validity_in_years  = optional(bool)
  })))
  default = []
}

variable "app_service_connection" {
  type = list(map(object({
    id                 = number
    app_service_id     = any
    name               = string
    target_resource_id = any
    authentication = optional(list(object({
      type            = string
      name            = optional(string)
      secret          = optional(string)
      client_id       = optional(string)
      subscription_id = optional(string)
      principal_id    = optional(string)
      certificate     = optional(string)
      client_type     = optional(string)
      vnet_solution   = optional(string)
      secret_store = optional(list(object({
        secret_store = optional(string)
      })), [])
    })), [])
  })))
  default = []
}

variable "app_service_custom_hostname_binding" {
  type = list(map(object({
    id             = number
    app_service_id = any
    hostname       = string
    ssl_state      = optional(string)
    thumbprint     = optional(string)
  })))
  default = []
}

variable "app_service_environment" {
  type = list(map(object({
    id                           = number
    name                         = string
    subnet_id                    = any
    internal_load_balancing_mode = optional(string)
    pricing_tier                 = optional(string)
    front_end_scale_factor       = optional(number)
    allowed_user_ip_cidrs        = optional(list(string))
    tags                         = optional(map(string))
    cluster_setting = optional(list(object({
      name  = string
      value = string
    })), [])
  })))
  default = []
}

variable "app_service_environment_v3" {
  type = list(map(object({
    id                                     = number
    name                                   = string
    subnet_id                              = any
    allow_new_private_endpoint_connections = optional(bool)
    dedicated_host_count                   = optional(number)
    zone_redundant                         = optional(bool)
    internal_load_balancing_mode           = optional(string)
    tags                                   = optional(map(string))
    cluster_setting = optional(list(object({
      name  = string
      value = string
    })), [])
  })))
  default = []
}

variable "app_service_hybrid_connection" {
  type = list(map(object({
    id             = number
    app_service_id = any
    hostname       = string
    port           = number
    relay_id       = any
    send_key_name  = optional(string)
  })))
  default = []
}

variable "app_service_managed_certificate" {
  type = list(map(object({
    id                         = number
    custom_hostname_binding_id = any
    tags                       = optional(map(string))
  })))
  default = []
}

variable "app_service_plan" {
  type = list(map(object({
    id                           = number
    name                         = string
    kind                         = optional(string)
    maximum_elastic_worker_count = optional(number)
    reserved                     = optional(bool)
    per_site_scaling             = optional(bool)
    is_xenon                     = optional(bool)
    zone_redundant               = optional(bool)
    tags                         = optional(map(string))
    sku = optional(list(object({
      size     = string
      tier     = string
      capacity = optional(number)
    })), [])
  })))
  default = []
}

variable "app_service_public_certificate" {
  type = list(map(object({
    id                   = number
    app_service_id       = any
    blob                 = string
    certificate_location = string
    certificate_name     = string
  })))
  default = []
}

variable "app_service_slot" {
  type = list(map(object({
    id                              = number
    app_service_id                  = any
    app_service_plan_id             = any
    name                            = string
    app_settings                    = optional(map(string))
    client_affinity_enabled         = optional(bool)
    enabled                         = optional(bool)
    https_only                      = optional(bool)
    key_vault_reference_identity_id = optional(string)
    tags                            = optional(map(string))
    auth_settings = optional(list(object({
      enabled                        = bool
      additional_login_params        = optional(map(string))
      allowed_external_redirect_urls = optional(list(string))
      default_provider               = optional(string)
      runtime_version                = optional(string)
      token_refresh_extension_hours  = optional(number)
      token_store_enabled            = optional(bool)
      unauthenticated_client_action  = optional(string)
      active_directory = optional(list(object({
        client_id         = string
        client_secret     = optional(string)
        allowed_audiences = optional(list(string))
      })), [])
      facebook = optional(list(object({
        app_id       = string
        app_secret   = string
        oauth_scopes = optional(list(string))
      })), [])
      microsoft = optional(list(object({
        client_id     = string
        client_secret = string
        oauth_scopes  = optional(list(string))
      })), [])
      google = optional(list(object({
        client_id     = string
        client_secret = string
        oauth_scopes  = optional(list(string))
      })), [])
      twitter = optional(list(object({
        consumer_key    = string
        consumer_secret = string
      })), [])
    })), [])
    connection_string = optional(list(object({
      name  = string
      type  = string
      value = string
    })), [])
    site_config = optional(list(object({
      acr_use_managed_identity_credentials = optional(bool)
      acr_user_managed_identity_client_id  = optional(string)
      always_on                            = optional(bool)
      app_command_line                     = optional(string)
      auto_swap_slot_name                  = optional(string)
      default_documents                    = optional(list(string))
      dotnet_framework_version             = optional(string)
      ftps_state                           = optional(string)
      health_check_path                    = optional(string)
      number_of_workers                    = optional(number)
      http2_enabled                        = optional(bool)
      scm_use_main_ip_restriction          = optional(bool)
      java_container                       = optional(string)
      java_container_version               = optional(string)
      java_version                         = optional(string)
      local_mysql_enabled                  = optional(bool)
      linux_fx_version                     = optional(string)
      windows_fx_version                   = optional(string)
      managed_pipeline_mode                = optional(string)
      min_tls_version                      = optional(string)
      php_version                          = optional(string)
      python_version                       = optional(string)
      remote_debugging_enabled             = optional(bool)
      remote_debugging_version             = optional(string)
      scm_type                             = optional(string)
      use_32_bit_worker_process            = optional(bool)
      vnet_route_all_enabled               = optional(bool)
      websockets_enabled                   = optional(bool)
      cors = optional(list(object({
        allowed_origins     = list(string)
        support_credentials = optional(bool)
      })), [])
      ip_restriction = optional(list(object({
        ip_address                = optional(string)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        action                    = optional(string)
        headers                   = optional(list(string))
      })), [])
      scm_ip_restriction = optional(list(object({
        ip_address                = optional(string)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        action                    = optional(string)
        headers                   = optional(list(string))
      })), [])
    })), [])
    storage_account = optional(list(object({
      access_key   = string
      account_name = string
      name         = string
      share_name   = string
      type         = string
      mount_path   = optional(string)
    })), [])
    logs = optional(list(object({
      detailed_error_messages_enabled = optional(bool)
      failed_request_tracing_enabled  = optional(bool)
      http_logs = optional(list(object({
        file_system = optional(list(object({
          retention_in_days = number
          retention_in_mb   = number
        })), [])
        azure_blob_storage = optional(list(object({
          retention_in_days = number
          sas_url           = string
          level             = optional(string)
        })), [])
      })), [])
      application_logs = optional(list(object({
        file_system_level = optional(string)
        azure_blob_storage = optional(list(object({
          retention_in_days = number
          sas_url           = string
          level             = optional(string)
        })), [])
      })), [])
    })), [])
    identity = optional(list(object({
      type         = string
      identity_ids = optional(list(string))
    })), [])
  })))
  default = []
}

variable "app_service_slot_custom_hostname_binding" {
  type = list(map(object({
    id                  = number
    app_service_slot_id = any
    hostname            = string
    ssl_state           = optional(string)
    thumbprint          = optional(string)
  })))
  default = []
}

variable "app_service_slot_virtual_network_swift_connection" {
  type = list(map(object({
    id             = number
    app_service_id = any
    slot_id        = any
    subnet_id      = any
  })))
  default = []
}

variable "app_service_source_control" {
  type = list(map(object({
    id                     = number
    app_id                 = any
    branch                 = optional(string)
    repo_url               = optional(string)
    use_manual_integration = optional(bool)
    rollback_enabled       = optional(bool)
    use_local_git          = optional(bool)
    use_mercurial          = optional(bool)
    github_action_configuration = optional(list(object({
      generate_workflow_file = optional(bool)
      code_configuration = optional(list(object({
        runtime_stack   = string
        runtime_version = string
      })), [])
      container_configuration = optional(list(object({
        image_name        = string
        registry_url      = string
        registry_password = optional(string)
        registry_username = optional(string)
      })), [])
    })), [])
  })))
  default = []
}

variable "app_service_source_control_slot" {
  type = list(map(object({
    id                     = number
    slot_id                = any
    branch                 = optional(string)
    repo_url               = optional(string)
    use_manual_integration = optional(bool)
    rollback_enabled       = optional(bool)
    use_local_git          = optional(bool)
    use_mercurial          = optional(bool)
    github_action_configuration = optional(list(object({
      generate_workflow_file = optional(bool)
      code_configuration = optional(list(object({
        runtime_stack   = string
        runtime_version = string
      })), [])
      container_configuration = optional(list(object({
        image_name        = string
        registry_url      = string
        registry_password = optional(string)
        registry_username = optional(string)
      })), [])
    })), [])
  })))
  default = []
}

variable "app_service_source_control_token" {
  type = list(map(object({
    id             = number
    app_service_id = any
    subnet_id      = any
    token_secret   = optional(string)
  })))
  default = []
}

variable "function_app" {
  type = list(map(object({
    id                              = number
    app_service_plan_id             = any
    name                            = string
    storage_account_access_key      = any
    storage_account_name            = any
    app_settings                    = optional(map(string))
    client_cert_mode                = optional(string)
    daily_memory_time_quota         = optional(number)
    enabled                         = optional(bool)
    enable_builtin_logging          = optional(bool)
    https_only                      = optional(bool)
    key_vault_reference_identity_id = optional(string)
    os_type                         = optional(string)
    version                         = optional(string)
    tags                            = optional(map(string))
    auth_settings = optional(list(object({
      enabled                        = optional(bool)
      additional_login_params        = optional(map(string))
      allowed_external_redirect_urls = optional(list(string))
      default_provider               = optional(string)
      unauthenticated_client_action  = optional(string)
      issuer                         = optional(string)
      runtime_version                = optional(string)
      token_refresh_extension_hours  = optional(number)
      token_store_enabled            = optional(map(string))
      active_directory = optional(list(object({
        client_id         = string
        client_secret     = optional(string)
        allowed_audiences = optional(list(string))
      })), optional(list(string)))
      facebook = optional(list(object({
        app_id       = string
        app_secret   = string
        oauth_scopes = optional(list(string))
      })), optional(list(string)))
      microsoft = optional(list(object({
        client_id     = string
        client_secret = string
        oauth_scopes  = optional(list(string))
      })), optional(list(string)))
      google = optional(list(object({
        client_id     = string
        client_secret = string
        oauth_scopes  = optional(list(string))
      })), optional(list(string)))
      twitter = optional(list(object({
        consumer_key    = string
        consumer_secret = string
      })), [])
    })), [])
    connection_string = optional(list(object({
      name  = string
      type  = string
      value = string
    })), [])
    identity = optional(list(object({
      type         = string
      identity_ids = optional(list(string))
    })), [])
    site_config = optional(list(object({
      always_on                   = optional(bool)
      app_scale_limit             = optional(number)
      dotnet_framework_version    = optional(string)
      elastic_instance_minimum    = optional(number)
      ftps_state                  = optional(string)
      health_check_path           = optional(string)
      http2_enabled               = optional(bool)
      java_version                = optional(string)
      linux_fx_version            = optional(string)
      min_tls_version             = optional(string)
      pre_warmed_instance_count   = optional(number)
      scm_type                    = optional(string)
      scm_use_main_ip_restriction = optional(bool)
      use_32_bit_worker_process   = optional(bool)
      vnet_route_all_enabled      = optional(bool)
      websockets_enabled          = optional(bool)
      auto_swap_slot_name         = optional(string)
      cors = optional(list(object({
        allowed_origins     = list(string)
        support_credentials = optional(bool)
      })), [])
      ip_restriction = optional(list(object({
        ip_address                = optional(string)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        action                    = optional(string)
        headers                   = optional(list(string))
      })), [])
      scm_ip_restriction = optional(list(object({
        ip_address                = optional(string)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        action                    = optional(string)
        headers                   = optional(list(string))
      })))
    })), [])
    source_control = optional(list(object({
      repo_url           = optional(string)
      branch             = optional(string)
      manual_integration = optional(bool)
      rollback_enabled   = optional(bool)
      use_mercurial      = optional(bool)
    })), [])
  })))
  default = []
}

variable "function_app_active_slot" {
  type = list(map(object({
    id      = number
    slot_id = any
  })))
  default = []
}

variable "function_app_connection" {
  type = list(map(object({
    id                 = number
    name               = string
    function_app_id    = any
    target_resource_id = any
  })))
  default = []
}

variable "function_app_function" {
  type = list(map(object({
    id              = number
    config_json     = string
    function_app_id = any
    name            = string
    enabled         = optional(bool)
    language        = optional(string)
    test_data       = optional(string)
    file = optional(list(object({
      content = string
      name    = string
    })), [])
  })))
  default = []
}

variable "function_app_hybrid_connection" {
  type = list(map(object({
    id              = number
    function_app_id = any
    hostname        = string
    port            = number
    relay_id        = any
    send_key_name   = optional(string)
  })))
  default = []
}

variable "function_app_slot" {
  type = list(map(object({
    id                         = number
    app_service_plan_id        = any
    function_app_ud            = any
    name                       = string
    storage_account_access_key = any
    storage_account_name       = any
    app_settings               = optional(map(string))
    enable_builtin_logging     = optional(bool)
    os_type                    = optional(string)
    enabled                    = optional(bool)
    https_only                 = optional(bool)
    version                    = optional(string)
    daily_memory_time_quota    = optional(number)
    tags                       = optional(map(string))
    auth_settings = optional(list(object({
      enabled                        = optional(bool)
      additional_login_params        = optional(map(string))
      allowed_external_redirect_urls = optional(list(string))
      default_provider               = optional(string)
      unauthenticated_client_action  = optional(string)
      issuer                         = optional(string)
      runtime_version                = optional(string)
      token_refresh_extension_hours  = optional(number)
      token_store_enabled            = optional(map(string))
      active_directory = optional(list(object({
        client_id         = string
        client_secret     = optional(string)
        allowed_audiences = optional(list(string))
      })), optional(list(string)))
      facebook = optional(list(object({
        app_id       = string
        app_secret   = string
        oauth_scopes = optional(list(string))
      })), optional(list(string)))
      microsoft = optional(list(object({
        client_id     = string
        client_secret = string
        oauth_scopes  = optional(list(string))
      })), optional(list(string)))
      google = optional(list(object({
        client_id     = string
        client_secret = string
        oauth_scopes  = optional(list(string))
      })), optional(list(string)))
      twitter = optional(list(object({
        consumer_key    = string
        consumer_secret = string
      })), [])
    })), [])
    connection_string = optional(list(object({
      name  = string
      type  = string
      value = string
    })), [])
    identity = optional(list(object({
      type         = string
      identity_ids = optional(list(string))
    })))
    site_config = optional(list(object({
      always_on                        = optional(bool)
      use_32_bit_worker_process        = optional(bool)
      scm_use_main_ip_restriction      = optional(bool)
      websockets_enabled               = optional(bool)
      http2_enabled                    = optional(bool)
      runtime_scale_monitoring_enabled = optional(bool)
      linux_fx_version                 = optional(string)
      java_version                     = optional(string)
      min_tls_version                  = optional(string)
      ftps_state                       = optional(string)
      health_check_path                = optional(string)
      scm_type                         = optional(string)
      dotnet_framework_version         = optional(string)
      app_scale_limit                  = optional(number)
      elastic_instance_minimum         = optional(number)
      pre_warmed_instance_count        = optional(number)
      cors = optional(list(object({
        allowed_origins     = list(string)
        support_credentials = optional(bool)
      })), [])
      ip_restriction = optional(list(object({
        ip_address                = optional(string)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        action                    = optional(string)
        headers                   = optional(list(string))
      })), [])
      scm_ip_restriction = optional(list(object({
        ip_address                = optional(string)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        action                    = optional(string)
        headers                   = optional(list(string))
      })))
    })), [])
  })))
  default = []
}

variable "linux_function_app" {
  type = list(map(object({
    id                                             = number
    name                                           = string
    service_plan_id                                = any
    builtin_logging_enabled                        = optional(bool)
    client_certificate_enabled                     = optional(bool)
    enabled                                        = optional(bool)
    content_share_force_disabled                   = optional(bool)
    ftp_publish_basic_authentication_enabled       = optional(bool)
    https_only                                     = optional(bool)
    public_network_access_enabled                  = optional(bool)
    storage_uses_managed_identity                  = optional(bool)
    webdeploy_publish_basic_authentication_enabled = optional(bool)
    client_certificate_exclusion_paths             = optional(string)
    client_certificate_mode                        = optional(string)
    functions_extension_version                    = optional(string)
    key_vault_reference_identity_id                = optional(string)
    storage_account_access_key                     = optional(string)
    storage_account_name                           = optional(string)
    storage_key_vault_secret_id                    = optional(string)
    virtual_network_subnet_id                      = optional(string)
    zip_deploy_file                                = optional(string)
    daily_memory_time_quota                        = optional(number)
    app_settings                                   = optional(map(string))
    tags                                           = optional(map(string))
    auth_settings = optional(list(object({
      enabled                        = bool
      token_store_enabled            = optional(bool)
      additional_login_parameters    = optional(map(string))
      allowed_external_redirect_urls = optional(list(string))
      default_provider               = optional(string)
      issuer                         = optional(string)
      runtime_version                = optional(string)
      unauthenticated_client_action  = optional(string)
      token_refresh_extension_hours  = optional(number)
      facebook = optional(list(object({
        app_id                  = string
        app_secret              = optional(string)
        app_secret_setting_name = optional(string)
        oauth_scopes            = optional(list(string))
      })), [])
      github = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      google = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      microsoft = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      twitter = optional(list(object({
        consumer_key                 = string
        consumer_secret              = optional(string)
        consumer_secret_setting_name = optional(string)
      })), [])
      active_directory = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        allowed_audiences          = optional(list(string))
      })), [])
    })), [])
    auth_settings_v2 = optional(list(object({
      auth_enabled                            = optional(bool)
      require_authentication                  = optional(bool)
      require_https                           = optional(bool)
      runtime_version                         = optional(string)
      config_file_path                        = optional(string)
      unauthenticated_action                  = optional(string)
      default_provider                        = optional(string)
      http_route_api_prefix                   = optional(string)
      forward_proxy_convention                = optional(string)
      forward_proxy_custom_host_header_name   = optional(string)
      forward_proxy_custom_scheme_header_name = optional(string)
      excluded_paths                          = optional(list(string))
      apple_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      })), [])
      active_directory_v2 = optional(list(object({
        client_id                            = string
        tenant_auth_endpoint                 = string
        client_secret_setting_name           = ""
        client_secret_certificate_thumbprint = optional(string)
        jwt_allowed_groups                   = optional(list(string))
        jwt_allowed_client_applications      = optional(list(string))
        allowed_groups                       = optional(list(string))
        allowed_audiences                    = optional(list(string))
        allowed_applications                 = optional(list(string))
        login_parameters                     = optional(map(string))
        www_authentication_disabled          = optional(bool)
      })), [])
      azure_static_web_app_v2 = optional(list(object({
        client_id = string
      })), [])
      custom_oidc_v2 = optional(list(object({
        client_id                     = string
        name                          = string
        openid_configuration_endpoint = string
        name_claim_type               = optional(string)
        scopes                        = optional(list(string))
        client_credential_method      = optional(string)
        client_secret_setting_name    = optional(string)
        authorisation_endpoint        = optional(string)
        token_endpoint                = optional(string)
        issuer_endpoint               = optional(string)
        certification_uri             = optional(string)
      })), [])
      facebook_v2 = optional(list(object({
        app_id                  = string
        app_secret_setting_name = string
        graph_api_version       = optional(string)
        login_scopes            = optional(list(string))
      })), [])
      github_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      })), [])
      google_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        allowed_audiences          = optional(list(string))
        login_scopes               = optional(list(string))
      })), [])
      microsoft_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        allowed_audiences          = optional(list(string))
        login_scopes               = optional(list(string))
      })), [])
      twitter_v2 = optional(list(object({
        consumer_key                 = string
        consumer_secret_setting_name = string
      })), [])
      login = optional(list(object({
        logout_endpoint                   = string
        token_store_path                  = optional(string)
        token_store_sas_setting_name      = optional(string)
        cookie_expiration_convention      = optional(string)
        cookie_expiration_time            = optional(string)
        nonce_expiration_time             = optional(string)
        validate_nonce                    = optional(bool)
        preserve_url_fragments_for_logins = optional(bool)
        token_store_enabled               = optional(bool)
        token_refresh_extension_time      = optional(number)
      })), [])
    })), [])
    backup = optional(list(object({
      name                = string
      storage_account_url = string
      enabled             = optional(bool)
      schedule = optional(list(object({
        frequency_interval = number
        frequency_unit     = string
      })), [])
    })), [])
    connection_string = optional(list(object({
      name  = string
      type  = string
      value = string
    })), [])
    identity = optional(list(object({
      type         = string
      identity_ids = optional(list(string))
    })), [])
    storage_account = optional(list(object({
      access_key   = string
      account_name = string
      name         = string
      share_name   = string
      type         = string
      mount_path   = optional(string)
    })), [])
    sticky_settings = optional(list(object({
      app_setting_names       = list(string)
      connection_string_names = optional(list(string))
    })), [])
    site_config = list(object({
      always_on                                     = bool
      container_registry_use_managed_identity       = optional(bool)
      http2_enabled                                 = optional(bool)
      scm_use_main_ip_restriction                   = optional(bool)
      runtime_scale_monitoring_enabled              = optional(bool)
      remote_debugging_enabled                      = optional(bool)
      use_32_bit_worker                             = optional(bool)
      vnet_route_all_enabled                        = optional(bool)
      websockets_enabled                            = optional(bool)
      remote_debugging_version                      = optional(string)
      scm_minimum_tls_version                       = optional(string)
      api_definition_url                            = optional(string)
      api_management_api_id                         = optional(string)
      application_insights_connection_string        = optional(string)
      application_insights_key                      = optional(string)
      app_command_line                              = optional(string)
      container_registry_managed_identity_client_id = optional(string)
      ftps_state                                    = optional(string)
      health_check_path                             = optional(string)
      managed_pipeline_mode                         = optional(string)
      default_documents                             = optional(list(string))
      elastic_instance_minimum                      = optional(number)
      app_scale_limit                               = optional(number)
      health_check_eviction_time_in_min             = optional(number)
      pre_warmed_instance_count                     = optional(number)
      worker_count                                  = optional(number)
      application_stack = optional(list(object({
        dotnet_version              = optional(string)
        java_version                = optional(string)
        node_version                = optional(string)
        python_version              = optional(string)
        powershell_core_version     = optional(string)
        use_dotnet_isolated_runtime = optional(bool)
        docker = optional(list(object({
          image_name        = string
          image_tag         = string
          registry_url      = string
          registry_password = optional(string)
          registry_username = optional(string)
        })), [])
      })), [])
      app_service_logs = optional(list(object({
        disk_quota_mb         = optional(number)
        retention_period_days = optional(number)
      })), [])
      cors = optional(list(object({
        allowed_origins     = optional(list(string))
        support_credentials = optional(bool)
      })), [])
      ip_restriction = optional(list(object({
        action                    = optional(string)
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        headers = optional(list(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(list(string))
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        })), {})
      })), optional(list(string)))
      scm_ip_restriction = optional(list(object({
        action                    = optional(string)
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        headers = optional(list(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(list(string))
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        })), {})
      })), [])
    }))
  })))
  default = []
}

variable "linux_function_app_slot" {
  type = list(map(object({
    id                                             = number
    function_app_id                                = any
    name                                           = string
    client_certificate_mode                        = optional(string)
    client_certificate_exclusion_paths             = optional(string)
    functions_extension_version                    = optional(string)
    key_vault_reference_identity_id                = optional(string)
    service_plan_id                                = optional(string)
    storage_account_access_key                     = optional(string)
    storage_account_name                           = optional(string)
    storage_key_vault_secret_id                    = optional(string)
    virtual_network_subnet_id                      = optional(string)
    app_settings                                   = optional(map(string))
    tags                                           = optional(map(string))
    daily_memory_time_quota                        = number
    builtin_logging_enabled                        = optional(bool)
    content_share_force_disabled                   = optional(bool)
    enabled                                        = optional(bool)
    ftp_publish_basic_authentication_enabled       = optional(bool)
    https_only                                     = optional(bool)
    public_network_access_enabled                  = optional(bool)
    storage_uses_managed_identity                  = optional(bool)
    webdeploy_publish_basic_authentication_enabled = optional(bool)
    site_config = list(object({
      always_on                                     = bool
      container_registry_use_managed_identity       = optional(bool)
      http2_enabled                                 = optional(bool)
      scm_use_main_ip_restriction                   = optional(bool)
      runtime_scale_monitoring_enabled              = optional(bool)
      remote_debugging_enabled                      = optional(bool)
      use_32_bit_worker                             = optional(bool)
      vnet_route_all_enabled                        = optional(bool)
      websockets_enabled                            = optional(bool)
      remote_debugging_version                      = optional(string)
      scm_minimum_tls_version                       = optional(string)
      api_definition_url                            = optional(string)
      api_management_api_id                         = optional(string)
      application_insights_connection_string        = optional(string)
      application_insights_key                      = optional(string)
      app_command_line                              = optional(string)
      container_registry_managed_identity_client_id = optional(string)
      ftps_state                                    = optional(string)
      health_check_path                             = optional(string)
      managed_pipeline_mode                         = optional(string)
      default_documents                             = optional(list(string))
      elastic_instance_minimum                      = optional(number)
      app_scale_limit                               = optional(number)
      health_check_eviction_time_in_min             = optional(number)
      pre_warmed_instance_count                     = optional(number)
      worker_count                                  = optional(number)
      application_stack = optional(list(object({
        dotnet_version              = optional(string)
        java_version                = optional(string)
        node_version                = optional(string)
        python_version              = optional(string)
        powershell_core_version     = optional(string)
        use_dotnet_isolated_runtime = optional(bool)
        docker = optional(list(object({
          image_name        = string
          image_tag         = string
          registry_url      = string
          registry_password = optional(string)
          registry_username = optional(string)
        })), [])
      })), [])
      app_service_logs = optional(list(object({
        disk_quota_mb         = optional(number)
        retention_period_days = optional(number)
      })), [])
      cors = optional(list(object({
        allowed_origins     = optional(list(string))
        support_credentials = optional(bool)
      })), [])
      ip_restriction = optional(list(object({
        action                    = optional(string)
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        headers = optional(list(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(list(string))
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        })), {})
      })), optional(list(string)))
      scm_ip_restriction = optional(list(object({
        action                    = optional(string)
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        headers = optional(list(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(list(string))
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        })), {})
      })), [])
    }))
    auth_settings = optional(list(object({
      enabled                        = bool
      token_store_enabled            = optional(bool)
      additional_login_parameters    = optional(map(string))
      allowed_external_redirect_urls = optional(list(string))
      default_provider               = optional(string)
      issuer                         = optional(string)
      runtime_version                = optional(string)
      unauthenticated_client_action  = optional(string)
      token_refresh_extension_hours  = optional(number)
      facebook = optional(list(object({
        app_id                  = string
        app_secret              = optional(string)
        app_secret_setting_name = optional(string)
        oauth_scopes            = optional(list(string))
      })), [])
      github = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      google = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      microsoft = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      twitter = optional(list(object({
        consumer_key                 = string
        consumer_secret              = optional(string)
        consumer_secret_setting_name = optional(string)
      })), [])
      active_directory = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        allowed_audiences          = optional(list(string))
      })), [])
    })), [])
    auth_settings_v2 = optional(list(object({
      auth_enabled                            = optional(bool)
      require_authentication                  = optional(bool)
      require_https                           = optional(bool)
      runtime_version                         = optional(string)
      config_file_path                        = optional(string)
      unauthenticated_action                  = optional(string)
      default_provider                        = optional(string)
      http_route_api_prefix                   = optional(string)
      forward_proxy_convention                = optional(string)
      forward_proxy_custom_host_header_name   = optional(string)
      forward_proxy_custom_scheme_header_name = optional(string)
      excluded_paths                          = optional(list(string))
      apple_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      })), [])
      active_directory_v2 = optional(list(object({
        client_id                            = string
        tenant_auth_endpoint                 = string
        client_secret_setting_name           = ""
        client_secret_certificate_thumbprint = optional(string)
        jwt_allowed_groups                   = optional(list(string))
        jwt_allowed_client_applications      = optional(list(string))
        allowed_groups                       = optional(list(string))
        allowed_audiences                    = optional(list(string))
        allowed_applications                 = optional(list(string))
        login_parameters                     = optional(map(string))
        www_authentication_disabled          = optional(bool)
      })), [])
      azure_static_web_app_v2 = optional(list(object({
        client_id = string
      })), [])
      custom_oidc_v2 = optional(list(object({
        client_id                     = string
        name                          = string
        openid_configuration_endpoint = string
        name_claim_type               = optional(string)
        scopes                        = optional(list(string))
        client_credential_method      = optional(string)
        client_secret_setting_name    = optional(string)
        authorisation_endpoint        = optional(string)
        token_endpoint                = optional(string)
        issuer_endpoint               = optional(string)
        certification_uri             = optional(string)
      })), [])
      facebook_v2 = optional(list(object({
        app_id                  = string
        app_secret_setting_name = string
        graph_api_version       = optional(string)
        login_scopes            = optional(list(string))
      })), [])
      github_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      })), [])
      google_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        allowed_audiences          = optional(list(string))
        login_scopes               = optional(list(string))
      })), [])
      microsoft_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        allowed_audiences          = optional(list(string))
        login_scopes               = optional(list(string))
      })), [])
      twitter_v2 = optional(list(object({
        consumer_key                 = string
        consumer_secret_setting_name = string
      })), [])
      login = optional(list(object({
        logout_endpoint                   = string
        token_store_path                  = optional(string)
        token_store_sas_setting_name      = optional(string)
        cookie_expiration_convention      = optional(string)
        cookie_expiration_time            = optional(string)
        nonce_expiration_time             = optional(string)
        validate_nonce                    = optional(bool)
        preserve_url_fragments_for_logins = optional(bool)
        token_store_enabled               = optional(bool)
        token_refresh_extension_time      = optional(number)
      })), [])
    })), [])
    backup = optional(list(object({
      name                = string
      storage_account_url = string
      enabled             = optional(bool)
      schedule = optional(list(object({
        frequency_interval = number
        frequency_unit     = string
      })), [])
    })), [])
    connection_string = optional(list(object({
      name  = string
      type  = string
      value = string
    })), [])
    identity = optional(list(object({
      type         = string
      identity_ids = optional(list(string))
    })), [])
    storage_account = optional(list(object({
      access_key   = string
      account_name = string
      name         = string
      share_name   = string
      type         = string
      mount_path   = optional(string)
    })), [])
  })))
  default = []
}

variable "linux_web_app" {
  type = list(map(object({
    id                                             = number
    name                                           = string
    service_plan_id                                = any
    builtin_logging_enabled                        = optional(bool)
    client_certificate_enabled                     = optional(bool)
    enabled                                        = optional(bool)
    content_share_force_disabled                   = optional(bool)
    ftp_publish_basic_authentication_enabled       = optional(bool)
    https_only                                     = optional(bool)
    public_network_access_enabled                  = optional(bool)
    storage_uses_managed_identity                  = optional(bool)
    webdeploy_publish_basic_authentication_enabled = optional(bool)
    client_certificate_exclusion_paths             = optional(string)
    client_certificate_mode                        = optional(string)
    functions_extension_version                    = optional(string)
    key_vault_reference_identity_id                = optional(string)
    storage_account_access_key                     = optional(string)
    storage_account_name                           = optional(string)
    storage_key_vault_secret_id                    = optional(string)
    virtual_network_subnet_id                      = optional(string)
    zip_deploy_file                                = optional(string)
    daily_memory_time_quota                        = optional(number)
    app_settings                                   = optional(map(string))
    tags                                           = optional(map(string))
    auth_settings = optional(list(object({
      enabled                        = bool
      token_store_enabled            = optional(bool)
      additional_login_parameters    = optional(map(string))
      allowed_external_redirect_urls = optional(list(string))
      default_provider               = optional(string)
      issuer                         = optional(string)
      runtime_version                = optional(string)
      unauthenticated_client_action  = optional(string)
      token_refresh_extension_hours  = optional(number)
      facebook = optional(list(object({
        app_id                  = string
        app_secret              = optional(string)
        app_secret_setting_name = optional(string)
        oauth_scopes            = optional(list(string))
      })), [])
      github = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      google = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      microsoft = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      twitter = optional(list(object({
        consumer_key                 = string
        consumer_secret              = optional(string)
        consumer_secret_setting_name = optional(string)
      })), [])
      active_directory = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        allowed_audiences          = optional(list(string))
      })), [])
    })), [])
    auth_settings_v2 = optional(list(object({
      auth_enabled                            = optional(bool)
      require_authentication                  = optional(bool)
      require_https                           = optional(bool)
      runtime_version                         = optional(string)
      config_file_path                        = optional(string)
      unauthenticated_action                  = optional(string)
      default_provider                        = optional(string)
      http_route_api_prefix                   = optional(string)
      forward_proxy_convention                = optional(string)
      forward_proxy_custom_host_header_name   = optional(string)
      forward_proxy_custom_scheme_header_name = optional(string)
      excluded_paths                          = optional(list(string))
      apple_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      })), [])
      active_directory_v2 = optional(list(object({
        client_id                            = string
        tenant_auth_endpoint                 = string
        client_secret_setting_name           = ""
        client_secret_certificate_thumbprint = optional(string)
        jwt_allowed_groups                   = optional(list(string))
        jwt_allowed_client_applications      = optional(list(string))
        allowed_groups                       = optional(list(string))
        allowed_audiences                    = optional(list(string))
        allowed_applications                 = optional(list(string))
        login_parameters                     = optional(map(string))
        www_authentication_disabled          = optional(bool)
      })), [])
      azure_static_web_app_v2 = optional(list(object({
        client_id = string
      })), [])
      custom_oidc_v2 = optional(list(object({
        client_id                     = string
        name                          = string
        openid_configuration_endpoint = string
        name_claim_type               = optional(string)
        scopes                        = optional(list(string))
        client_credential_method      = optional(string)
        client_secret_setting_name    = optional(string)
        authorisation_endpoint        = optional(string)
        token_endpoint                = optional(string)
        issuer_endpoint               = optional(string)
        certification_uri             = optional(string)
      })), [])
      facebook_v2 = optional(list(object({
        app_id                  = string
        app_secret_setting_name = string
        graph_api_version       = optional(string)
        login_scopes            = optional(list(string))
      })), [])
      github_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      })), [])
      google_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        allowed_audiences          = optional(list(string))
        login_scopes               = optional(list(string))
      })), [])
      microsoft_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        allowed_audiences          = optional(list(string))
        login_scopes               = optional(list(string))
      })), [])
      twitter_v2 = optional(list(object({
        consumer_key                 = string
        consumer_secret_setting_name = string
      })), [])
      login = optional(list(object({
        logout_endpoint                   = string
        token_store_path                  = optional(string)
        token_store_sas_setting_name      = optional(string)
        cookie_expiration_convention      = optional(string)
        cookie_expiration_time            = optional(string)
        nonce_expiration_time             = optional(string)
        validate_nonce                    = optional(bool)
        preserve_url_fragments_for_logins = optional(bool)
        token_store_enabled               = optional(bool)
        token_refresh_extension_time      = optional(number)
      })), [])
    })), [])
    backup = optional(list(object({
      name                = string
      storage_account_url = string
      enabled             = optional(bool)
      schedule = optional(list(object({
        frequency_interval = number
        frequency_unit     = string
      })), [])
    })), [])
    connection_string = optional(list(object({
      name  = string
      type  = string
      value = string
    })), [])
    identity = optional(list(object({
      type         = string
      identity_ids = optional(list(string))
    })), [])
    storage_account = optional(list(object({
      access_key   = string
      account_name = string
      name         = string
      share_name   = string
      type         = string
      mount_path   = optional(string)
    })), [])
    sticky_settings = optional(list(object({
      app_setting_names       = list(string)
      connection_string_names = optional(list(string))
    })), [])
    site_config = list(object({
      always_on                                     = bool
      container_registry_use_managed_identity       = optional(bool)
      http2_enabled                                 = optional(bool)
      scm_use_main_ip_restriction                   = optional(bool)
      runtime_scale_monitoring_enabled              = optional(bool)
      remote_debugging_enabled                      = optional(bool)
      use_32_bit_worker                             = optional(bool)
      vnet_route_all_enabled                        = optional(bool)
      websockets_enabled                            = optional(bool)
      remote_debugging_version                      = optional(string)
      scm_minimum_tls_version                       = optional(string)
      api_definition_url                            = optional(string)
      api_management_api_id                         = optional(string)
      application_insights_connection_string        = optional(string)
      application_insights_key                      = optional(string)
      app_command_line                              = optional(string)
      container_registry_managed_identity_client_id = optional(string)
      ftps_state                                    = optional(string)
      health_check_path                             = optional(string)
      managed_pipeline_mode                         = optional(string)
      default_documents                             = optional(list(string))
      elastic_instance_minimum                      = optional(number)
      app_scale_limit                               = optional(number)
      health_check_eviction_time_in_min             = optional(number)
      pre_warmed_instance_count                     = optional(number)
      worker_count                                  = optional(number)
      application_stack = optional(list(object({
        dotnet_version              = optional(string)
        java_version                = optional(string)
        node_version                = optional(string)
        python_version              = optional(string)
        powershell_core_version     = optional(string)
        use_dotnet_isolated_runtime = optional(bool)
        docker = optional(list(object({
          image_name        = string
          image_tag         = string
          registry_url      = string
          registry_password = optional(string)
          registry_username = optional(string)
        })), [])
      })), [])
      app_service_logs = optional(list(object({
        disk_quota_mb         = optional(number)
        retention_period_days = optional(number)
      })), [])
      cors = optional(list(object({
        allowed_origins     = optional(list(string))
        support_credentials = optional(bool)
      })), [])
      ip_restriction = optional(list(object({
        action                    = optional(string)
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        headers = optional(list(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(list(string))
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        })), {})
      })), optional(list(string)))
      scm_ip_restriction = optional(list(object({
        action                    = optional(string)
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        headers = optional(list(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(list(string))
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        })), {})
      })), [])
    }))
  })))
  default = []
}

variable "linux_web_app_slot" {
  type = list(map(object({
    id                                             = number
    app_service_id                                 = any
    name                                           = string
    builtin_logging_enabled                        = optional(bool)
    client_certificate_enabled                     = optional(bool)
    enabled                                        = optional(bool)
    content_share_force_disabled                   = optional(bool)
    ftp_publish_basic_authentication_enabled       = optional(bool)
    https_only                                     = optional(bool)
    public_network_access_enabled                  = optional(bool)
    storage_uses_managed_identity                  = optional(bool)
    webdeploy_publish_basic_authentication_enabled = optional(bool)
    client_certificate_exclusion_paths             = optional(string)
    client_certificate_mode                        = optional(string)
    functions_extension_version                    = optional(string)
    key_vault_reference_identity_id                = optional(string)
    storage_account_access_key                     = optional(string)
    storage_account_name                           = optional(string)
    storage_key_vault_secret_id                    = optional(string)
    virtual_network_subnet_id                      = optional(string)
    zip_deploy_file                                = optional(string)
    daily_memory_time_quota                        = optional(number)
    app_settings                                   = optional(map(string))
    tags                                           = optional(map(string))
    auth_settings = optional(list(object({
      enabled                        = bool
      token_store_enabled            = optional(bool)
      additional_login_parameters    = optional(map(string))
      allowed_external_redirect_urls = optional(list(string))
      default_provider               = optional(string)
      issuer                         = optional(string)
      runtime_version                = optional(string)
      unauthenticated_client_action  = optional(string)
      token_refresh_extension_hours  = optional(number)
      facebook = optional(list(object({
        app_id                  = string
        app_secret              = optional(string)
        app_secret_setting_name = optional(string)
        oauth_scopes            = optional(list(string))
      })), [])
      github = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      google = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      microsoft = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      twitter = optional(list(object({
        consumer_key                 = string
        consumer_secret              = optional(string)
        consumer_secret_setting_name = optional(string)
      })), [])
      active_directory = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        allowed_audiences          = optional(list(string))
      })), [])
    })), [])
    auth_settings_v2 = optional(list(object({
      auth_enabled                            = optional(bool)
      require_authentication                  = optional(bool)
      require_https                           = optional(bool)
      runtime_version                         = optional(string)
      config_file_path                        = optional(string)
      unauthenticated_action                  = optional(string)
      default_provider                        = optional(string)
      http_route_api_prefix                   = optional(string)
      forward_proxy_convention                = optional(string)
      forward_proxy_custom_host_header_name   = optional(string)
      forward_proxy_custom_scheme_header_name = optional(string)
      excluded_paths                          = optional(list(string))
      apple_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      })), [])
      active_directory_v2 = optional(list(object({
        client_id                            = string
        tenant_auth_endpoint                 = string
        client_secret_setting_name           = ""
        client_secret_certificate_thumbprint = optional(string)
        jwt_allowed_groups                   = optional(list(string))
        jwt_allowed_client_applications      = optional(list(string))
        allowed_groups                       = optional(list(string))
        allowed_audiences                    = optional(list(string))
        allowed_applications                 = optional(list(string))
        login_parameters                     = optional(map(string))
        www_authentication_disabled          = optional(bool)
      })), [])
      azure_static_web_app_v2 = optional(list(object({
        client_id = string
      })), [])
      custom_oidc_v2 = optional(list(object({
        client_id                     = string
        name                          = string
        openid_configuration_endpoint = string
        name_claim_type               = optional(string)
        scopes                        = optional(list(string))
        client_credential_method      = optional(string)
        client_secret_setting_name    = optional(string)
        authorisation_endpoint        = optional(string)
        token_endpoint                = optional(string)
        issuer_endpoint               = optional(string)
        certification_uri             = optional(string)
      })), [])
      facebook_v2 = optional(list(object({
        app_id                  = string
        app_secret_setting_name = string
        graph_api_version       = optional(string)
        login_scopes            = optional(list(string))
      })), [])
      github_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      })), [])
      google_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        allowed_audiences          = optional(list(string))
        login_scopes               = optional(list(string))
      })), [])
      microsoft_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        allowed_audiences          = optional(list(string))
        login_scopes               = optional(list(string))
      })), [])
      twitter_v2 = optional(list(object({
        consumer_key                 = string
        consumer_secret_setting_name = string
      })), [])
      login = optional(list(object({
        logout_endpoint                   = string
        token_store_path                  = optional(string)
        token_store_sas_setting_name      = optional(string)
        cookie_expiration_convention      = optional(string)
        cookie_expiration_time            = optional(string)
        nonce_expiration_time             = optional(string)
        validate_nonce                    = optional(bool)
        preserve_url_fragments_for_logins = optional(bool)
        token_store_enabled               = optional(bool)
        token_refresh_extension_time      = optional(number)
      })), [])
    })), [])
    backup = optional(list(object({
      name                = string
      storage_account_url = string
      enabled             = optional(bool)
      schedule = optional(list(object({
        frequency_interval = number
        frequency_unit     = string
      })), [])
    })), [])
    connection_string = optional(list(object({
      name  = string
      type  = string
      value = string
    })), [])
    identity = optional(list(object({
      type         = string
      identity_ids = optional(list(string))
    })), [])
    storage_account = optional(list(object({
      access_key   = string
      account_name = string
      name         = string
      share_name   = string
      type         = string
      mount_path   = optional(string)
    })), [])
    site_config = list(object({
      always_on                                     = bool
      container_registry_use_managed_identity       = optional(bool)
      http2_enabled                                 = optional(bool)
      scm_use_main_ip_restriction                   = optional(bool)
      runtime_scale_monitoring_enabled              = optional(bool)
      remote_debugging_enabled                      = optional(bool)
      use_32_bit_worker                             = optional(bool)
      vnet_route_all_enabled                        = optional(bool)
      websockets_enabled                            = optional(bool)
      remote_debugging_version                      = optional(string)
      scm_minimum_tls_version                       = optional(string)
      api_definition_url                            = optional(string)
      api_management_api_id                         = optional(string)
      application_insights_connection_string        = optional(string)
      application_insights_key                      = optional(string)
      app_command_line                              = optional(string)
      container_registry_managed_identity_client_id = optional(string)
      ftps_state                                    = optional(string)
      health_check_path                             = optional(string)
      managed_pipeline_mode                         = optional(string)
      default_documents                             = optional(list(string))
      elastic_instance_minimum                      = optional(number)
      app_scale_limit                               = optional(number)
      health_check_eviction_time_in_min             = optional(number)
      pre_warmed_instance_count                     = optional(number)
      worker_count                                  = optional(number)
      application_stack = optional(list(object({
        dotnet_version              = optional(string)
        java_version                = optional(string)
        node_version                = optional(string)
        python_version              = optional(string)
        powershell_core_version     = optional(string)
        use_dotnet_isolated_runtime = optional(bool)
        docker = optional(list(object({
          image_name        = string
          image_tag         = string
          registry_url      = string
          registry_password = optional(string)
          registry_username = optional(string)
        })), [])
      })), [])
      app_service_logs = optional(list(object({
        disk_quota_mb         = optional(number)
        retention_period_days = optional(number)
      })), [])
      cors = optional(list(object({
        allowed_origins     = optional(list(string))
        support_credentials = optional(bool)
      })), [])
      ip_restriction = optional(list(object({
        action                    = optional(string)
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        headers = optional(list(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(list(string))
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        })), {})
      })), optional(list(string)))
      scm_ip_restriction = optional(list(object({
        action                    = optional(string)
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        headers = optional(list(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(list(string))
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        })), {})
      })), [])
    }))
  })))
  default = []
}

variable "service_plan" {
  type = list(map(object({
    id                           = number
    name                         = string
    os_type                      = string
    sku_name                     = string
    app_service_environment_id   = optional(string)
    maximum_elastic_worker_count = optional(number)
    worker_count                 = optional(number)
    per_site_scaling_enabled     = optional(bool)
    zone_balancing_enabled       = optional(bool)
    tags                         = optional(map(string))
  })))
  default = []
}

variable "source_control_token" {
  type = list(map(object({
    id    = number
    token = string
    type  = string
  })))
  default = []
}

variable "static_site" {
  type = list(map(object({
    id       = number
    name     = string
    sku_tier = optional(string)
    sku_size = optional(string)
    tags     = optional(map(string))
    identity = optional(list(object({
      type         = string
      identity_ids = optional(list(string))
    })), [])
  })))
  default = []
}

variable "static_site_custom_domain" {
  type = list(map(object({
    id             = number
    domain_name    = string
    static_site_id = any
  })))
  default = []
}

variable "web_app_active_slot" {
  type = list(map(object({
    id                       = number
    slot_id                  = any
    overwrite_network_config = optional(bool)
  })))
  default = []
}

variable "web_app_hybrid_connection" {
  type = list(map(object({
    id            = number
    hostname      = string
    port          = number
    relay_id      = any
    web_app_id    = any
    send_key_name = optional(string)
  })))
  default = []
}

variable "windows_function_app" {
  type = list(map(object({
    id                                             = number
    name                                           = string
    service_plan_id                                = any
    builtin_logging_enabled                        = optional(bool)
    client_certificate_enabled                     = optional(bool)
    enabled                                        = optional(bool)
    content_share_force_disabled                   = optional(bool)
    ftp_publish_basic_authentication_enabled       = optional(bool)
    https_only                                     = optional(bool)
    public_network_access_enabled                  = optional(bool)
    storage_uses_managed_identity                  = optional(bool)
    webdeploy_publish_basic_authentication_enabled = optional(bool)
    client_certificate_exclusion_paths             = optional(string)
    client_certificate_mode                        = optional(string)
    functions_extension_version                    = optional(string)
    key_vault_reference_identity_id                = optional(string)
    storage_account_access_key                     = optional(string)
    storage_account_name                           = optional(string)
    storage_key_vault_secret_id                    = optional(string)
    virtual_network_subnet_id                      = optional(string)
    zip_deploy_file                                = optional(string)
    daily_memory_time_quota                        = optional(number)
    app_settings                                   = optional(map(string))
    tags                                           = optional(map(string))
    auth_settings = optional(list(object({
      enabled                        = bool
      token_store_enabled            = optional(bool)
      additional_login_parameters    = optional(map(string))
      allowed_external_redirect_urls = optional(list(string))
      default_provider               = optional(string)
      issuer                         = optional(string)
      runtime_version                = optional(string)
      unauthenticated_client_action  = optional(string)
      token_refresh_extension_hours  = optional(number)
      facebook = optional(list(object({
        app_id                  = string
        app_secret              = optional(string)
        app_secret_setting_name = optional(string)
        oauth_scopes            = optional(list(string))
      })), [])
      github = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      google = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      microsoft = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      twitter = optional(list(object({
        consumer_key                 = string
        consumer_secret              = optional(string)
        consumer_secret_setting_name = optional(string)
      })), [])
      active_directory = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        allowed_audiences          = optional(list(string))
      })), [])
    })), [])
    auth_settings_v2 = optional(list(object({
      auth_enabled                            = optional(bool)
      require_authentication                  = optional(bool)
      require_https                           = optional(bool)
      runtime_version                         = optional(string)
      config_file_path                        = optional(string)
      unauthenticated_action                  = optional(string)
      default_provider                        = optional(string)
      http_route_api_prefix                   = optional(string)
      forward_proxy_convention                = optional(string)
      forward_proxy_custom_host_header_name   = optional(string)
      forward_proxy_custom_scheme_header_name = optional(string)
      excluded_paths                          = optional(list(string))
      apple_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      })), [])
      active_directory_v2 = optional(list(object({
        client_id                            = string
        tenant_auth_endpoint                 = string
        client_secret_setting_name           = ""
        client_secret_certificate_thumbprint = optional(string)
        jwt_allowed_groups                   = optional(list(string))
        jwt_allowed_client_applications      = optional(list(string))
        allowed_groups                       = optional(list(string))
        allowed_audiences                    = optional(list(string))
        allowed_applications                 = optional(list(string))
        login_parameters                     = optional(map(string))
        www_authentication_disabled          = optional(bool)
      })), [])
      azure_static_web_app_v2 = optional(list(object({
        client_id = string
      })), [])
      custom_oidc_v2 = optional(list(object({
        client_id                     = string
        name                          = string
        openid_configuration_endpoint = string
        name_claim_type               = optional(string)
        scopes                        = optional(list(string))
        client_credential_method      = optional(string)
        client_secret_setting_name    = optional(string)
        authorisation_endpoint        = optional(string)
        token_endpoint                = optional(string)
        issuer_endpoint               = optional(string)
        certification_uri             = optional(string)
      })), [])
      facebook_v2 = optional(list(object({
        app_id                  = string
        app_secret_setting_name = string
        graph_api_version       = optional(string)
        login_scopes            = optional(list(string))
      })), [])
      github_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      })), [])
      google_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        allowed_audiences          = optional(list(string))
        login_scopes               = optional(list(string))
      })), [])
      microsoft_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        allowed_audiences          = optional(list(string))
        login_scopes               = optional(list(string))
      })), [])
      twitter_v2 = optional(list(object({
        consumer_key                 = string
        consumer_secret_setting_name = string
      })), [])
      login = optional(list(object({
        logout_endpoint                   = string
        token_store_path                  = optional(string)
        token_store_sas_setting_name      = optional(string)
        cookie_expiration_convention      = optional(string)
        cookie_expiration_time            = optional(string)
        nonce_expiration_time             = optional(string)
        validate_nonce                    = optional(bool)
        preserve_url_fragments_for_logins = optional(bool)
        token_store_enabled               = optional(bool)
        token_refresh_extension_time      = optional(number)
      })), [])
    })), [])
    backup = optional(list(object({
      name                = string
      storage_account_url = string
      enabled             = optional(bool)
      schedule = optional(list(object({
        frequency_interval = number
        frequency_unit     = string
      })), [])
    })), [])
    connection_string = optional(list(object({
      name  = string
      type  = string
      value = string
    })), [])
    identity = optional(list(object({
      type         = string
      identity_ids = optional(list(string))
    })), [])
    storage_account = optional(list(object({
      access_key   = string
      account_name = string
      name         = string
      share_name   = string
      type         = string
      mount_path   = optional(string)
    })), [])
    site_config = list(object({
      always_on                                     = bool
      container_registry_use_managed_identity       = optional(bool)
      http2_enabled                                 = optional(bool)
      scm_use_main_ip_restriction                   = optional(bool)
      runtime_scale_monitoring_enabled              = optional(bool)
      remote_debugging_enabled                      = optional(bool)
      use_32_bit_worker                             = optional(bool)
      vnet_route_all_enabled                        = optional(bool)
      websockets_enabled                            = optional(bool)
      remote_debugging_version                      = optional(string)
      scm_minimum_tls_version                       = optional(string)
      api_definition_url                            = optional(string)
      api_management_api_id                         = optional(string)
      application_insights_connection_string        = optional(string)
      application_insights_key                      = optional(string)
      app_command_line                              = optional(string)
      container_registry_managed_identity_client_id = optional(string)
      ftps_state                                    = optional(string)
      health_check_path                             = optional(string)
      managed_pipeline_mode                         = optional(string)
      default_documents                             = optional(list(string))
      elastic_instance_minimum                      = optional(number)
      app_scale_limit                               = optional(number)
      health_check_eviction_time_in_min             = optional(number)
      pre_warmed_instance_count                     = optional(number)
      worker_count                                  = optional(number)
      application_stack = optional(list(object({
        dotnet_version              = optional(string)
        java_version                = optional(string)
        node_version                = optional(string)
        python_version              = optional(string)
        powershell_core_version     = optional(string)
        use_dotnet_isolated_runtime = optional(bool)
        docker = optional(list(object({
          image_name        = string
          image_tag         = string
          registry_url      = string
          registry_password = optional(string)
          registry_username = optional(string)
        })), [])
      })), [])
      app_service_logs = optional(list(object({
        disk_quota_mb         = optional(number)
        retention_period_days = optional(number)
      })), [])
      cors = optional(list(object({
        allowed_origins     = optional(list(string))
        support_credentials = optional(bool)
      })), [])
      ip_restriction = optional(list(object({
        action                    = optional(string)
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        headers = optional(list(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(list(string))
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        })), {})
      })), optional(list(string)))
      scm_ip_restriction = optional(list(object({
        action                    = optional(string)
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        headers = optional(list(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(list(string))
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        })), {})
      })), [])
    }))
  })))
  default = []
}

variable "windows_function_app_slot" {
  type = list(map(object({
    id                                             = number
    function_app_id                                = any
    name                                           = string
    builtin_logging_enabled                        = optional(bool)
    client_certificate_enabled                     = optional(bool)
    enabled                                        = optional(bool)
    content_share_force_disabled                   = optional(bool)
    ftp_publish_basic_authentication_enabled       = optional(bool)
    https_only                                     = optional(bool)
    public_network_access_enabled                  = optional(bool)
    storage_uses_managed_identity                  = optional(bool)
    webdeploy_publish_basic_authentication_enabled = optional(bool)
    client_certificate_exclusion_paths             = optional(string)
    client_certificate_mode                        = optional(string)
    functions_extension_version                    = optional(string)
    key_vault_reference_identity_id                = optional(string)
    storage_account_access_key                     = optional(string)
    storage_account_name                           = optional(string)
    storage_key_vault_secret_id                    = optional(string)
    virtual_network_subnet_id                      = optional(string)
    zip_deploy_file                                = optional(string)
    daily_memory_time_quota                        = optional(number)
    app_settings                                   = optional(map(string))
    tags                                           = optional(map(string))
    auth_settings = optional(list(object({
      enabled                        = bool
      token_store_enabled            = optional(bool)
      additional_login_parameters    = optional(map(string))
      allowed_external_redirect_urls = optional(list(string))
      default_provider               = optional(string)
      issuer                         = optional(string)
      runtime_version                = optional(string)
      unauthenticated_client_action  = optional(string)
      token_refresh_extension_hours  = optional(number)
      facebook = optional(list(object({
        app_id                  = string
        app_secret              = optional(string)
        app_secret_setting_name = optional(string)
        oauth_scopes            = optional(list(string))
      })), [])
      github = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      google = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      microsoft = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      twitter = optional(list(object({
        consumer_key                 = string
        consumer_secret              = optional(string)
        consumer_secret_setting_name = optional(string)
      })), [])
      active_directory = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        allowed_audiences          = optional(list(string))
      })), [])
    })), [])
    auth_settings_v2 = optional(list(object({
      auth_enabled                            = optional(bool)
      require_authentication                  = optional(bool)
      require_https                           = optional(bool)
      runtime_version                         = optional(string)
      config_file_path                        = optional(string)
      unauthenticated_action                  = optional(string)
      default_provider                        = optional(string)
      http_route_api_prefix                   = optional(string)
      forward_proxy_convention                = optional(string)
      forward_proxy_custom_host_header_name   = optional(string)
      forward_proxy_custom_scheme_header_name = optional(string)
      excluded_paths                          = optional(list(string))
      apple_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      })), [])
      active_directory_v2 = optional(list(object({
        client_id                            = string
        tenant_auth_endpoint                 = string
        client_secret_setting_name           = ""
        client_secret_certificate_thumbprint = optional(string)
        jwt_allowed_groups                   = optional(list(string))
        jwt_allowed_client_applications      = optional(list(string))
        allowed_groups                       = optional(list(string))
        allowed_audiences                    = optional(list(string))
        allowed_applications                 = optional(list(string))
        login_parameters                     = optional(map(string))
        www_authentication_disabled          = optional(bool)
      })), [])
      azure_static_web_app_v2 = optional(list(object({
        client_id = string
      })), [])
      custom_oidc_v2 = optional(list(object({
        client_id                     = string
        name                          = string
        openid_configuration_endpoint = string
        name_claim_type               = optional(string)
        scopes                        = optional(list(string))
        client_credential_method      = optional(string)
        client_secret_setting_name    = optional(string)
        authorisation_endpoint        = optional(string)
        token_endpoint                = optional(string)
        issuer_endpoint               = optional(string)
        certification_uri             = optional(string)
      })), [])
      facebook_v2 = optional(list(object({
        app_id                  = string
        app_secret_setting_name = string
        graph_api_version       = optional(string)
        login_scopes            = optional(list(string))
      })), [])
      github_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      })), [])
      google_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        allowed_audiences          = optional(list(string))
        login_scopes               = optional(list(string))
      })), [])
      microsoft_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        allowed_audiences          = optional(list(string))
        login_scopes               = optional(list(string))
      })), [])
      twitter_v2 = optional(list(object({
        consumer_key                 = string
        consumer_secret_setting_name = string
      })), [])
      login = optional(list(object({
        logout_endpoint                   = string
        token_store_path                  = optional(string)
        token_store_sas_setting_name      = optional(string)
        cookie_expiration_convention      = optional(string)
        cookie_expiration_time            = optional(string)
        nonce_expiration_time             = optional(string)
        validate_nonce                    = optional(bool)
        preserve_url_fragments_for_logins = optional(bool)
        token_store_enabled               = optional(bool)
        token_refresh_extension_time      = optional(number)
      })), [])
    })), [])
    backup = optional(list(object({
      name                = string
      storage_account_url = string
      enabled             = optional(bool)
      schedule = optional(list(object({
        frequency_interval = number
        frequency_unit     = string
      })), [])
    })), [])
    connection_string = optional(list(object({
      name  = string
      type  = string
      value = string
    })), [])
    identity = optional(list(object({
      type         = string
      identity_ids = optional(list(string))
    })), [])
    storage_account = optional(list(object({
      access_key   = string
      account_name = string
      name         = string
      share_name   = string
      type         = string
      mount_path   = optional(string)
    })), [])
    site_config = list(object({
      always_on                                     = bool
      container_registry_use_managed_identity       = optional(bool)
      http2_enabled                                 = optional(bool)
      scm_use_main_ip_restriction                   = optional(bool)
      runtime_scale_monitoring_enabled              = optional(bool)
      remote_debugging_enabled                      = optional(bool)
      use_32_bit_worker                             = optional(bool)
      vnet_route_all_enabled                        = optional(bool)
      websockets_enabled                            = optional(bool)
      remote_debugging_version                      = optional(string)
      scm_minimum_tls_version                       = optional(string)
      api_definition_url                            = optional(string)
      api_management_api_id                         = optional(string)
      application_insights_connection_string        = optional(string)
      application_insights_key                      = optional(string)
      app_command_line                              = optional(string)
      container_registry_managed_identity_client_id = optional(string)
      ftps_state                                    = optional(string)
      health_check_path                             = optional(string)
      managed_pipeline_mode                         = optional(string)
      default_documents                             = optional(list(string))
      elastic_instance_minimum                      = optional(number)
      app_scale_limit                               = optional(number)
      health_check_eviction_time_in_min             = optional(number)
      pre_warmed_instance_count                     = optional(number)
      worker_count                                  = optional(number)
      application_stack = optional(list(object({
        dotnet_version              = optional(string)
        java_version                = optional(string)
        node_version                = optional(string)
        python_version              = optional(string)
        powershell_core_version     = optional(string)
        use_dotnet_isolated_runtime = optional(bool)
        docker = optional(list(object({
          image_name        = string
          image_tag         = string
          registry_url      = string
          registry_password = optional(string)
          registry_username = optional(string)
        })), [])
      })), [])
      app_service_logs = optional(list(object({
        disk_quota_mb         = optional(number)
        retention_period_days = optional(number)
      })), [])
      cors = optional(list(object({
        allowed_origins     = optional(list(string))
        support_credentials = optional(bool)
      })), [])
      ip_restriction = optional(list(object({
        action                    = optional(string)
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        headers = optional(list(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(list(string))
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        })), {})
      })), optional(list(string)))
      scm_ip_restriction = optional(list(object({
        action                    = optional(string)
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        headers = optional(list(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(list(string))
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        })), {})
      })), [])
    }))
  })))
  default = []
}

variable "windows_web_app" {
  type = list(map(object({
    id                                             = number
    name                                           = string
    service_plan_id                                = any
    builtin_logging_enabled                        = optional(bool)
    client_certificate_enabled                     = optional(bool)
    enabled                                        = optional(bool)
    content_share_force_disabled                   = optional(bool)
    ftp_publish_basic_authentication_enabled       = optional(bool)
    https_only                                     = optional(bool)
    public_network_access_enabled                  = optional(bool)
    storage_uses_managed_identity                  = optional(bool)
    webdeploy_publish_basic_authentication_enabled = optional(bool)
    client_certificate_exclusion_paths             = optional(string)
    client_certificate_mode                        = optional(string)
    functions_extension_version                    = optional(string)
    key_vault_reference_identity_id                = optional(string)
    storage_account_access_key                     = optional(string)
    storage_account_name                           = optional(string)
    storage_key_vault_secret_id                    = optional(string)
    virtual_network_subnet_id                      = optional(string)
    zip_deploy_file                                = optional(string)
    daily_memory_time_quota                        = optional(number)
    app_settings                                   = optional(map(string))
    tags                                           = optional(map(string))
    auth_settings = optional(list(object({
      enabled                        = bool
      token_store_enabled            = optional(bool)
      additional_login_parameters    = optional(map(string))
      allowed_external_redirect_urls = optional(list(string))
      default_provider               = optional(string)
      issuer                         = optional(string)
      runtime_version                = optional(string)
      unauthenticated_client_action  = optional(string)
      token_refresh_extension_hours  = optional(number)
      facebook = optional(list(object({
        app_id                  = string
        app_secret              = optional(string)
        app_secret_setting_name = optional(string)
        oauth_scopes            = optional(list(string))
      })), [])
      github = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      google = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      microsoft = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      twitter = optional(list(object({
        consumer_key                 = string
        consumer_secret              = optional(string)
        consumer_secret_setting_name = optional(string)
      })), [])
      active_directory = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        allowed_audiences          = optional(list(string))
      })), [])
    })), [])
    auth_settings_v2 = optional(list(object({
      auth_enabled                            = optional(bool)
      require_authentication                  = optional(bool)
      require_https                           = optional(bool)
      runtime_version                         = optional(string)
      config_file_path                        = optional(string)
      unauthenticated_action                  = optional(string)
      default_provider                        = optional(string)
      http_route_api_prefix                   = optional(string)
      forward_proxy_convention                = optional(string)
      forward_proxy_custom_host_header_name   = optional(string)
      forward_proxy_custom_scheme_header_name = optional(string)
      excluded_paths                          = optional(list(string))
      apple_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      })), [])
      active_directory_v2 = optional(list(object({
        client_id                            = string
        tenant_auth_endpoint                 = string
        client_secret_setting_name           = ""
        client_secret_certificate_thumbprint = optional(string)
        jwt_allowed_groups                   = optional(list(string))
        jwt_allowed_client_applications      = optional(list(string))
        allowed_groups                       = optional(list(string))
        allowed_audiences                    = optional(list(string))
        allowed_applications                 = optional(list(string))
        login_parameters                     = optional(map(string))
        www_authentication_disabled          = optional(bool)
      })), [])
      azure_static_web_app_v2 = optional(list(object({
        client_id = string
      })), [])
      custom_oidc_v2 = optional(list(object({
        client_id                     = string
        name                          = string
        openid_configuration_endpoint = string
        name_claim_type               = optional(string)
        scopes                        = optional(list(string))
        client_credential_method      = optional(string)
        client_secret_setting_name    = optional(string)
        authorisation_endpoint        = optional(string)
        token_endpoint                = optional(string)
        issuer_endpoint               = optional(string)
        certification_uri             = optional(string)
      })), [])
      facebook_v2 = optional(list(object({
        app_id                  = string
        app_secret_setting_name = string
        graph_api_version       = optional(string)
        login_scopes            = optional(list(string))
      })), [])
      github_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      })), [])
      google_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        allowed_audiences          = optional(list(string))
        login_scopes               = optional(list(string))
      })), [])
      microsoft_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        allowed_audiences          = optional(list(string))
        login_scopes               = optional(list(string))
      })), [])
      twitter_v2 = optional(list(object({
        consumer_key                 = string
        consumer_secret_setting_name = string
      })), [])
      login = optional(list(object({
        logout_endpoint                   = string
        token_store_path                  = optional(string)
        token_store_sas_setting_name      = optional(string)
        cookie_expiration_convention      = optional(string)
        cookie_expiration_time            = optional(string)
        nonce_expiration_time             = optional(string)
        validate_nonce                    = optional(bool)
        preserve_url_fragments_for_logins = optional(bool)
        token_store_enabled               = optional(bool)
        token_refresh_extension_time      = optional(number)
      })), [])
    })), [])
    backup = optional(list(object({
      name                = string
      storage_account_url = string
      enabled             = optional(bool)
      schedule = optional(list(object({
        frequency_interval = number
        frequency_unit     = string
      })), [])
    })), [])
    connection_string = optional(list(object({
      name  = string
      type  = string
      value = string
    })), [])
    identity = optional(list(object({
      type         = string
      identity_ids = optional(list(string))
    })), [])
    storage_account = optional(list(object({
      access_key   = string
      account_name = string
      name         = string
      share_name   = string
      type         = string
      mount_path   = optional(string)
    })), [])
    site_config = list(object({
      always_on                                     = bool
      container_registry_use_managed_identity       = optional(bool)
      http2_enabled                                 = optional(bool)
      scm_use_main_ip_restriction                   = optional(bool)
      runtime_scale_monitoring_enabled              = optional(bool)
      remote_debugging_enabled                      = optional(bool)
      use_32_bit_worker                             = optional(bool)
      vnet_route_all_enabled                        = optional(bool)
      websockets_enabled                            = optional(bool)
      remote_debugging_version                      = optional(string)
      scm_minimum_tls_version                       = optional(string)
      api_definition_url                            = optional(string)
      api_management_api_id                         = optional(string)
      application_insights_connection_string        = optional(string)
      application_insights_key                      = optional(string)
      app_command_line                              = optional(string)
      container_registry_managed_identity_client_id = optional(string)
      ftps_state                                    = optional(string)
      health_check_path                             = optional(string)
      managed_pipeline_mode                         = optional(string)
      default_documents                             = optional(list(string))
      elastic_instance_minimum                      = optional(number)
      app_scale_limit                               = optional(number)
      health_check_eviction_time_in_min             = optional(number)
      pre_warmed_instance_count                     = optional(number)
      worker_count                                  = optional(number)
      application_stack = optional(list(object({
        dotnet_version              = optional(string)
        java_version                = optional(string)
        node_version                = optional(string)
        powershell_core_version     = optional(string)
        use_dotnet_isolated_runtime = optional(bool)
        docker = optional(list(object({
          image_name        = string
          image_tag         = string
          registry_url      = string
          registry_password = optional(string)
          registry_username = optional(string)
        })), [])
      })), [])
      app_service_logs = optional(list(object({
        disk_quota_mb         = optional(number)
        retention_period_days = optional(number)
      })), [])
      cors = optional(list(object({
        allowed_origins     = optional(list(string))
        support_credentials = optional(bool)
      })), [])
      ip_restriction = optional(list(object({
        action                    = optional(string)
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        headers = optional(list(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(list(string))
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        })), {})
      })), optional(list(string)))
      scm_ip_restriction = optional(list(object({
        action                    = optional(string)
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        headers = optional(list(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(list(string))
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        })), {})
      })), [])
    }))
  })))
  default = []
}

variable "windows_web_app_slot" {
  type = list(map(object({
    id                                             = number
    app_service_id                                 = any
    name                                           = string
    builtin_logging_enabled                        = optional(bool)
    client_certificate_enabled                     = optional(bool)
    enabled                                        = optional(bool)
    content_share_force_disabled                   = optional(bool)
    ftp_publish_basic_authentication_enabled       = optional(bool)
    https_only                                     = optional(bool)
    public_network_access_enabled                  = optional(bool)
    storage_uses_managed_identity                  = optional(bool)
    webdeploy_publish_basic_authentication_enabled = optional(bool)
    client_certificate_exclusion_paths             = optional(string)
    client_certificate_mode                        = optional(string)
    functions_extension_version                    = optional(string)
    key_vault_reference_identity_id                = optional(string)
    storage_account_access_key                     = optional(string)
    storage_account_name                           = optional(string)
    storage_key_vault_secret_id                    = optional(string)
    virtual_network_subnet_id                      = optional(string)
    zip_deploy_file                                = optional(string)
    daily_memory_time_quota                        = optional(number)
    app_settings                                   = optional(map(string))
    tags                                           = optional(map(string))
    auth_settings = optional(list(object({
      enabled                        = bool
      token_store_enabled            = optional(bool)
      additional_login_parameters    = optional(map(string))
      allowed_external_redirect_urls = optional(list(string))
      default_provider               = optional(string)
      issuer                         = optional(string)
      runtime_version                = optional(string)
      unauthenticated_client_action  = optional(string)
      token_refresh_extension_hours  = optional(number)
      facebook = optional(list(object({
        app_id                  = string
        app_secret              = optional(string)
        app_secret_setting_name = optional(string)
        oauth_scopes            = optional(list(string))
      })), [])
      github = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      google = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      microsoft = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      })), [])
      twitter = optional(list(object({
        consumer_key                 = string
        consumer_secret              = optional(string)
        consumer_secret_setting_name = optional(string)
      })), [])
      active_directory = optional(list(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        allowed_audiences          = optional(list(string))
      })), [])
    })), [])
    auth_settings_v2 = optional(list(object({
      auth_enabled                            = optional(bool)
      require_authentication                  = optional(bool)
      require_https                           = optional(bool)
      runtime_version                         = optional(string)
      config_file_path                        = optional(string)
      unauthenticated_action                  = optional(string)
      default_provider                        = optional(string)
      http_route_api_prefix                   = optional(string)
      forward_proxy_convention                = optional(string)
      forward_proxy_custom_host_header_name   = optional(string)
      forward_proxy_custom_scheme_header_name = optional(string)
      excluded_paths                          = optional(list(string))
      apple_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      })), [])
      active_directory_v2 = optional(list(object({
        client_id                            = string
        tenant_auth_endpoint                 = string
        client_secret_setting_name           = ""
        client_secret_certificate_thumbprint = optional(string)
        jwt_allowed_groups                   = optional(list(string))
        jwt_allowed_client_applications      = optional(list(string))
        allowed_groups                       = optional(list(string))
        allowed_audiences                    = optional(list(string))
        allowed_applications                 = optional(list(string))
        login_parameters                     = optional(map(string))
        www_authentication_disabled          = optional(bool)
      })), [])
      azure_static_web_app_v2 = optional(list(object({
        client_id = string
      })), [])
      custom_oidc_v2 = optional(list(object({
        client_id                     = string
        name                          = string
        openid_configuration_endpoint = string
        name_claim_type               = optional(string)
        scopes                        = optional(list(string))
        client_credential_method      = optional(string)
        client_secret_setting_name    = optional(string)
        authorisation_endpoint        = optional(string)
        token_endpoint                = optional(string)
        issuer_endpoint               = optional(string)
        certification_uri             = optional(string)
      })), [])
      facebook_v2 = optional(list(object({
        app_id                  = string
        app_secret_setting_name = string
        graph_api_version       = optional(string)
        login_scopes            = optional(list(string))
      })), [])
      github_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      })), [])
      google_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        allowed_audiences          = optional(list(string))
        login_scopes               = optional(list(string))
      })), [])
      microsoft_v2 = optional(list(object({
        client_id                  = string
        client_secret_setting_name = string
        allowed_audiences          = optional(list(string))
        login_scopes               = optional(list(string))
      })), [])
      twitter_v2 = optional(list(object({
        consumer_key                 = string
        consumer_secret_setting_name = string
      })), [])
      login = optional(list(object({
        logout_endpoint                   = string
        token_store_path                  = optional(string)
        token_store_sas_setting_name      = optional(string)
        cookie_expiration_convention      = optional(string)
        cookie_expiration_time            = optional(string)
        nonce_expiration_time             = optional(string)
        validate_nonce                    = optional(bool)
        preserve_url_fragments_for_logins = optional(bool)
        token_store_enabled               = optional(bool)
        token_refresh_extension_time      = optional(number)
      })), [])
    })), [])
    backup = optional(list(object({
      name                = string
      storage_account_url = string
      enabled             = optional(bool)
      schedule = optional(list(object({
        frequency_interval = number
        frequency_unit     = string
      })), [])
    })), [])
    connection_string = optional(list(object({
      name  = string
      type  = string
      value = string
    })), [])
    identity = optional(list(object({
      type         = string
      identity_ids = optional(list(string))
    })), [])
    storage_account = optional(list(object({
      access_key   = string
      account_name = string
      name         = string
      share_name   = string
      type         = string
      mount_path   = optional(string)
    })), [])
    site_config = list(object({
      always_on                                     = bool
      container_registry_use_managed_identity       = optional(bool)
      http2_enabled                                 = optional(bool)
      scm_use_main_ip_restriction                   = optional(bool)
      runtime_scale_monitoring_enabled              = optional(bool)
      remote_debugging_enabled                      = optional(bool)
      use_32_bit_worker                             = optional(bool)
      vnet_route_all_enabled                        = optional(bool)
      websockets_enabled                            = optional(bool)
      remote_debugging_version                      = optional(string)
      scm_minimum_tls_version                       = optional(string)
      api_definition_url                            = optional(string)
      api_management_api_id                         = optional(string)
      application_insights_connection_string        = optional(string)
      application_insights_key                      = optional(string)
      app_command_line                              = optional(string)
      container_registry_managed_identity_client_id = optional(string)
      ftps_state                                    = optional(string)
      health_check_path                             = optional(string)
      managed_pipeline_mode                         = optional(string)
      default_documents                             = optional(list(string))
      elastic_instance_minimum                      = optional(number)
      app_scale_limit                               = optional(number)
      health_check_eviction_time_in_min             = optional(number)
      pre_warmed_instance_count                     = optional(number)
      worker_count                                  = optional(number)
      application_stack = optional(list(object({
        dotnet_version              = optional(string)
        java_version                = optional(string)
        node_version                = optional(string)
        powershell_core_version     = optional(string)
        use_dotnet_isolated_runtime = optional(bool)
        docker = optional(list(object({
          image_name        = string
          image_tag         = string
          registry_url      = string
          registry_password = optional(string)
          registry_username = optional(string)
        })), [])
      })), [])
      app_service_logs = optional(list(object({
        disk_quota_mb         = optional(number)
        retention_period_days = optional(number)
      })), [])
      cors = optional(list(object({
        allowed_origins     = optional(list(string))
        support_credentials = optional(bool)
      })), [])
      ip_restriction = optional(list(object({
        action                    = optional(string)
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        headers = optional(list(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(list(string))
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        })), {})
      })), optional(list(string)))
      scm_ip_restriction = optional(list(object({
        action                    = optional(string)
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        headers = optional(list(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(list(string))
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        })), {})
      })), [])
    }))
  })))
  default = []
}