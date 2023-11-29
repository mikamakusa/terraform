resource "azurerm_app_service" "this" {
  count = length(var.app_service) == "0" ? "0" : (length(var.app_service_plan))
  app_service_plan_id = try(
    element(azurerm_app_service_plan.this.*.id, lookup(var.app_service[count.index], "app_service_plan_id"))
  )
  location                        = data.azurerm_resource_group.this.location
  name                            = lookup(var.app_service[count.index], "name")
  resource_group_name             = data.azurerm_resource_group.this.name
  app_settings                    = lookup(var.app_service[count.index], "app_settings")
  client_affinity_enabled         = lookup(var.app_service[count.index], "client_affinity_enabled")
  client_cert_enabled             = lookup(var.app_service[count.index], "client_cert_enabled")
  client_cert_mode                = lookup(var.app_service[count.index], "client_cert_mode")
  enabled                         = lookup(var.app_service[count.index], "enabled")
  https_only                      = lookup(var.app_service[count.index], "https_only")
  key_vault_reference_identity_id = lookup(var.app_service[count.index], "key_vault_reference_identity_id")
  tags = merge(
    var.tags,
    lookup(var.app_service[count.index], "tags")
  )

  dynamic "auth_settings" {
    for_each = lookup(var.app_service[count.index], "auth_settings") == null ? [] : ["auth_settings"]
    content {
      enabled                        = lookup(auth_settings.value, "enabled")
      additional_login_params        = lookup(auth_settings.value, "additional_login_params")
      allowed_external_redirect_urls = lookup(auth_settings.value, "allowed_external_redirect_urls")
      default_provider               = lookup(auth_settings.value, "default_provider")
      issuer                         = lookup(auth_settings.value, "issuer")
      runtime_version                = lookup(auth_settings.value, "runtime_version")
      token_refresh_extension_hours  = lookup(auth_settings.value, "token_refresh_extension_hours")
      token_store_enabled            = lookup(auth_settings.value, "token_store_enabled")
      unauthenticated_client_action  = lookup(auth_settings.value, "unauthenticated_client_action")

      dynamic "twitter" {
        for_each = lookup(auth_settings.value, "twitter") == null ? [] : ["twitter"]
        content {
          consumer_key    = lookup(twitter.value, "consumer_key")
          consumer_secret = lookup(twitter.value, "consumer_secret")
        }
      }

      dynamic "microsoft" {
        for_each = lookup(auth_settings.value, "microsoft") == null ? [] : ["microsoft"]
        content {
          client_id     = lookup(microsoft.value, "client_id")
          client_secret = lookup(microsoft.value, "client_secret")
          oauth_scopes  = lookup(microsoft.value, "oauth_scopes")
        }
      }

      dynamic "facebook" {
        for_each = lookup(auth_settings.value, "facebook") == null ? [] : ["facebook"]
        content {
          app_id       = lookup(facebook.value, "app_id")
          app_secret   = lookup(facebook.value, "app_secret")
          oauth_scopes = lookup(facebook.value, "oauth_scopes")
        }
      }

      dynamic "google" {
        for_each = lookup(auth_settings.value, "google") == null ? [] : ["google"]
        content {
          client_id     = lookup(google.value, "client_id")
          client_secret = lookup(google.value, "client_secret")
          oauth_scopes  = lookup(google.value, "oauth_scopes")
        }
      }

      dynamic "active_directory" {
        for_each = lookup(auth_settings.value, "active_directory") == null ? [] : ["active_directory"]
        content {
          client_id         = lookup(active_directory.value, "client_id")
          client_secret     = lookup(active_directory.value, "client_secret")
          allowed_audiences = lookup(active_directory.value, "allowed_audiences")
        }
      }
    }
  }

  dynamic "backup" {
    for_each = lookup(var.app_service[count.index], "backup") == null ? [] : ["backup"]
    content {
      name                = lookup(backup.value, "name")
      storage_account_url = lookup(backup.value, "storage_account_url")
      enabled             = lookup(backup.value, "enabled")

      dynamic "schedule" {
        for_each = lookup(backup.value, "schedule") == null ? [] : ["schedule"]
        content {
          frequency_interval       = lookup(schedule.value, "frequency_interval")
          frequency_unit           = lookup(schedule.value, "frequency_unit")
          keep_at_least_one_backup = lookup(schedule.value, "keep_at_least_one_backup")
          retention_period_in_days = lookup(schedule.value, "retention_period_in_days")
          start_time               = lookup(schedule.value, "start_time")
        }
      }
    }
  }

  dynamic "connection_string" {
    for_each = lookup(var.app_service[count.index], "connection_string") == null ? [] : ["connection_string"]
    content {
      name  = lookup(connection_string.value, "name")
      type  = lookup(connection_string.value, "type")
      value = lookup(connection_string.value, "value")
    }
  }

  dynamic "identity" {
    for_each = lookup(var.app_service[count.index], "identity") == null ? [] : ["identity"]
    content {
      type         = lookup(identity.value, "type")
      identity_ids = lookup(identity.value, "identity_ids")
    }
  }

  dynamic "logs" {
    for_each = lookup(var.app_service[count.index], "logs") == null ? [] : ["logs"]
    content {
      detailed_error_messages_enabled = lookup(logs.value, "detailed_error_messages_enabled")
      failed_request_tracing_enabled  = lookup(logs.value, "failed_request_tracing_enabled")

      dynamic "application_logs" {
        for_each = lookup(logs.value, "application_logs") == null ? [] : ["application_logs"]
        content {
          dynamic "azure_blob_storage" {
            for_each = lookup(application_logs.value, "azure_blob_storage") == null ? [] : ["azure_blob_storage"]
            content {
              level             = lookup(azure_blob_storage.value, "level")
              retention_in_days = lookup(azure_blob_storage.value, "retention_in_days")
              sas_url           = lookup(azure_blob_storage.value, "sas_url")
            }
          }
          file_system_level = lookup(logs.value, "file_system_level")
        }
      }

      dynamic "http_logs" {
        for_each = lookup(logs.value, "http_logs") == null ? [] : ["http_logs"]
        content {
          dynamic "file_system" {
            for_each = lookup(http_logs.value, "file_system") == null ? [] : ["file_system"]
            content {
              retention_in_days = lookup(file_system.value, "retention_in_days")
              retention_in_mb   = lookup(file_system.value, "retention_in_mb")
            }
          }
          dynamic "azure_blob_storage" {
            for_each = lookup(http_logs.value, "azure_blob_storage") == null ? [] : ["azure_blob_storage"]
            content {
              retention_in_days = lookup(azure_blob_storage.value, "retention_in_days")
              sas_url           = lookup(azure_blob_storage.value, "sas_url")
              level             = lookup(azure_blob_storage.value, "level")
            }
          }
        }
      }
    }
  }

  dynamic "storage_account" {
    for_each = lookup(var.app_service[count.index], "storage_account") == null ? [] : ["storage_account"]
    content {
      access_key   = lookup(storage_account.value, "access_key")
      account_name = lookup(storage_account.value, "account_name")
      name         = lookup(storage_account.value, "name")
      share_name   = lookup(storage_account.value, "share_name")
      type         = lookup(storage_account.value, "type")
      mount_path   = lookup(storage_account.value, "mount_path")
    }
  }

  dynamic "site_config" {
    for_each = lookup(var.app_service[count.index], "site_config") == null ? [] : ["site_config"]
    content {
      acr_use_managed_identity_credentials = lookup(site_config.value, "acr_use_managed_identity_credentials")
      acr_user_managed_identity_client_id  = lookup(site_config.value, "acr_user_managed_identity_client_id")
      always_on                            = lookup(site_config.value, "always_on")
      app_command_line                     = lookup(site_config.value, "app_command_line")
      auto_swap_slot_name                  = lookup(site_config.value, "auto_swap_slot_name")
      default_documents                    = lookup(site_config.value, "default_documents")
      dotnet_framework_version             = lookup(site_config.value, "dotnet_framework_version")
      ftps_state                           = lookup(site_config.value, "ftps_state")
      health_check_path                    = lookup(site_config.value, "health_check_path")
      number_of_workers                    = lookup(site_config.value, "number_of_workers")
      http2_enabled                        = lookup(site_config.value, "http2_enabled")
      java_version                         = lookup(site_config.value, "java_version")
      java_container_version               = lookup(site_config.value, "java_container_version")
      local_mysql_enabled                  = lookup(site_config.value, "local_mysql_enabled")
      linux_fx_version                     = lookup(site_config.value, "linux_fx_version")
      windows_fx_version                   = lookup(site_config.value, "windows_fx_version")
      managed_pipeline_mode                = lookup(site_config.value, "managed_pipeline_mode")
      min_tls_version                      = lookup(site_config.value, "min_tls_version")
      php_version                          = lookup(site_config.value, "php_version")
      python_version                       = lookup(site_config.value, "python_version")
      remote_debugging_enabled             = lookup(site_config.value, "remote_debugging_enabled")
      remote_debugging_version             = lookup(site_config.value, "remote_debugging_version")
      scm_type                             = lookup(site_config.value, "scm_type")
      use_32_bit_worker_process            = lookup(site_config.value, "use_32_bit_worker_process")
      vnet_route_all_enabled               = lookup(site_config.value, "vnet_route_all_enabled")
      websockets_enabled                   = lookup(site_config.value, "websockets_enabled")

      dynamic "scm_ip_restriction" {
        for_each = lookup(site_config.value, "scm_ip_restriction") == null ? [] : ["scm_ip_restriction"]
        content {
          ip_address                = lookup(scm_ip_restriction.value, "ip_address")
          action                    = lookup(scm_ip_restriction.value, "action")
          priority                  = lookup(scm_ip_restriction.value, "priority")
          service_tag               = lookup(scm_ip_restriction.value, "service_tag")
          virtual_network_subnet_id = lookup(scm_ip_restriction.value, "virtual_network_subnet_id")
          headers                   = lookup(scm_ip_restriction.value, "headers")
        }
      }

      dynamic "ip_restriction" {
        for_each = lookup(site_config.value, "ip_restriction") == null ? [] : ["ip_restriction"]
        content {
          ip_address                = lookup(ip_restriction.value, "ip_address")
          action                    = lookup(ip_restriction.value, "action")
          priority                  = lookup(ip_restriction.value, "priority")
          service_tag               = lookup(ip_restriction.value, "service_tag")
          virtual_network_subnet_id = lookup(ip_restriction.value, "virtual_network_subnet_id")
          headers                   = lookup(ip_restriction.value, "headers")
        }
      }

      dynamic "cors" {
        for_each = lookup(site_config.value, "cors") == null ? [] : ["cors"]
        content {
          allowed_origins     = lookup(cors.value, "allowed_origins")
          support_credentials = lookup(cors.value, "support_credentials")
        }
      }
    }
  }

  dynamic "source_control" {
    for_each = lookup(var.app_service[count.index], "source_control") == null ? [] : ["source_control"]
    content {
      repo_url           = lookup(source_control.value, "repo_url")
      branch             = lookup(source_control.value, "branch")
      manual_integration = lookup(source_control.value, "manual_integration")
      rollback_enabled   = lookup(source_control.value, "rollback_enabled")
      use_mercurial      = lookup(source_control.value, "use_mercurial")
    }
  }
}

resource "azurerm_app_service_active_slot" "this" {
  count = length(var.app_service_active_slot) == "0" ? "0" : (length(var.app_service) && length(var.app_service_slot))
  app_service_name = try(
    element(azurerm_app_service.this.*.name, lookup(var.app_service_active_slot[count.index], "app_service_id"))
  )
  app_service_slot_name = try(
    element(azurerm_app_service_slot.this.*.name, lookup(var.app_service_active_slot[count.index], "app_service_slot_id"))
  )
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_app_service_certificate" "this" {
  count               = length(var.app_service_certificate)
  location            = data.azurerm_resource_group.this.location
  name                = lookup(var.app_service_certificate[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.name
  pfx_blob            = lookup(var.app_service_certificate[count.index], "pfx_blob")
  password            = lookup(var.app_service_certificate[count.index], "password")
  app_service_plan_id = try(
    element(azurerm_app_service_plan.this.*.id, lookup(var.app_service_certificate[count.index], "app_service_plan_id"))
  )
  key_vault_secret_id = lookup(var.app_service_certificate[count.index], "key_vault_secret_id")
  tags = merge(
    var.tags,
    lookup(var.app_service_certificate[count.index], "tags")
  )
}

resource "azurerm_app_service_certificate_binding" "this" {
  count = length(var.app_service_certificate_binding) == "0" ? "0" : (length(var.app_service_managed_certificate) && length(var.app_service_custom_hostname_binding))
  certificate_id = try(
    element(azurerm_app_service_managed_certificate.this.*.id, lookup(var.app_service_certificate_binding[count.index], "certificate_id"))
  )
  hostname_binding_id = try(
    element(azurerm_app_service_custom_hostname_binding.this.*.id, lookup(var.app_service_certificate_binding[count.index], "hostname_binding_id"))
  )
  ssl_state = lookup(var.app_service_certificate_binding[count.index], "ssl_state")
}

resource "azurerm_app_service_certificate_order" "this" {
  count               = length(var.app_service_certificate_order)
  location            = data.azurerm_resource_group.this.location
  name                = lookup(var.app_service_certificate_order[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.name
  auto_renew          = lookup(var.app_service_certificate_order[count.index], "auto_renew")
  csr                 = lookup(var.app_service_certificate_order[count.index], "csr")
  distinguished_name  = lookup(var.app_service_certificate_order[count.index], "distinguished_name")
  key_size            = lookup(var.app_service_certificate_order[count.index], "key_size")
  product_type        = lookup(var.app_service_certificate_order[count.index], "product_type")
  validity_in_years   = lookup(var.app_service_certificate_order[count.index], "validity_in_years")
}

resource "azurerm_app_service_connection" "this" {
  count = length(var.app_service_connection) == "0" ? "0" : length(var.linux_web_app)
  app_service_id = try(
    element(azurerm_linux_web_app.this.*.id, lookup(var.app_service_connection[count.index], "app_service_id"))
  )
  name               = lookup(var.app_service_connection[count.index], "name")
  target_resource_id = lookup(var.app_service_connection[count.index], "target_resource_id")

  dynamic "authentication" {
    for_each = lookup(var.app_service_connection[count.index], "authentication") == null ? [] : ["authentication"]
    content {
      type            = lookup(authentication.value, "type")
      name            = lookup(authentication.value, "name")
      secret          = lookup(authentication.value, "secret")
      client_id       = lookup(authentication.value, "client_id")
      subscription_id = lookup(authentication.value, "subscription_id")
      principal_id    = lookup(authentication.value, "principal_id")
      certificate     = lookup(authentication.value, "certificate")
      client_type     = lookup(authentication.value, "client_type")
      vnet_solution   = lookup(authentication.value, "vnet_solution")

      dynamic "secret_store" {
        for_each = lookup(authentication.value, "secret_store") == null ? [] : ["secret_store"]
        content {
          key_vault_id = lookup(secret_store.value, "key_vault_id")
        }
      }
    }
  }
}

resource "azurerm_app_service_custom_hostname_binding" "this" {
  count = length(var.app_service_custom_hostname_binding) == "0" ? "0" : length(var.app_service)
  app_service_name = try(
    element(azurerm_app_service.this.*.name, lookup(var.app_service_custom_hostname_binding[count.index], "app_service_id"))
  )
  hostname            = lookup(var.app_service_custom_hostname_binding[count.index], "hostname")
  resource_group_name = data.azurerm_resource_group.this.name
  ssl_state           = lookup(var.app_service_custom_hostname_binding[count.index], "ssl_state")
  thumbprint          = lookup(var.app_service_custom_hostname_binding[count.index], "thumbprint")
}

resource "azurerm_app_service_environment" "this" {
  count                        = length(var.app_service_environment)
  name                         = lookup(var.app_service_environment[count.index], "name")
  resource_group_name          = data.azurerm_resource_group.this.name
  subnet_id                    = lookup(var.app_service_environment[count.index], "subnet_id")
  internal_load_balancing_mode = lookup(var.app_service_environment[count.index], "internal_load_balancing_mode")
  pricing_tier                 = lookup(var.app_service_environment[count.index], "pricing_tier")
  front_end_scale_factor       = lookup(var.app_service_environment[count.index], "front_end_scale_factor")
  allowed_user_ip_cidrs        = lookup(var.app_service_environment[count.index], "allowed_user_ip_cidrs")
  tags = merge(
    var.tags,
    lookup(var.app_service_environment[count.index], "tags")
  )

  dynamic "cluster_setting" {
    for_each = lookup(var.app_service_environment[count.index], "cluster_setting") == null ? [] : ["cluster_setting"]
    content {
      name  = lookup(cluster_setting.value, "name")
      value = lookup(cluster_setting.value, "value")
    }
  }
}

resource "azurerm_app_service_environment_v3" "this" {
  count                                  = length(var.app_service_environment_v3)
  name                                   = lookup(var.app_service_environment_v3[count.index], "name")
  resource_group_name                    = data.azurerm_resource_group.this.name
  subnet_id                              = lookup(var.app_service_environment_v3[count.index], "subnet_id")
  allow_new_private_endpoint_connections = lookup(var.app_service_environment_v3[count.index], "allow_new_private_endpoint_connections")
  dedicated_host_count                   = lookup(var.app_service_environment_v3[count.index], "dedicated_host_count")
  zone_redundant                         = lookup(var.app_service_environment_v3[count.index], "zone_redundant")
  internal_load_balancing_mode           = lookup(var.app_service_environment_v3[count.index], "internal_load_balancing_mode")
  tags = merge(
    var.tags,
    lookup(var.app_service_environment_v3[count.index], "tags")
  )

  dynamic "cluster_setting" {
    for_each = lookup(var.app_service_environment_v3[count.index], "cluster_setting") == null ? [] : ["cluster_setting"]
    content {
      name  = lookup(cluster_setting.value, "name")
      value = lookup(cluster_setting.value, "value")
    }
  }
}

resource "azurerm_app_service_hybrid_connection" "this" {
  count = length(var.app_service_hybrid_connection) == "0" ? "0" : (length(var.app_service))
  app_service_name = try(
    element(azurerm_app_service.this.*.name, lookup(var.app_service_hybrid_connection[count.index], "app_service_id"))
  )
  hostname            = lookup(var.app_service_hybrid_connection[count.index], "hostname")
  port                = lookup(var.app_service_hybrid_connection[count.index], "port")
  relay_id            = lookup(var.app_service_hybrid_connection[count.index], "relay_id")
  resource_group_name = data.azurerm_resource_group.this.name
  send_key_name       = lookup(var.app_service_hybrid_connection[count.index], "send_key_name")
}

resource "azurerm_app_service_managed_certificate" "this" {
  count = length(var.app_service_managed_certificate) == "0" ? "0" : (length(var.app_service_custom_hostname_binding))
  custom_hostname_binding_id = try(
    element(azurerm_app_service_custom_hostname_binding.this.*.id, lookup(var.app_service_managed_certificate[count.index], "custom_hostname_binding_id"))
  )
  tags = merge(
    var.tags,
    lookup(var.app_service_managed_certificate[count.index], "tags")
  )
}

resource "azurerm_app_service_plan" "this" {
  count                        = length(var.app_service_plan)
  location                     = data.azurerm_resource_group.this.location
  name                         = lookup(var.app_service_plan[count.index], "name")
  resource_group_name          = data.azurerm_resource_group.this.name
  kind                         = lookup(var.app_service_plan[count.index], "kind")
  maximum_elastic_worker_count = lookup(var.app_service_plan[count.index], "maximum_elastic_worker_count")
  reserved                     = lookup(var.app_service_plan[count.index], "reserved")
  per_site_scaling             = lookup(var.app_service_plan[count.index], "per_site_scaling")
  is_xenon                     = lookup(var.app_service_plan[count.index], "is_xenon")
  zone_redundant               = lookup(var.app_service_plan[count.index], "zone_redundant")
  tags = merge(
    var.tags,
    lookup(var.app_service_plan[count.index], "tags")
  )

  dynamic "sku" {
    for_each = lookup(var.app_service_plan[count.index], "sku") == null ? [] : ["sku"]
    content {
      size     = lookup(sku.value, "size")
      tier     = lookup(sku.value, "tier")
      capacity = lookup(sku.value, "capacity")
    }
  }
}

resource "azurerm_app_service_public_certificate" "this" {
  count = length(var.app_service_public_certificate) == "0" ? "0" : (length(var.app_service))
  app_service_name = try(
    element(azurerm_app_service.this.*.name, lookup(var.app_service_public_certificate[count.index], "app_service_id"))
  )
  blob                 = lookup(var.app_service_public_certificate[count.index], "blob")
  certificate_location = lookup(var.app_service_public_certificate[count.index], "certificate_location")
  certificate_name     = lookup(var.app_service_public_certificate[count.index], "certificate_name")
  resource_group_name  = data.azurerm_resource_group.this.name
}

resource "azurerm_app_service_slot" "this" {
  count = length(var.app_service_slot) == "0" ? "0" : (length(var.app_service) && length(var.app_service_plan))
  app_service_name = try(
    element(azurerm_app_service.this.*.name, lookup(var.app_service_slot[count.index], "app_service_id"))
  )
  app_service_plan_id = try(
    element(azurerm_app_service_plan.this.*.id, lookup(var.app_service_slot[count.index], "app_service_plan_id"))
  )
  location                        = data.azurerm_resource_group.this.location
  name                            = lookup(var.app_service_slot[count.index], "name")
  resource_group_name             = data.azurerm_resource_group.this.name
  app_settings                    = lookup(var.app_service_slot[count.index], "app_settings")
  client_affinity_enabled         = lookup(var.app_service_slot[count.index], "client_affinity_enabled")
  enabled                         = lookup(var.app_service_slot[count.index], "enabled")
  https_only                      = lookup(var.app_service_slot[count.index], "https_only")
  key_vault_reference_identity_id = lookup(var.app_service_slot[count.index], "key_vault_reference_identity_id")
  tags = merge(
    var.tags,
    lookup(var.app_service_slot[count.index], "tags")
  )

  dynamic "auth_settings" {
    for_each = lookup(var.app_service_slot[count.index], "auth_settings") == null ? [] : ["auth_settings"]
    content {
      enabled                        = lookup(auth_settings.value, "enabled")
      additional_login_params        = lookup(auth_settings.value, "additional_login_params")
      allowed_external_redirect_urls = lookup(auth_settings.value, "allowed_external_redirect_urls")
      default_provider               = lookup(auth_settings.value, "default_provider")
      runtime_version                = lookup(auth_settings.value, "runtime_version")
      token_refresh_extension_hours  = lookup(auth_settings.value, "token_refresh_extension_hours")
      token_store_enabled            = lookup(auth_settings.value, "token_store_enabled")
      unauthenticated_client_action  = lookup(auth_settings.value, "unauthenticated_client_action")

      dynamic "active_directory" {
        for_each = lookup(auth_settings.value, "active_directory") == null ? [] : ["active_directory"]
        content {
          client_id         = lookup(active_directory.value, "client_id")
          client_secret     = lookup(active_directory.value, "client_secret")
          allowed_audiences = lookup(active_directory.value, "allowed_audiences")
        }
      }

      dynamic "facebook" {
        for_each = lookup(auth_settings.value, "facebook") == null ? [] : ["facebook"]
        content {
          app_id       = lookup(facebook.value, "app_id")
          app_secret   = lookup(facebook.value, "app_secret")
          oauth_scopes = lookup(facebook.value, "oauth_scopes")
        }
      }

      dynamic "microsoft" {
        for_each = lookup(auth_settings.value, "microsoft") == null ? [] : ["microsoft"]
        content {
          client_id     = lookup(microsoft.value, "client_id")
          client_secret = lookup(microsoft.value, "client_secret")
          oauth_scopes  = lookup(microsoft.value, "oauth_scopes")
        }
      }

      dynamic "google" {
        for_each = lookup(auth_settings.value, "google") == null ? [] : ["google"]
        content {
          client_id     = lookup(google.value, "client_id")
          client_secret = lookup(google.value, "client_secret")
          oauth_scopes  = lookup(google.value, "oauth_scopes")
        }
      }

      dynamic "twitter" {
        for_each = lookup(auth_settings.value, "twitter") == null ? [] : ["twitter"]
        content {
          consumer_key    = lookup(twitter.value, "consumer_key")
          consumer_secret = lookup(twitter.value, "consumer_secret")
        }
      }
    }
  }

  dynamic "connection_string" {
    for_each = lookup(var.app_service_slot[count.index], "connection_string") == null ? [] : ["connection_string"]
    content {
      name  = lookup(connection_string.value, "name")
      type  = lookup(connection_string.value, "type")
      value = lookup(connection_string.value, "value")
    }
  }

  dynamic "site_config" {
    for_each = lookup(var.app_service_slot[count.index], "site_config") == null ? [] : ["site_config"]
    content {
      acr_use_managed_identity_credentials = lookup(site_config.value, "acr_use_managed_identity_credentials")
      acr_user_managed_identity_client_id  = lookup(site_config.value, "acr_user_managed_identity_client_id")
      always_on                            = lookup(site_config.value, "always_on")
      app_command_line                     = lookup(site_config.value, "app_command_line")
      auto_swap_slot_name                  = lookup(site_config.value, "auto_swap_slot_name")
      default_documents                    = lookup(site_config.value, "default_documents")
      dotnet_framework_version             = lookup(site_config.value, "dotnet_framework_version")
      ftps_state                           = lookup(site_config.value, "ftps_state")
      health_check_path                    = lookup(site_config.value, "health_check_path")
      number_of_workers                    = lookup(site_config.value, "number_of_workers")
      http2_enabled                        = lookup(site_config.value, "http2_enabled")
      scm_use_main_ip_restriction          = lookup(site_config.value, "scm_use_main_ip_restriction")
      java_container                       = lookup(site_config.value, "java_container")
      java_container_version               = lookup(site_config.value, "java_container_version")
      java_version                         = lookup(site_config.value, "java_version")
      local_mysql_enabled                  = lookup(site_config.value, "local_mysql_enabled")
      linux_fx_version                     = lookup(site_config.value, "linux_fx_version")
      windows_fx_version                   = lookup(site_config.value, "windows_fx_version")
      managed_pipeline_mode                = lookup(site_config.value, "managed_pipeline_mode")
      min_tls_version                      = lookup(site_config.value, "min_tls_version")
      php_version                          = lookup(site_config.value, "php_version")
      python_version                       = lookup(site_config.value, "python_version")
      remote_debugging_enabled             = lookup(site_config.value, "remote_debugging_enabled")
      remote_debugging_version             = lookup(site_config.value, "remote_debugging_version")
      scm_type                             = lookup(site_config.value, "scm_type")
      use_32_bit_worker_process            = lookup(site_config.value, "use_32_bit_worker_process")
      vnet_route_all_enabled               = lookup(site_config.value, "vnet_route_all_enabled")
      websockets_enabled                   = lookup(site_config.value, "websockets_enabled")

      dynamic "cors" {
        for_each = lookup(site_config.value, "cors") == null ? [] : ["cors"]
        content {
          allowed_origins     = lookup(cors.value, "allowed_origins")
          support_credentials = lookup(cors.value, "support_credentials")
        }
      }

      dynamic "ip_restriction" {
        for_each = lookup(site_config.value, "ip_restriction") == null ? [] : ["ip_restriction"]
        content {
          ip_address                = lookup(ip_restriction.value, "ip_address")
          service_tag               = lookup(ip_restriction.value, "service_tag")
          virtual_network_subnet_id = lookup(ip_restriction.value, "virtual_network_subnet_id")
          name                      = lookup(ip_restriction.value, "name")
          priority                  = lookup(ip_restriction.value, "priority")
          action                    = lookup(ip_restriction.value, "action")
          headers                   = lookup(ip_restriction.value, "headers")
        }
      }

      dynamic "scm_ip_restriction" {
        for_each = lookup(site_config.value, "scm_ip_restriction") == null ? [] : ["scm_ip_restriction"]
        content {
          ip_address                = lookup(scm_ip_restriction.value, "ip_address")
          service_tag               = lookup(scm_ip_restriction.value, "service_tag")
          virtual_network_subnet_id = lookup(scm_ip_restriction.value, "virtual_network_subnet_id")
          name                      = lookup(scm_ip_restriction.value, "name")
          priority                  = lookup(scm_ip_restriction.value, "priority")
          action                    = lookup(scm_ip_restriction.value, "action")
          headers                   = lookup(scm_ip_restriction.value, "headers")
        }
      }
    }
  }

  dynamic "storage_account" {
    for_each = lookup(var.app_service_slot[count.index], "storage_account") == null ? [] : ["storage_account"]
    content {
      access_key   = lookup(storage_account.value, "access_key")
      account_name = lookup(storage_account.value, "account_name")
      name         = lookup(storage_account.value, "name")
      share_name   = lookup(storage_account.value, "share_name")
      type         = lookup(storage_account.value, "type")
      mount_path   = lookup(storage_account.value, "mount_path")
    }
  }

  dynamic "logs" {
    for_each = lookup(var.app_service_slot[count.index], "logs") == null ? [] : ["logs"]
    content {
      detailed_error_messages_enabled = lookup(logs.value, "detailed_error_messages_enabled")
      failed_request_tracing_enabled  = lookup(logs.value, "failed_request_tracing_enabled")

      dynamic "http_logs" {
        for_each = lookup(logs.value, "http_logs") == null ? [] : ["http_logs"]
        content {
          dynamic "file_system" {
            for_each = lookup(http_logs.value, "file_system") == null ? [] : ["file_system"]
            content {
              retention_in_days = lookup(file_system.value, "retention_in_days")
              retention_in_mb   = lookup(file_system.value, "retention_in_mb")
            }
          }

          dynamic "azure_blob_storage" {
            for_each = lookup(http_logs.value, "azure_blob_storage") == null ? [] : ["azure_blob_storage"]
            content {
              retention_in_days = lookup(azure_blob_storage.value, "retention_in_days")
              sas_url           = lookup(azure_blob_storage.value, "sas_url")
              level             = lookup(azure_blob_storage.value, "level")
            }
          }
        }
      }
      dynamic "application_logs" {
        for_each = lookup(logs.value, "application_logs") == null ? [] : ["application_logs"]
        content {
          file_system_level = lookup(application_logs.value, "file_system_level")
          dynamic "azure_blob_storage" {
            for_each = lookup(application_logs.value, "azure_blob_storage") == null ? [] : ["azure_blob_storage"]
            content {
              level             = lookup(azure_blob_storage.value, "level")
              retention_in_days = lookup(azure_blob_storage.value, "retention_in_days")
              sas_url           = lookup(azure_blob_storage.value, "sas_url")
            }
          }
        }
      }
    }
  }

  dynamic "identity" {
    for_each = lookup(var.app_service_slot[count.index], "identity") == null ? [] : ["identity"]
    content {
      type         = lookup(identity.value, "type")
      identity_ids = lookup(identity.value, "identity_ids")
    }
  }
}

resource "azurerm_app_service_slot_custom_hostname_binding" "this" {
  count = length(var.app_service_slot_custom_hostname_binding) == "0" ? "0" : length(var.app_service_slot)
  app_service_slot_id = try(
    element(azurerm_app_service_slot.this.*.id, lookup(var.app_service_slot_custom_hostname_binding[count.index], "app_service_slot_id"))
  )
  hostname   = lookup(var.app_service_slot_custom_hostname_binding[count.index], "hostname")
  ssl_state  = lookup(var.app_service_slot_custom_hostname_binding[count.index], "ssl_state")
  thumbprint = lookup(var.app_service_slot_custom_hostname_binding[count.index], "thumbprint")
}

resource "azurerm_app_service_slot_virtual_network_swift_connection" "this" {
  count = length(var.app_service_slot_virtual_network_swift_connection) == "0" ? "0" : (length(var.app_service) && length(var.app_service_slot))
  app_service_id = try(
    element(azurerm_app_service.this.*.id, lookup(var.app_service_slot_virtual_network_swift_connection[count.index], "app_service_id"))
  )
  slot_name = try(
    element(azurerm_app_service_slot.this.*.name, lookup(var.app_service_slot_virtual_network_swift_connection[count.index], "slot_id"))
  )
  subnet_id = lookup(var.app_service_slot_virtual_network_swift_connection[count.index], "subnet_id")
}

resource "azurerm_app_service_source_control" "this" {
  count = length(var.app_service_source_control) == "0" ? "0" : (length(var.linux_web_app) || length(var.windows_function_app))
  app_id = try(
    element(azurerm_linux_web_app.this.*.id, lookup(var.app_service_source_control[count.index], "app_id")),
    element(azurerm_windows_web_app.this.*.id, lookup(var.app_service_source_control[count.index], "app_id"))
  )
  branch                 = lookup(var.app_service_source_control[count.index], "branch")
  repo_url               = lookup(var.app_service_source_control[count.index], "repo_url")
  use_manual_integration = lookup(var.app_service_source_control[count.index], "use_manual_integration")
  rollback_enabled       = lookup(var.app_service_source_control[count.index], "rollback_enabled")
  use_local_git          = lookup(var.app_service_source_control[count.index], "use_local_git")
  use_mercurial          = lookup(var.app_service_source_control[count.index], "use_mercurial")

  dynamic "github_action_configuration" {
    for_each = lookup(var.app_service_source_control[count.index], "github_action_configuration") == null ? [] : ["github_action_configuration"]
    content {
      generate_workflow_file = lookup(github_action_configuration.value, "generate_workflow_file")

      dynamic "code_configuration" {
        for_each = lookup(github_action_configuration.value, "code_configuration") == null ? [] : ["code_configuration"]
        content {
          runtime_stack   = lookup(code_configuration.value, "runtime_stack")
          runtime_version = lookup(code_configuration.value, "runtime_version")
        }
      }

      dynamic "container_configuration" {
        for_each = lookup(github_action_configuration.value, "container_configuration") == null ? [] : ["container_configuration"]
        content {
          image_name        = lookup(container_configuration.value, "image_name")
          registry_url      = lookup(container_configuration.value, "registry_url")
          registry_password = lookup(container_configuration.value, "registry_password")
          registry_username = lookup(container_configuration.value, "registry_username")
        }
      }
    }
  }
}

resource "azurerm_app_service_source_control_slot" "this" {
  count = length(var.app_service_source_control_slot) == "0" ? "0" : (length(var.linux_web_app_slot) || length(var.windows_web_app_slot))
  slot_id = try(
    element(azurerm_linux_web_app_slot.this.*.id, lookup(var.app_service_source_control_slot[count.index], "slot_id")),
    element(azurerm_windows_web_app_slot.this.*.id, lookup(var.app_service_source_control_slot[count.index], "slot_id"))
  )
  branch                 = lookup(var.app_service_source_control_slot[count.index], "branch")
  repo_url               = lookup(var.app_service_source_control_slot[count.index], "repo_url")
  rollback_enabled       = lookup(var.app_service_source_control_slot[count.index], "rollback_enabled")
  use_local_git          = lookup(var.app_service_source_control_slot[count.index], "use_local_git")
  use_manual_integration = lookup(var.app_service_source_control_slot[count.index], "use_manual_integration")
  use_mercurial          = lookup(var.app_service_source_control_slot[count.index], "use_mercurial")

  dynamic "github_action_configuration" {
    for_each = lookup(var.app_service_source_control_slot[count.index], "github_action_configuration") == null ? [] : ["github_action_configuration"]
    content {
      generate_workflow_file = lookup(github_action_configuration.value, "generate_workflow_file")

      dynamic "code_configuration" {
        for_each = lookup(github_action_configuration.value, "code_configuration") == null ? [] : ["code_configuration"]
        content {
          runtime_stack   = lookup(code_configuration.value, "runtime_stack")
          runtime_version = lookup(code_configuration.value, "runtime_version")
        }
      }

      dynamic "container_configuration" {
        for_each = lookup(github_action_configuration.value, "container_configuration") == null ? [] : ["container_configuration"]
        content {
          image_name        = lookup(container_configuration.value, "image_name")
          registry_url      = lookup(container_configuration.value, "registry_url")
          registry_password = lookup(container_configuration.value, "registry_password")
          registry_username = lookup(container_configuration.value, "registry_username")
        }
      }
    }
  }
}

resource "azurerm_app_service_source_control_token" "this" {
  count        = length(var.app_service_source_control_token)
  token        = lookup(var.app_service_source_control_token[count.index], "token")
  type         = lookup(var.app_service_source_control_token[count.index], "type")
  token_secret = lookup(var.app_service_source_control_token[count.index], "token_secret")
}

resource "azurerm_app_service_virtual_network_swift_connection" "this" {
  count = length(var.app_service_slot_virtual_network_swift_connection) == "0" ? "0" : (length(var.app_service) || length(var.function_app))
  app_service_id = try(
    element(azurerm_app_service.this.*.id, lookup(var.app_service_slot_virtual_network_swift_connection[count.index], "app_service_id")),
    element(azurerm_function_app.this.*.id, lookup(var.app_service_slot_virtual_network_swift_connection[count.index], "app_service_id"))
  )
  subnet_id = lookup(var.app_service_slot_virtual_network_swift_connection[count.index], "subnet_id")
}

resource "azurerm_function_app" "this" {
  count = length(var.function_app) == "0" ? "0" : (length(var.app_service_plan))
  app_service_plan_id = try(
    element(azurerm_app_service_plan.this.*.id, lookup(var.function_app[count.index], "app_service_plan_id"))
  )
  location                        = data.azurerm_resource_group.this.location
  name                            = lookup(var.function_app[count.index], "name")
  resource_group_name             = data.azurerm_resource_group.this.name
  storage_account_access_key      = lookup(var.function_app[count.index], "storage_account_access_key")
  storage_account_name            = lookup(var.function_app[count.index], "storage_account_name")
  app_settings                    = lookup(var.function_app[count.index], "app_settings")
  client_cert_mode                = lookup(var.function_app[count.index], "client_cert_mode")
  daily_memory_time_quota         = lookup(var.function_app[count.index], "daily_memory_time_quota")
  enabled                         = lookup(var.function_app[count.index], "enabled")
  enable_builtin_logging          = lookup(var.function_app[count.index], "enable_builtin_logging")
  https_only                      = lookup(var.function_app[count.index], "https_only")
  key_vault_reference_identity_id = lookup(var.function_app[count.index], "key_vault_reference_identity_id")
  os_type                         = lookup(var.function_app[count.index], "os_type")
  version                         = lookup(var.function_app[count.index], "version")
  tags = merge(
    var.tags,
    lookup(var.function_app[count.index], "tags")
  )

  dynamic "auth_settings" {
    for_each = lookup(var.function_app[count.index], "auth_settings") == null ? [] : ["auth_settings"]
    content {
      enabled                        = lookup(auth_settings.value, "enabled")
      additional_login_params        = lookup(auth_settings.value, "additional_login_params")
      allowed_external_redirect_urls = lookup(auth_settings.value, "allowed_external_redirect_urls")
      default_provider               = lookup(auth_settings.value, "default_provider")
      unauthenticated_client_action  = lookup(auth_settings.value, "unauthenticated_client_action")
      issuer                         = lookup(auth_settings.value, "issuer")
      runtime_version                = lookup(auth_settings.value, "runtime_version")
      token_refresh_extension_hours  = lookup(auth_settings.value, "token_refresh_extension_hours")
      token_store_enabled            = lookup(auth_settings.value, "token_store_enabled")

      dynamic "active_directory" {
        for_each = lookup(auth_settings.value, "active_directory") == null ? [] : ["active_directory"]
        content {
          client_id         = lookup(active_directory.value, "client_id")
          client_secret     = lookup(active_directory.value, "client_secret")
          allowed_audiences = lookup(active_directory.value, "allowed_audiences")
        }
      }

      dynamic "facebook" {
        for_each = lookup(auth_settings.value, "facebook") == null ? [] : ["facebook"]
        content {
          app_id       = lookup(facebook.value, "app_id")
          app_secret   = lookup(facebook.value, "app_secret")
          oauth_scopes = lookup(facebook.value, "oauth_scopes")
        }
      }

      dynamic "microsoft" {
        for_each = lookup(auth_settings.value, "microsoft") == null ? [] : ["microsoft"]
        content {
          client_id     = lookup(microsoft.value, "client_id")
          client_secret = lookup(microsoft.value, "client_secret")
          oauth_scopes  = lookup(microsoft.value, "oauth_scopes")
        }
      }

      dynamic "google" {
        for_each = lookup(auth_settings.value, "google") == null ? [] : ["google"]
        content {
          client_id     = lookup(google.value, "client_id")
          client_secret = lookup(google.value, "client_secret")
          oauth_scopes  = lookup(google.value, "oauth_scopes")
        }
      }

      dynamic "twitter" {
        for_each = lookup(auth_settings.value, "twitter") == null ? [] : ["twitter"]
        content {
          consumer_key    = lookup(twitter.value, "consumer_key")
          consumer_secret = lookup(twitter.value, "consumer_secret")
        }
      }
    }
  }

  dynamic "connection_string" {
    for_each = lookup(var.function_app[count.index], "connection_string") == null ? [] : ["connection_string"]
    content {
      name  = lookup(connection_string.value, "name")
      type  = lookup(connection_string.value, "type")
      value = lookup(connection_string.value, "value")
    }
  }

  dynamic "identity" {
    for_each = lookup(var.function_app[count.index], "identity") == null ? [] : ["identity"]
    content {
      type         = lookup(identity.value, "type")
      identity_ids = lookup(identity.value, "identity_ids")
    }
  }

  dynamic "site_config" {
    for_each = lookup(var.function_app[count.index], "site_config") == null ? [] : ["site_config"]
    content {
      always_on                   = lookup(site_config.value, "always_on")
      app_scale_limit             = lookup(site_config.value, "app_scale_limit")
      dotnet_framework_version    = lookup(site_config.value, "dotnet_framework_version")
      elastic_instance_minimum    = lookup(site_config.value, "elastic_instance_minimum")
      ftps_state                  = lookup(site_config.value, "ftps_state")
      health_check_path           = lookup(site_config.value, "health_check_path")
      http2_enabled               = lookup(site_config.value, "http2_enabled")
      java_version                = lookup(site_config.value, "java_version")
      linux_fx_version            = lookup(site_config.value, "linux_fx_version")
      min_tls_version             = lookup(site_config.value, "min_tls_version")
      pre_warmed_instance_count   = lookup(site_config.value, "pre_warmed_instance_count")
      scm_type                    = lookup(site_config.value, "scm_type")
      scm_use_main_ip_restriction = lookup(site_config.value, "scm_use_main_ip_restriction")
      use_32_bit_worker_process   = lookup(site_config.value, "use_32_bit_worker_process")
      vnet_route_all_enabled      = lookup(site_config.value, "vnet_route_all_enabled")
      websockets_enabled          = lookup(site_config.value, "websockets_enabled")
      auto_swap_slot_name         = lookup(site_config.value, "auto_swap_slot_name")

      dynamic "cors" {
        for_each = lookup(site_config.value, "cors") == null ? [] : ["cors"]
        content {
          allowed_origins     = lookup(cors.value, "allowed_origins")
          support_credentials = lookup(cors.value, "support_credentials")
        }
      }

      dynamic "ip_restriction" {
        for_each = lookup(site_config.value, "ip_restriction") == null ? [] : ["ip_restriction"]
        content {
          ip_address                = lookup(ip_restriction.value, "ip_address")
          service_tag               = lookup(ip_restriction.value, "service_tag")
          virtual_network_subnet_id = lookup(ip_restriction.value, "virtual_network_subnet_id")
          name                      = lookup(ip_restriction.value, "name")
          priority                  = lookup(ip_restriction.value, "priority")
          action                    = lookup(ip_restriction.value, "action")
          headers                   = lookup(ip_restriction.value, "headers")
        }
      }

      dynamic "scm_ip_restriction" {
        for_each = lookup(site_config.value, "scm_ip_restriction") == null ? [] : ["scm_ip_restriction"]
        content {
          ip_address                = lookup(scm_ip_restriction.value, "ip_address")
          service_tag               = lookup(scm_ip_restriction.value, "service_tag")
          virtual_network_subnet_id = lookup(scm_ip_restriction.value, "virtual_network_subnet_id")
          name                      = lookup(scm_ip_restriction.value, "name")
          priority                  = lookup(scm_ip_restriction.value, "priority")
          action                    = lookup(scm_ip_restriction.value, "action")
          headers                   = lookup(scm_ip_restriction.value, "headers")
        }
      }
    }
  }

  dynamic "source_control" {
    for_each = lookup(var.function_app[count.index], "source_control") == null ? [] : ["source_control"]
    content {
      repo_url           = lookup(source_control.value, "repo_url")
      branch             = lookup(source_control.value, "branch")
      manual_integration = lookup(source_control.value, "manual_integration")
      rollback_enabled   = lookup(source_control.value, "rollback_enabled")
      use_mercurial      = lookup(source_control.value, "use_mercurial")
    }
  }
}

resource "azurerm_function_app_active_slot" "this" {
  count = length(var.function_app_active_slot) == "0" ? "0" : (length(var.linux_function_app_slot) || length(var.windows_function_app_slot))
  slot_id = try(
    element(azurerm_linux_function_app_slot.this.*.id, lookup(var.function_app_active_slot[count.index], "slot_id")),
    element(azurerm_windows_function_app_slot.this.*.id, lookup(var.function_app_active_slot[count.index], "slot_id"))
  )
}

resource "azurerm_function_app_connection" "this" {
  count = length(var.function_app_connection) == "0" ? "0" : length(var.function_app)
  name  = lookup(var.function_app_connection[count.index], "name")
  function_app_id = try(
    element(azurerm_function_app.this.*.name, lookup(var.function_app_connection[count.index], "function_app_id"))
  )
  target_resource_id = lookup(var.function_app_connection[count.index], "target_resource_id")
}

resource "azurerm_function_app_function" "this" {
  count       = length(var.function_app_function) == "0" ? "0" : length(var.function_app)
  config_json = lookup(var.function_app_function[count.index], "config_json")
  function_app_id = try(
    element(azurerm_function_app.this.*.id, lookup(var.function_app_function[count.index], "function_app_id"))
  )
  name      = lookup(var.function_app_function[count.index], "name")
  enabled   = lookup(var.function_app_function[count.index], "enabled")
  language  = lookup(var.function_app_function[count.index], "language")
  test_data = lookup(var.function_app_function[count.index], "test_data")

  dynamic "file" {
    for_each = lookup(var.function_app_function[count.index], "file") == null ? [] : ["file"]
    content {
      content = lookup(file.value, "content")
      name    = lookup(file.value, "name")
    }
  }
}

resource "azurerm_function_app_hybrid_connection" "this" {
  count = length(var.function_app_hybrid_connection) == "0" ? "0" : length(var.function_app)
  function_app_id = try(
    element(azurerm_function_app.this.*.name, lookup(var.function_app_hybrid_connection[count.index], "function_app_id"))
  )
  hostname      = lookup(var.function_app_hybrid_connection[count.index], "hostname")
  port          = lookup(var.function_app_hybrid_connection[count.index], "port")
  relay_id      = lookup(var.function_app_hybrid_connection[count.index], "relay_id")
  send_key_name = lookup(var.function_app_hybrid_connection[count.index], "send_key_name")
}

resource "azurerm_function_app_slot" "this" {
  count = length(var.function_app_slot) == "0" ? "0" : (length(var.app_service_plan) && length(var.function_app))
  app_service_plan_id = try(
    element(azurerm_app_service_plan.this.*.id, lookup(var.function_app_slot[count.index], "app_service_plan_id"))
  )
  function_app_name = try(
    element(azurerm_function_app.this.*.name, lookup(var.function_app_slot[count.index], "function_app_id"))
  )
  location                   = data.azurerm_resource_group.this.location
  name                       = lookup(var.function_app_slot[count.index], "name")
  resource_group_name        = data.azurerm_resource_group.this.name
  storage_account_access_key = lookup(var.function_app_slot[count.index], "storage_account_access_key")
  storage_account_name       = lookup(var.function_app_slot[count.index], "storage_account_name")
  app_settings               = lookup(var.function_app_slot[count.index], "app_settings")
  enable_builtin_logging     = lookup(var.function_app_slot[count.index], "enable_builtin_logging")
  os_type                    = lookup(var.function_app_slot[count.index], "os_type")
  enabled                    = lookup(var.function_app_slot[count.index], "enabled")
  https_only                 = lookup(var.function_app_slot[count.index], "https_only")
  version                    = lookup(var.function_app_slot[count.index], "version")
  daily_memory_time_quota    = lookup(var.function_app_slot[count.index], "daily_memory_time_quota")
  tags = merge(
    var.tags,
    lookup(var.function_app_slot[count.index], "tags")
  )

  dynamic "auth_settings" {
    for_each = lookup(var.function_app_slot[count.index], "auth_settings") == null ? [] : ["auth_settings"]
    content {
      enabled                        = lookup(auth_settings.value, "enabled")
      additional_login_params        = lookup(auth_settings.value, "additional_login_params")
      allowed_external_redirect_urls = lookup(auth_settings.value, "allowed_external_redirect_urls")
      default_provider               = lookup(auth_settings.value, "default_provider")
      unauthenticated_client_action  = lookup(auth_settings.value, "unauthenticated_client_action")
      issuer                         = lookup(auth_settings.value, "issuer")
      runtime_version                = lookup(auth_settings.value, "runtime_version")
      token_refresh_extension_hours  = lookup(auth_settings.value, "token_refresh_extension_hours")
      token_store_enabled            = lookup(auth_settings.value, "token_store_enabled")

      dynamic "active_directory" {
        for_each = lookup(auth_settings.value, "active_directory") == null ? [] : ["active_directory"]
        content {
          client_id         = lookup(active_directory.value, "client_id")
          client_secret     = lookup(active_directory.value, "client_secret")
          allowed_audiences = lookup(active_directory.value, "allowed_audiences")
        }
      }

      dynamic "facebook" {
        for_each = lookup(auth_settings.value, "facebook") == null ? [] : ["facebook"]
        content {
          app_id       = lookup(facebook.value, "app_id")
          app_secret   = lookup(facebook.value, "app_secret")
          oauth_scopes = lookup(facebook.value, "oauth_scopes")
        }
      }

      dynamic "microsoft" {
        for_each = lookup(auth_settings.value, "microsoft") == null ? [] : ["microsoft"]
        content {
          client_id     = lookup(microsoft.value, "client_id")
          client_secret = lookup(microsoft.value, "client_secret")
          oauth_scopes  = lookup(microsoft.value, "oauth_scopes")
        }
      }

      dynamic "google" {
        for_each = lookup(auth_settings.value, "google") == null ? [] : ["google"]
        content {
          client_id     = lookup(google.value, "client_id")
          client_secret = lookup(google.value, "client_secret")
          oauth_scopes  = lookup(google.value, "oauth_scopes")
        }
      }

      dynamic "twitter" {
        for_each = lookup(auth_settings.value, "twitter") == null ? [] : ["twitter"]
        content {
          consumer_key    = lookup(twitter.value, "consumer_key")
          consumer_secret = lookup(twitter.value, "consumer_secret")
        }
      }
    }
  }

  dynamic "connection_string" {
    for_each = lookup(var.function_app_slot[count.index], "connection_string") == null ? [] : ["connection_string"]
    content {
      name  = lookup(connection_string.value, "name")
      type  = lookup(connection_string.value, "type")
      value = lookup(connection_string.value, "value")
    }
  }

  dynamic "identity" {
    for_each = lookup(var.function_app_slot[count.index], "identity") == null ? [] : ["identity"]
    content {
      type         = lookup(identity.value, "type")
      identity_ids = lookup(identity.value, "identity_ids")
    }
  }

  dynamic "site_config" {
    for_each = lookup(var.function_app_slot[count.index], "site_config") == null ? [] : ["site_config"]
    content {
      always_on                        = lookup(site_config.value, "always_on")
      use_32_bit_worker_process        = lookup(site_config.value, "use_32_bit_worker_process")
      scm_use_main_ip_restriction      = lookup(site_config.value, "scm_use_main_ip_restriction")
      websockets_enabled               = lookup(site_config.value, "websockets_enabled")
      http2_enabled                    = lookup(site_config.value, "http2_enabled")
      runtime_scale_monitoring_enabled = lookup(site_config.value, "runtime_scale_monitoring_enabled")
      linux_fx_version                 = lookup(site_config.value, "linux_fx_version")
      java_version                     = lookup(site_config.value, "java_version")
      min_tls_version                  = lookup(site_config.value, "min_tls_version")
      ftps_state                       = lookup(site_config.value, "ftps_state")
      health_check_path                = lookup(site_config.value, "health_check_path")
      scm_type                         = lookup(site_config.value, "scm_type")
      dotnet_framework_version         = lookup(site_config.value, "dotnet_framework_version")
      app_scale_limit                  = lookup(site_config.value, "app_scale_limit")
      elastic_instance_minimum         = lookup(site_config.value, "elastic_instance_minimum")
      pre_warmed_instance_count        = lookup(site_config.value, "pre_warmed_instance_count")

      dynamic "cors" {
        for_each = lookup(site_config.value, "cors") == null ? [] : ["cors"]
        content {
          allowed_origins     = lookup(cors.value, "allowed_origins")
          support_credentials = lookup(cors.value, "support_credentials")
        }
      }

      dynamic "ip_restriction" {
        for_each = lookup(site_config.value, "ip_restriction") == null ? [] : ["ip_restriction"]
        content {
          ip_address                = lookup(ip_restriction.value, "ip_address")
          service_tag               = lookup(ip_restriction.value, "service_tag")
          virtual_network_subnet_id = lookup(ip_restriction.value, "virtual_network_subnet_id")
          name                      = lookup(ip_restriction.value, "name")
          priority                  = lookup(ip_restriction.value, "priority")
          action                    = lookup(ip_restriction.value, "action")
          headers                   = lookup(ip_restriction.value, "headers")
        }
      }

      dynamic "scm_ip_restriction" {
        for_each = lookup(site_config.value, "scm_ip_restriction") == null ? [] : ["scm_ip_restriction"]
        content {
          ip_address                = lookup(scm_ip_restriction.value, "ip_address")
          service_tag               = lookup(scm_ip_restriction.value, "service_tag")
          virtual_network_subnet_id = lookup(scm_ip_restriction.value, "virtual_network_subnet_id")
          name                      = lookup(scm_ip_restriction.value, "name")
          priority                  = lookup(scm_ip_restriction.value, "priority")
          action                    = lookup(scm_ip_restriction.value, "action")
          headers                   = lookup(scm_ip_restriction.value, "headers")
        }
      }
    }
  }
}

resource "azurerm_linux_function_app" "this" {
  count               = length(var.linux_function_app) == "0" ? "0" : length(var.service_plan)
  location            = data.azurerm_resource_group.this.location
  name                = lookup(var.linux_function_app[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.name
  service_plan_id = try(
    element(azurerm_service_plan.this.*.id, lookup(var.linux_function_app[count.index], "service_plan_id"))
  )
  builtin_logging_enabled                        = lookup(var.linux_function_app[count.index], "builtin_logging_enabled")
  client_certificate_enabled                     = lookup(var.linux_function_app[count.index], "client_certificate_enabled")
  enabled                                        = lookup(var.linux_function_app[count.index], "enabled")
  content_share_force_disabled                   = lookup(var.linux_function_app[count.index], "content_share_force_disabled")
  ftp_publish_basic_authentication_enabled       = lookup(var.linux_function_app[count.index], "ftp_publish_basic_authentication_enabled")
  https_only                                     = lookup(var.linux_function_app[count.index], "https_only")
  public_network_access_enabled                  = lookup(var.linux_function_app[count.index], "public_network_access_enabled")
  storage_uses_managed_identity                  = lookup(var.linux_function_app[count.index], "storage_uses_managed_identity")
  webdeploy_publish_basic_authentication_enabled = lookup(var.linux_function_app[count.index], "webdeploy_publish_basic_authentication_enabled")
  client_certificate_exclusion_paths             = lookup(var.linux_function_app[count.index], "client_certificate_exclusion_paths")
  client_certificate_mode                        = lookup(var.linux_function_app[count.index], "client_certificate_mode")
  functions_extension_version                    = lookup(var.linux_function_app[count.index], "functions_extension_version")
  key_vault_reference_identity_id                = lookup(var.linux_function_app[count.index], "key_vault_reference_identity_id")
  storage_account_access_key                     = lookup(var.linux_function_app[count.index], "storage_account_access_key")
  storage_account_name                           = lookup(var.linux_function_app[count.index], "storage_account_name")
  storage_key_vault_secret_id                    = lookup(var.linux_function_app[count.index], "storage_key_vault_secret_id")
  virtual_network_subnet_id                      = lookup(var.linux_function_app[count.index], "virtual_network_subnet_id")
  zip_deploy_file                                = lookup(var.linux_function_app[count.index], "zip_deploy_file")
  daily_memory_time_quota                        = lookup(var.linux_function_app[count.index], "daily_memory_time_quota")
  app_settings                                   = lookup(var.linux_function_app[count.index], "app_settings")
  tags                                           = merge(
    var.tags,
    lookup(var.linux_function_app[count.index], "tags")
  )

  dynamic "auth_settings" {
    for_each = lookup(var.linux_function_app[count.index], "auth_settings") == null ? [] : ["auth_settings"]
    content {
      enabled                        = lookup(auth_settings.value, "enabled")
      token_store_enabled            = lookup(auth_settings.value, "token_store_enabled")
      additional_login_parameters    = lookup(auth_settings.value, "additional_login_parameters")
      allowed_external_redirect_urls = lookup(auth_settings.value, "allowed_external_redirect_urls")
      default_provider               = lookup(auth_settings.value, "default_provider")
      issuer                         = lookup(auth_settings.value, "issuer")
      runtime_version                = lookup(auth_settings.value, "runtime_version")
      unauthenticated_client_action  = lookup(auth_settings.value, "unauthenticated_client_action")
      token_refresh_extension_hours  = lookup(auth_settings.value, "token_refresh_extension_hours")

      dynamic "facebook" {
        for_each = lookup(auth_settings.value, "facebook") == null ? [] : ["facebook"]
        content {
          app_id                  = lookup(facebook.value, "app_id")
          app_secret              = lookup(facebook.value, "app_secret")
          app_secret_setting_name = lookup(facebook.value, "app_secret_setting_name")
          oauth_scopes            = lookup(facebook.value, "oauth_scopes")
        }
      }

      dynamic "github" {
        for_each = lookup(auth_settings.value, "github") == null ? [] : ["github"]
        content {
          client_id                  = lookup(github.value, "app_id")
          client_secret              = lookup(github.value, "app_secret")
          client_secret_setting_name = lookup(github.value, "app_secret_setting_name")
          oauth_scopes               = lookup(github.value, "oauth_scopes")
        }
      }

      dynamic "google" {
        for_each = lookup(auth_settings.value, "google") == null ? [] : ["google"]
        content {
          client_id                  = lookup(google.value, "app_id")
          client_secret              = lookup(google.value, "app_secret")
          client_secret_setting_name = lookup(google.value, "app_secret_setting_name")
          oauth_scopes               = lookup(google.value, "oauth_scopes")
        }
      }

      dynamic "microsoft" {
        for_each = lookup(auth_settings.value, "microsoft") == null ? [] : ["microsoft"]
        content {
          client_id                  = lookup(microsoft.value, "app_id")
          client_secret              = lookup(microsoft.value, "app_secret")
          client_secret_setting_name = lookup(microsoft.value, "app_secret_setting_name")
          oauth_scopes               = lookup(microsoft.value, "oauth_scopes")
        }
      }

      dynamic "twitter" {
        for_each = lookup(auth_settings.value, "twitter") == null ? [] : ["twitter"]
        content {
          consumer_key                 = lookup(twitter.value, "consumer_key")
          consumer_secret              = lookup(twitter.value, "consumer_secret")
          consumer_secret_setting_name = lookup(twitter.value, "consumer_secret_setting_name")
        }
      }

      dynamic "active_directory" {
        for_each = lookup(auth_settings.value, "active_directory") == null ? [] : ["active_directory"]
        content {
          client_id                  = lookup(active_directory.value, "client_id")
          client_secret              = lookup(active_directory.value, "client_secret")
          client_secret_setting_name = lookup(active_directory.value, "client_secret_setting_name")
          allowed_audiences          = lookup(active_directory.value, "allowed_audiences")
        }
      }
    }
  }

  dynamic "auth_settings_v2" {
    for_each = lookup(var.linux_function_app[count.index], "auth_settings_v2") == null ? [] : ["auth_settings_v2"]
    content {
      auth_enabled                            = lookup(auth_settings_v2.value, "auth_enabled")
      require_authentication                  = lookup(auth_settings_v2.value, "require_authentication")
      require_https                           = lookup(auth_settings_v2.value, "require_https")
      runtime_version                         = lookup(auth_settings_v2.value, "runtime_version")
      config_file_path                        = lookup(auth_settings_v2.value, "config_file_path")
      unauthenticated_action                  = lookup(auth_settings_v2.value, "unauthenticated_action")
      default_provider                        = lookup(auth_settings_v2.value, "default_provider")
      http_route_api_prefix                   = lookup(auth_settings_v2.value, "http_route_api_prefix")
      forward_proxy_convention                = lookup(auth_settings_v2.value, "forward_proxy_convention")
      forward_proxy_custom_host_header_name   = lookup(auth_settings_v2.value, "forward_proxy_custom_host_header_name")
      forward_proxy_custom_scheme_header_name = lookup(auth_settings_v2.value, "forward_proxy_custom_scheme_header_name")
      excluded_paths                          = lookup(auth_settings_v2.value, "excluded_paths")

      dynamic "apple_v2" {
        for_each = lookup(auth_settings_v2.value, "apple_v2") == null ? [] : ["apple_v2"]
        content {
          client_id                  = lookup(apple_v2.value, "client_id")
          client_secret_setting_name = lookup(apple_v2.value, "client_secret_setting_name")
          login_scopes               = lookup(apple_v2.value, "login_scopes")
        }
      }

      dynamic "active_directory_v2" {
        for_each = lookup(auth_settings_v2.value, "active_directory_v2") == null ? [] : ["active_directory_v2"]
        content {
          client_id                            = lookup(active_directory_v2.value, "client_id")
          tenant_auth_endpoint                 = lookup(active_directory_v2.value, "tenant_auth_endpoint")
          client_secret_setting_name           = lookup(active_directory_v2.value, "client_secret_setting_name")
          client_secret_certificate_thumbprint = lookup(active_directory_v2.value, "client_secret_certificate_thumbprint")
          jwt_allowed_groups                   = lookup(active_directory_v2.value, "jwt_allowed_groups")
          jwt_allowed_client_applications      = lookup(active_directory_v2.value, "jwt_allowed_client_applications")
          allowed_groups                       = lookup(active_directory_v2.value, "allowed_groups")
          allowed_audiences                    = lookup(active_directory_v2.value, "allowed_audiences")
          allowed_applications                 = lookup(active_directory_v2.value, "allowed_applications")
          login_parameters                     = lookup(active_directory_v2.value, "login_parameters")
          www_authentication_disabled          = lookup(active_directory_v2.value, "www_authentication_disabled")
        }
      }

      dynamic "azure_static_web_app_v2" {
        for_each = lookup(auth_settings_v2.value, "azure_static_web_app_v2") == null ? [] : ["azure_static_web_app_v2"]
        content {
          client_id = lookup(azure_static_web_app_v2.value, "client_id")
        }
        
      }

      dynamic "custom_oidc_v2" {
        for_each = lookup(auth_settings_v2.value, "custom_oidc_v2") == null ? [] : ["custom_oidc_v2"]
        content {
          client_id                     = lookup(custom_oidc_v2.value, "client_id")
          name                          = lookup(custom_oidc_v2.value, "name")
          openid_configuration_endpoint = lookup(custom_oidc_v2.value, "openid_configuration_endpoint")
          name_claim_type               = lookup(custom_oidc_v2.value, "name_claim_type")
          scopes                        = lookup(custom_oidc_v2.value, "scopes")
          client_credential_method      = lookup(custom_oidc_v2.value, "client_credential_method")
          client_secret_setting_name    = lookup(custom_oidc_v2.value, "client_secret_setting_name")
          authorisation_endpoint        = lookup(custom_oidc_v2.value, "authorisation_endpoint")
          token_endpoint                = lookup(custom_oidc_v2.value, "token_endpoint")
          issuer_endpoint               = lookup(custom_oidc_v2.value, "issuer_endpoint")
          certification_uri             = lookup(custom_oidc_v2.value, "certification_uri")
        }
      }

      dynamic "facebook_v2" {
        for_each = lookup(auth_settings_v2.value, "facebook_v2") == null ? [] : ["facebook_v2"]
        content {
          app_id                  = lookup(facebook_v2.value, "app_id")
          app_secret_setting_name = lookup(facebook_v2.value, "app_secret_setting_name")
          graph_api_version       = lookup(facebook_v2.value, "graph_api_version")
          login_scopes            = lookup(facebook_v2.value, "login_scopes")
        }
      }

      dynamic "github_v2" {
        for_each = lookup(auth_settings_v2.value, "github_v2") == null ? [] : ["github_v2"]
        content {
          client_id                  = lookup(github_v2.value, "client_id")
          client_secret_setting_name = lookup(github_v2.value, "client_secret_setting_name")
          login_scopes               = lookup(github_v2.value, "login_scopes")
        }
      }

      dynamic "google_v2" {
        for_each = lookup(auth_settings_v2.value, "google_v2") == null ? [] : ["google_v2"]
        content {
          client_id                  = lookup(google_v2.value, "client_id")
          client_secret_setting_name = lookup(google_v2.value, "client_secret_setting_name")
          allowed_audiences          = lookup(google_v2.value, "allowed_audiences")
          login_scopes               = lookup(google_v2.value, "login_scopes")
        }
      }

      dynamic "microsoft_v2" {
        for_each = lookup(auth_settings_v2.value, "microsoft_v2") == null ? [] : ["microsoft_v2"]
        content {
          client_id                  = lookup(microsoft_v2.value, "client_id")
          client_secret_setting_name = lookup(microsoft_v2.value, "client_secret_setting_name")
          allowed_audiences          = lookup(microsoft_v2.value, "allowed_audiences")
          login_scopes               = lookup(microsoft_v2.value, "login_scopes")
        }
      }

      dynamic "twitter_v2" {
        for_each = lookup(auth_settings_v2.value, "twitter_v2") == null ? [] : ["twitter_v2"]
        content {
          consumer_key                 = lookup(twitter_v2.value, "consumer_key")
          consumer_secret_setting_name = lookup(twitter_v2.value, "consumer_secret_setting_name")
        }
      }

      dynamic "login" {
        for_each = lookup(auth_settings_v2.value, "login") == null ? [] : ["login"]
        content {
          logout_endpoint                   = lookup(login.value, "logout_endpoint")
          token_store_path                  = lookup(login.value, "token_store_path")
          token_store_sas_setting_name      = lookup(login.value, "token_store_sas_setting_name")
          cookie_expiration_convention      = lookup(login.value, "cookie_expiration_convention")
          cookie_expiration_time            = lookup(login.value, "cookie_expiration_time")
          nonce_expiration_time             = lookup(login.value, "nonce_expiration_time")
          validate_nonce                    = lookup(login.value, "validate_nonce")
          preserve_url_fragments_for_logins = lookup(login.value, "preserve_url_fragments_for_logins")
          token_store_enabled               = lookup(login.value, "token_store_enabled")
          token_refresh_extension_time      = lookup(login.value, "token_refresh_extension_time")
        }
      }
    }
  }

  dynamic "backup" {
    for_each = lookup(var.linux_function_app[count.index], "backup") == null ? [] : ["backup"]
    content {
      name                = lookup(backup.value, "name")
      storage_account_url = lookup(backup.value, "storage_account_url")
      enabled             = lookup(backup.value, "enabled")

      dynamic "schedule" {
        for_each = lookup(backup.value, "schedule") == null ? [] : ["schedule"]
        content {
          frequency_interval = lookup(schedule.value, "frequency_interval")
          frequency_unit     = lookup(schedule.value, "frequency_unit")
        }
      }
    }
  }

  dynamic "connection_string" {
    for_each = lookup(var.linux_function_app[count.index], "connection_string") == null ? [] : ["connection_string"]
    content {
      name  = lookup(connection_string.value, "name")
      type  = lookup(connection_string.value, "type")
      value = lookup(connection_string.value, "value")
    }
  }

  dynamic "identity" {
    for_each = lookup(var.linux_function_app[count.index], "identity") == null ? [] : ["identity"]
    content {
      type         = lookup(identity.value, "type")
      identity_ids = lookup(identity.value, "identity_ids")
    }
  }

  dynamic "storage_account" {
    for_each = lookup(var.linux_function_app[count.index], "storage_account") == null ? [] : ["storage_account"]
    content {
      access_key   = lookup(storage_account.value, "access_key")
      account_name = lookup(storage_account.value, "account_name")
      name         = lookup(storage_account.value, "name")
      share_name   = lookup(storage_account.value, "share_name")
      type         = lookup(storage_account.value, "type")
      mount_path   = lookup(storage_account.value, "mount_path")
    }
  }

  dynamic "sticky_settings" {
    for_each = lookup(var.linux_function_app[count.index], "sticky_settings") == null ? [] : ["sticky_settings"]
    content {
      app_setting_names       = lookup(sticky_settings.value, "app_setting_names")
      connection_string_names = lookup(sticky_settings.value, "connection_string_names")
    }
  }

  dynamic "site_config" {
    for_each = lookup(var.linux_function_app[count.index], "site_config") == null ? [] : ["site_config"]
    content {
      always_on                                     = lookup(site_config.value, "always_on")
      container_registry_use_managed_identity       = lookup(site_config.value, "container_registry_use_managed_identity")
      http2_enabled                                 = lookup(site_config.value, "http2_enabled")
      scm_use_main_ip_restriction                   = lookup(site_config.value, "scm_use_main_ip_restriction")
      runtime_scale_monitoring_enabled              = lookup(site_config.value, "runtime_scale_monitoring_enabled")
      remote_debugging_enabled                      = lookup(site_config.value, "remote_debugging_enabled")
      use_32_bit_worker                             = lookup(site_config.value, "use_32_bit_worker")
      vnet_route_all_enabled                        = lookup(site_config.value, "vnet_route_all_enabled")
      websockets_enabled                            = lookup(site_config.value, "websockets_enabled")
      remote_debugging_version                      = lookup(site_config.value, "remote_debugging_version")
      scm_minimum_tls_version                       = lookup(site_config.value, "scm_minimum_tls_version")
      api_definition_url                            = lookup(site_config.value, "api_definition_url")
      api_management_api_id                         = lookup(site_config.value, "api_management_api_id")
      application_insights_connection_string        = lookup(site_config.value, "application_insights_connection_string")
      application_insights_key                      = lookup(site_config.value, "application_insights_key")
      app_command_line                              = lookup(site_config.value, "app_command_line")
      container_registry_managed_identity_client_id = lookup(site_config.value, "container_registry_managed_identity_client_id")
      ftps_state                                    = lookup(site_config.value, "ftps_state")
      health_check_path                             = lookup(site_config.value, "health_check_path")
      managed_pipeline_mode                         = lookup(site_config.value, "managed_pipeline_mode")
      default_documents                             = lookup(site_config.value, "default_documents")
      elastic_instance_minimum                      = lookup(site_config.value, "elastic_instance_minimum")
      app_scale_limit                               = lookup(site_config.value, "app_scale_limit")
      health_check_eviction_time_in_min             = lookup(site_config.value, "health_check_eviction_time_in_min")
      pre_warmed_instance_count                     = lookup(site_config.value, "pre_warmed_instance_count")
      worker_count                                  = lookup(site_config.value, "worker_count")

      dynamic "application_stack" {
        for_each = lookup(site_config.value, "application_stack") == null ? [] : ["application_stack"]
        content {
          dotnet_version              = lookup(application_stack.value, "dotnet_version")
          java_version                = lookup(application_stack.value, "java_version")
          node_version                = lookup(application_stack.value, "node_version")
          python_version              = lookup(application_stack.value, "python_version")
          powershell_core_version     = lookup(application_stack.value, "powershell_core_version")
          use_dotnet_isolated_runtime = lookup(application_stack.value, "use_dotnet_isolated_runtime")
        }

        dynamic "docker" {
          for_each = lookup(site_config.value, "docker") == null ? [] : ["docker"]
          content {
            image_name        = lookup(docker.value, "image_name")
            image_tag         = lookup(docker.value, "image_tag")
            registry_url      = lookup(docker.value, "registry_url")
            registry_password = lookup(docker.value, "registry_password")
            registry_username = lookup(docker.value, "registry_username")
          }
        }
      }

      dynamic "app_service_logs" {
        for_each = lookup(site_config.value, "app_service_logs") == null ? [] : ["app_service_logs"]
        content {
          disk_quota_mb         = lookup(app_service_logs.value, "disk_quota_mb")
          retention_period_days = lookup(app_service_logs.value, "retention_period_days")
        }
      }

      dynamic "cors" {
        for_each = lookup(site_config.value, "cors") == null ? [] : ["cors"]
        content {
          allowed_origins     = lookup(cors.value, "allowed_origins")
          support_credentials = lookup(cors.value, "support_credentials")
        }
      }

      dynamic "ip_restriction" {
        for_each = lookup(site_config.value, "ip_restriction") == null ? [] : ["ip_restriction"]
        content {
          action                    = lookup(ip_restriction.value, "action")
          ip_address                = lookup(ip_restriction.value, "ip_address")
          name                      = lookup(ip_restriction.value, "name")
          priority                  = lookup(ip_restriction.value, "priority")
          service_tag               = lookup(ip_restriction.value, "service_tag")
          virtual_network_subnet_id = lookup(ip_restriction.value, "virtual_network_subnet_id")

          dynamic "headers" {
            for_each = lookup(ip_restriction.value, "headers") == null ? [] : ["headers"]
            content {
              x_azure_fdid      = lookup(headers.value, "x_azure_fdid")
              x_fd_health_probe = lookup(headers.value, "x_fd_health_probe")
              x_forwarded_for   = lookup(headers.value, "x_forwarded_for")
              x_forwarded_host  = lookup(headers.value, "x_forwarded_host")
            }
          }
        }
      }

      dynamic "scm_ip_restriction" {
        for_each = lookup(site_config.value, "scm_ip_restriction") == null ? [] : ["scm_ip_restriction"]
        content {
          action                    = lookup(scm_ip_restriction.value, "action")
          ip_address                = lookup(scm_ip_restriction.value, "ip_address")
          name                      = lookup(scm_ip_restriction.value, "name")
          priority                  = lookup(scm_ip_restriction.value, "priority")
          service_tag               = lookup(scm_ip_restriction.value, "service_tag")
          virtual_network_subnet_id = lookup(scm_ip_restriction.value, "virtual_network_subnet_id")

          dynamic "headers" {
            for_each = lookup(scm_ip_restriction.value, "headers") == null ? [] : ["headers"]
            content {
              x_azure_fdid      = lookup(headers.value, "x_azure_fdid")
              x_fd_health_probe = lookup(headers.value, "x_fd_health_probe")
              x_forwarded_for   = lookup(headers.value, "x_forwarded_for")
              x_forwarded_host  = lookup(headers.value, "x_forwarded_host")
            }
          }
        }
      }
    }
  }
}

resource "azurerm_linux_function_app_slot" "this" {
  count = length(var.linux_function_app_slot) == "0" ? "0" : length(var.linux_function_app)
  function_app_id = try(
    element(azurerm_linux_function_app.this.*.id, lookup(var.linux_function_app_slot[count.index], "function_app_id"))
  )
  name = lookup(var.linux_function_app_slot[count.index], "name")
}

resource "azurerm_linux_web_app" "this" {
  count = length(var.linux_function_app) == "0" ? "0" : length(var.service_plan)
  location = try(
    element(azurerm_service_plan.this.*.location, lookup(var.linux_web_app[count.index], "service_plan_id"))
  )
  name                = lookup(var.linux_web_app[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.name
  service_plan_id = try(
    element(azurerm_service_plan.this.*.id, lookup(var.linux_web_app[count.index], "service_plan_id"))
  )
}

resource "azurerm_linux_web_app_slot" "this" {
  count = length(var.linux_web_app_slot) == "0" ? "0" : length(var.linux_web_app)
  app_service_id = try(
    element(azurerm_linux_web_app.this.*.id, lookup(var.linux_web_app_slot[count.index], "app_service_id"))
  )
  name = lookup(var.linux_web_app_slot[count.index], "name")
}

resource "azurerm_service_plan" "this" {
  count               = length(var.service_plan)
  location            = data.azurerm_resource_group.this.location
  name                = lookup(var.service_plan[count.index], "name")
  os_type             = lookup(var.service_plan[count.index], "os_type")
  resource_group_name = data.azurerm_resource_group.this.name
  sku_name            = lookup(var.service_plan[count.index], "sku_name")
}

resource "azurerm_source_control_token" "this" {
  count = length(var.source_control_token)
  token = lookup(var.source_control_token[count.index], "token")
  type  = lookup(var.source_control_token[count.index], "type")
}

resource "azurerm_static_site" "this" {
  count               = length(var.static_site)
  location            = data.azurerm_resource_group.this.location
  name                = lookup(var.static_site[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_static_site_custom_domain" "this" {
  count       = length(var.static_site_custom_domain) == "0" ? "0" : length(var.static_site)
  domain_name = lookup(var.static_site_custom_domain[count.index], "domain_name")
  static_site_id = try(
    element(azurerm_static_site.this.*.id, lookup(var.static_site_custom_domain[count.index], "static_site_id"))
  )
}

resource "azurerm_web_app_active_slot" "this" {
  count = length(var.web_app_active_slot) == "0" ? "0" : (length(var.windows_web_app_slot) || length(var.linux_web_app_slot))
  slot_id = try(
    element(azurerm_windows_web_app_slot.this.*.id, lookup(var.web_app_active_slot[count.index], "slot_id")),
    element(azurerm_linux_web_app_slot.this.*.id, lookup(var.web_app_active_slot[count.index], "slot_id"))
  )
}

resource "azurerm_web_app_hybrid_connection" "this" {
  count    = length(var.web_app_hybrid_connection) == "0" ? "0" : length(var.windows_web_app)
  hostname = lookup(var.web_app_hybrid_connection[count.index], "hostname")
  port     = lookup(var.web_app_hybrid_connection[count.index], "port")
  relay_id = lookup(var.web_app_hybrid_connection[count.index], "relay_id")
  web_app_id = try(
    element(azurerm_windows_web_app.this.*.id, lookup(var.web_app_hybrid_connection[count.index], "web_app_id"))
  )
}

resource "azurerm_windows_function_app" "this" {
  count               = length(var.windows_function_app) == "0" ? "0" : length(var.service_plan)
  location            = data.azurerm_resource_group.this.location
  name                = lookup(var.windows_function_app[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.name
  service_plan_id = try(
    element(azurerm_service_plan.this.*.id, lookup(var.windows_function_app[count.index], "service_plan_id"))
  )
}

resource "azurerm_windows_function_app_slot" "this" {
  count = length(var.windows_function_app_slot) == "0" ? "0" : length(var.windows_function_app)
  function_app_id = try(
    element(azurerm_windows_function_app.this.*.id, lookup(var.windows_function_app_slot[count.index], "function_app_id"))
  )
  name = lookup(var.windows_function_app_slot[count.index], "name")
}

resource "azurerm_windows_web_app" "this" {
  count = length(var.windows_web_app) == "0" ? "0" : length(var.service_plan)
  location = try(
    element(azurerm_service_plan.this.*.location, lookup(var.windows_web_app[count.index], "service_plan_id"))
  )
  name                = lookup(var.windows_web_app[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.name
  service_plan_id = try(
    element(azurerm_service_plan.this.*.id, lookup(var.windows_web_app[count.index], "service_plan_id"))
  )
}

resource "azurerm_windows_web_app_slot" "this" {
  count = length(var.windows_web_app_slot) == "0" ? "0" : length(var.windows_web_app)
  app_service_id = try(
    element(azurerm_windows_web_app.this.*.id, lookup(var.windows_function_app_slot[count.index], "app_service_id"))
  )
  name = lookup(var.windows_function_app_slot[count.index], "name")
}