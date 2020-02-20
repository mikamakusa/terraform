resource "azurerm_container_group" "container_group" {
  count               = length(var.container_group)
  location            = lookup(var.container_group[count.index], "resource_group_id") == null ? var.resource_group_location : element(var.resource_group_location, lookup(var.container_group[count.index], "resource_group_id"))
  name                = lookup(var.container_group[count.index], "name")
  os_type             = lookup(var.container_group[count.index], "os_type")
  resource_group_name = lookup(var.container_group[count.index], "resource_group_id") == null ? var.resource_group_name : element(var.resource_group_name, lookup(var.container_group[count.index], "resource_group_id"))
  ip_address_type     = lookup(var.container_group[count.index], "ip_address_type")
  dns_name_label      = lookup(var.container_group[count.index], "dns_name_label")

  dynamic "container" {
    for_each = [for i in lookup(var.container_group[count.index], "container") : {
      ports                        = lookup(i, "ports")
      gpu                          = lookup(i, "gpu")
      volume                       = lookup(i, "volume")
      environment_variables        = lookup(i, "environment_variables")
      liveness_probe               = lookup(i, "liveness_probe")
      secure_environment_variables = lookup(i, "secure_environment_variables")
      readiness_probe              = lookup(i, "readiness_probe")
    }]
    content {
      cpu      = lookup(container.value, "cpu")
      image    = lookup(container.value, "image")
      memory   = lookup(container.value, "memory")
      name     = lookup(container.value, "name")
      commands = [lookup(container.value, "commands")]
      dynamic "volume" {
        for_each = container.value.volume == null ? [] : [for i in container.value.volume : {
          mount_path           = i.mount_path
          name                 = i.name
          share_name           = i.share_name
          storage_account_key  = i.storage_account_key
          storage_account_name = i.storage_account_name
          read_only            = i.read_only
        }]
        content {
          mount_path           = volume.value.mount_path
          name                 = volume.value.name
          share_name           = volume.value.share_name
          storage_account_key  = volume.value.storage_account_key
          storage_account_name = volume.value.storage_account_name
          read_only            = volume.value.read_only
        }
      }
      dynamic "ports" {
        for_each = container.value.ports == null ? [] : [for i in container.value.ports : {
          port     = i.port
          protocol = i.protocol
        }]
        content {
          port     = ports.value.port
          protocol = ports.value.protocol
        }
      }
      dynamic "gpu" {
        for_each = container.value.gpu == null ? [] : [for i in container.value.gpu : {
          count = i.count
          sku   = i.sku
        }]
        content {
          count = gpu.value.count
          sku   = gpu.value.sku
        }
      }
      dynamic "liveness_probe" {
        for_each = container.value.liveness_probe == null ? [] : [for i in container.value.liveness_probe : {
          exec                  = i.exec
          failure_threshold     = i.failure_threshold
          success_threshold     = i.success_threshold
          initial_delay_seconds = i.initial_delay_seconds
          period_seconds        = i.period_seconds
          timeout_seconds       = i.timeout_seconds
          http_get              = lookup(i, "http_get")
        }]
        content {
          exec                  = [liveness_probe.value.exec]
          failure_threshold     = liveness_probe.value.failure_threshold
          success_threshold     = liveness_probe.value.success_threshold
          initial_delay_seconds = liveness_probe.value.initial_delay_seconds
          period_seconds        = liveness_probe.value.period_seconds
          timeout_seconds       = liveness_probe.value.timeout_seconds
          dynamic "http_get" {
            for_each = liveness_probe.value.http_get == null ? [] : [for i in liveness_probe.value.http_get : {
              path   = i.path
              port   = i.port
              schema = i.schema
            }]
            content {
              path   = http_get.value.path
              port   = http_get.value.port
              scheme = http_get.value.schema
            }
          }
        }
      }
      dynamic "readiness_probe" {
        for_each = container.value.readiness_probe == null ? [] : [for i in container.value.readiness_probe : {
          exec                  = i.exec
          failure_threshold     = i.failure_threshold
          initial_delay_seconds = i.initial_delay_seconds
          period_seconds        = i.period_seconds
          success_threshold     = i.success_threshold
          timeout_seconds       = i.timeout_seconds
          http_get              = lookup(i, http_get)
        }]
        content {
          exec                  = [readiness_probe.value.exec]
          failure_threshold     = readiness_probe.value.failure_threshold
          initial_delay_seconds = readiness_probe.value.initial_delay_seconds
          period_seconds        = readiness_probe.value.period_seconds
          success_threshold     = readiness_probe.value.success_threshold
          timeout_seconds       = readiness_probe.value.timeout_seconds
          dynamic "http_get" {
            for_each = readiness_probe.value.http_get == null ? [] : [for i in readiness_probe.value.http_group : {
              path   = i.path
              port   = i.port
              schema = i.schema
            }]
            content {
              path   = http_get.value.path
              port   = http_get.value.port
              scheme = http_get.value.schema
            }
          }
        }
      }
    }
  }
  dynamic "diagnostics" {
    for_each = [for i in lookup(var.container_group[count.index], "diagnostics") : {
      log_analytics = lookup(i, "log_analytics")
    }]
    content {
      dynamic "log_analytics" {
        for_each = diagnostics.value.log_analytics == null ? [] : [for i in diagnostics.value.log_analytics : {
          workspace_id  = i.workspace_id
          workspace_key = i.workspace_key
          log_type      = i.log_type
        }]
        content {
          workspace_id  = log_analytics.value.workspace_id
          workspace_key = log_analytics.value.workspace_key
          log_type      = log_analytics.value.log_type
          metadata {
            variables = ""
          }
        }
      }
    }
  }

  dynamic "image_registry_credential" {
    for_each = lookup(var.container_group[count.index], "image_registry_credential")
    content {
      password = lookup(image_registry_credential.value, "password")
      server   = lookup(image_registry_credential.value, "server")
      username = lookup(image_registry_credential.value, "usernaùe")
    }
  }
}
