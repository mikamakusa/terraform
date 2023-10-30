resource "azurerm_resource_group" "this" {
  count    = length(var.resource_group) && var.resource_group_name == null
  location = lookup(var.resource_group[count.index], "location")
  name     = lookup(var.resource_group[count.index], "name")
  tags = merge(
    var.tags,
    lookup(var.resource_group[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
}

resource "azurerm_user_assigned_identity" "this" {
  count    = length(var.user_assigned_identity)
  location = lookup(var.user_assigned_identity[count.index], "location")
  name     = lookup(var.user_assigned_identity[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name,
    element(azurerm_resource_group.this.*.name, lookup(var.user_assigned_identity[count.index], "resource_group_id"))
  )
  tags = merge(
    var.tags,
    lookup(var.user_assigned_identity[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
}

resource "azurerm_storage_account" "this" {
  count                    = length(var.storage_account)
  account_replication_type = lookup(var.storage_account[count.index], "account_replication_type")
  account_tier             = lookup(var.storage_account[count.index], "account_tier")
  location                 = lookup(var.storage_account[count.index], "location")
  name                     = lookup(var.storage_account[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name,
    element(azurerm_resource_group.this.*.name, lookup(var.storage_account[count.index], "resource_group_id"))
  )
}

resource "azurerm_batch_account" "this" {
  count = length(var.batch_account)
  location = try(
    data.azurerm_resource_group.this.location,
    element(azurerm_resource_group.this.*.location, lookup(var.batch_account[count.index], "resource_group_id"))
  )
  name = lookup(var.batch_account[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name,
    element(azurerm_resource_group.this.*.name, lookup(var.batch_account[count.index], "resource_group_id"))
  )
  public_network_access_enabled = lookup(var.batch_account[count.index], "public_network_access_enabled")
  pool_allocation_mode          = lookup(var.batch_account[count.index], "pool_allocation_mode")
  storage_account_id = try(
    data.azurerm_storage_account.this.id,
    element(azurerm_storage_account.this.id, lookup(var.batch_account[count.index], "storage_account_id"))
  )
  storage_account_authentication_mode = lookup(var.batch_account[count.index], "storage_account_authentication_mode")
  storage_account_node_identity       = lookup(var.batch_account[count.index], "storage_account_node_identity")
  allowed_authentication_modes        = lookup(var.batch_account[count.index], "allowed_authentication_modes")
  tags = merge(
    var.tags,
    lookup(var.batch_account[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
}

resource "azurerm_batch_application" "this" {
  count = length(var.batch_application)
  account_name = try(
    data.azurerm_batch_account.this.name,
    element(azurerm_batch_account.this.*.name, lookup(var.batch_application[count.index], "account_id"))
  )
  name = lookup(var.batch_application[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name,
    element(azurerm_resource_group.this.*.name, lookup(var.batch_application[count.index], "resource_group_id"))
  )
  allow_updates   = lookup(var.batch_application[count.index], "allow_updates")
  default_version = lookup(var.batch_application[count.index], "default_version")
  display_name    = lookup(var.batch_application[count.index], "display_name")
}

resource "azurerm_batch_certificate" "this" {
  count = length(var.batch_certificate)
  account_name = try(
    data.azurerm_batch_account.this.name,
    element(azurerm_batch_account.this.*.name, lookup(var.batch_certificate[count.index], "account_id"))
  )
  certificate = join("/", [path.cwd, "certificate", filebase64(lookup(var.batch_certificate[count.index], "certificate"))])
  format      = lookup(var.batch_certificate[count.index], "format")
  resource_group_name = try(
    data.azurerm_resource_group.this.name,
    element(azurerm_resource_group.this.*.name, lookup(var.batch_certificate[count.index], "resource_group_id"))
  )
  thumbprint           = lookup(var.batch_certificate[count.index], "thumbprint")
  thumbprint_algorithm = "SHA1"
  password             = sensitive(lookup(var.batch_certificate[count.index], "password"))
}

resource "azurerm_batch_job" "this" {
  count = length(var.batch_job)
  batch_pool_id = try(
    element(azurerm_batch_pool.this.*.id, lookup(var.batch_job[count.index], "patch_pool_id"))
  )
  name                          = lookup(var.batch_job[count.index], "name")
  common_environment_properties = lookup(var.batch_job[count.index], "common_environment_properties")
  display_name                  = lookup(var.batch_job[count.index], "display_name")
  task_retry_maximum            = lookup(var.batch_job[count.index], "task_retry_maximum")
  priority                      = lookup(var.batch_job[count.index], "priority")
}

resource "azurerm_batch_pool" "this" {
  count = length(var.batch_pool)
  account_name = try(
    data.azurerm_batch_account.this.name,
    element(azurerm_batch_account.this.*.name, lookup(var.batch_pool[count.index], "account_id"))
  )
  name              = lookup(var.batch_pool[count.index], "name")
  node_agent_sku_id = lookup(var.batch_pool[count.index], "node_agent_sku_id")
  resource_group_name = try(
    data.azurerm_resource_group.this.name,
    element(azurerm_resource_group.this.*.name, lookup(var.batch_pool[count.index], "resource_group_id"))
  )
  vm_size                        = lookup(var.batch_pool[count.index], "vm_size")
  stop_pending_resize_operation  = lookup(var.batch_pool[count.index], "stop_pending_resize_operation")
  license_type                   = lookup(var.batch_pool[count.index], "license_type")
  max_tasks_per_node             = lookup(var.batch_pool[count.index], "max_tasks_per_node")
  display_name                   = lookup(var.batch_pool[count.index], "display_name")
  inter_node_communication       = lookup(var.batch_pool[count.index], "inter_node_communication")
  metadata                       = lookup(var.batch_pool[count.index], "metadata")
  os_disk_placement              = lookup(var.batch_pool[count.index], "os_disk_placement")
  target_node_communication_mode = lookup(var.batch_pool[count.index], "target_node_communication_mode")

  dynamic "storage_image_reference" {
    for_each = lookup(var.batch_pool[count.index], "storage_image_reference") == null ? [] : ["storage_image_reference"]
    content {
      publisher = lookup(storage_image_reference.value, "publisher")
      offer     = lookup(storage_image_reference.value, "offer")
      sku       = lookup(storage_image_reference.value, "sku")
      version   = lookup(storage_image_reference.value, "version")
      id        = lookup(storage_image_reference.value, "id")
    }
  }

  dynamic "data_disks" {
    for_each = lookup(var.batch_pool[count.index], "data_disks") == null ? [] : ["data_disks"]
    content {
      disk_size_gb         = lookup(data_disks.value, "disk_size_gb")
      lun                  = lookup(data_disks.value, "lun")
      caching              = lookup(data_disks.value, "caching")
      storage_account_type = lookup(data_disks.value, "storage_account_type")
    }
  }

  dynamic "disk_encryption" {
    for_each = lookup(var.batch_pool[count.index], "disk_encryption") == null ? [] : ["disk_encryption"]
    content {
      disk_encryption_target = lookup(disk_encryption.value, "disk_encryption_target")
    }
  }

  dynamic "extensions" {
    for_each = lookup(var.batch_pool[count.index], "extensions") == null ? [] : ["extensions"]
    content {
      name                       = lookup(extensions.value, "name")
      publisher                  = lookup(extensions.value, "publisher")
      type                       = lookup(extensions.value, "type")
      type_handler_version       = lookup(extensions.value, "type_handler_version")
      auto_upgrade_minor_version = lookup(extensions.value, "auto_upgrade_minor_version")
      automatic_upgrade_enabled  = lookup(extensions.value, "automatic_upgrade_enabled")
      settings_json              = lookup(extensions.value, "settings_json")
      protected_settings         = lookup(extensions.value, "protected_settings")
      provision_after_extensions = lookup(extensions.value, "provision_after_extensions")
    }
  }

  dynamic "identity" {
    for_each = lookup(var.batch_pool[count.index], "identity") == null ? [] : ["identity"]
    content {
      identity_ids = try(
        [data.azurerm_user_assigned_identity.this.name],
        element(azurerm_user_assigned_identity.this.*.id, lookup(identity.value, "identity_id"))
      )
      type = lookup(identity.value, "type")
    }
  }

  dynamic "fixed_scale" {
    for_each = lookup(var.batch_pool[count.index], "fixed_scale") == null ? [] : ["fixed_scale"]
    content {
      node_deallocation_method  = lookup(fixed_scale.value, "node_deallocation_method")
      target_dedicated_nodes    = lookup(fixed_scale.value, "target_dedicated_nodes")
      target_low_priority_nodes = lookup(fixed_scale.value, "target_low_priority_nodes")
      resize_timeout            = lookup(fixed_scale.value, "resize_timeout")
    }
  }

  dynamic "auto_scale" {
    for_each = lookup(var.batch_pool[count.index], "auto_scale") == null ? [] : ["auto_scale"]
    content {
      formula             = lookup(auto_scale.value, "formula")
      evaluation_interval = lookup(auto_scale.value, "evaluation_interval")
    }
  }

  dynamic "start_task" {
    for_each = lookup(var.batch_pool[count.index], "start_task") == null ? [] : ["start_task"]
    content {
      command_line                  = lookup(start_task.value, "command_line")
      task_retry_maximum            = lookup(start_task.value, "task_retry_maximum")
      wait_for_success              = lookup(start_task.value, "wait_for_success")
      common_environment_properties = lookup(start_task.value, "common_environment_properties")

      dynamic "user_identity" {
        for_each = lookup(start_task.value, "user_identity") == null ? [] : ["user_identity"]
        content {
          user_name = lookup(user_identity.value, "user_name")

          dynamic "auto_user" {
            for_each = lookup(user_identity.value, "auto_user") == null ? [] : ["auto_user"]
            content {
              elevation_level = lookup(auto_user.value, "elevation_level")
              scope           = lookup(auto_user.value, "scope")
            }
          }
        }
      }
      dynamic "resource_file" {
        for_each = lookup(start_task.value, "resource_file") == null ? [] : ["resource_file"]
        content {
          auto_storage_container_name = lookup(resource_file.value, "auto_storage_container_name")
          blob_prefix                 = lookup(resource_file.value, "blob_prefix")
          file_mode                   = lookup(resource_file.value, "file_mode")
          file_path                   = lookup(resource_file.value, "file_path")
          http_url                    = lookup(resource_file.value, "http_url")
          storage_container_url       = lookup(resource_file.value, "storage_container_url")
          user_assigned_identity_id   = lookup(resource_file.value, "user_assigned_identity_id")
        }
      }
      dynamic "container" {
        for_each = lookup(start_task.value, "container") == null ? [] : ["container"]
        content {
          image_name        = lookup(container.value, "image_name")
          run_options       = lookup(container.value, "run_options")
          working_directory = lookup(container.value, "working_directory")
          dynamic "registry" {
            for_each = lookup(container.value, "registry") == null ? [] : ["container"]
            content {
              registry_server           = lookup(registry.value, "registry_server")
              password                  = lookup(registry.value, "password")
              user_assigned_identity_id = lookup(registry.value, "user_assigned_identity_id")
              user_name                 = lookup(registry.value, "user_name")
            }
          }
        }
      }
    }
  }

  dynamic "certificate" {
    for_each = lookup(var.batch_pool[count.index], "certificate") == null ? [] : ["certificate"]
    content {
      id             = lookup(certificate.value, "id")
      store_location = lookup(certificate.value, "store_location")
      store_name     = lookup(certificate.value, "store_name")
      visibility     = lookup(certificate.value, "visibility")
    }
  }

  dynamic "container_configuration" {
    for_each = lookup(var.batch_pool[count.index], "container_configuration") == null ? [] : ["container_configuration"]
    content {
      type                  = lookup(container_configuration.value, "type")
      container_image_names = lookup(container_configuration.value, "container_image_names")
      dynamic "container_registries" {
        for_each = lookup(container_configuration.value, "container_registries")
        content {
          registry_server           = sensitive(lookup(container_registries.value, "registry_server"))
          user_name                 = sensitive(lookup(container_registries.value, "user_name"))
          password                  = sensitive(lookup(container_registries.value, "password"))
          user_assigned_identity_id = sensitive(lookup(container_registries.value, "user_assigned_identity_id"))
        }
      }
    }
  }

  dynamic "mount" {
    for_each = lookup(var.batch_pool[count.index], "mount") == null ? [] : ["mount"]
    content {
      dynamic "azure_blob_file_system" {
        for_each = lookup(mount.value, "azure_blob_file_system") == null ? [] : ["azure_blob_file_system"]
        content {
          account_name        = lookup(azure_blob_file_system.value, "account_name")
          container_name      = lookup(azure_blob_file_system.value, "container_name")
          relative_mount_path = lookup(azure_blob_file_system.value, "relative_mount_path")
          account_key         = lookup(azure_blob_file_system.value, "account_key")
          sas_key             = lookup(azure_blob_file_system.value, "sas_key")
          identity_id         = lookup(azure_blob_file_system.value, "identity_id")
          blobfuse_options    = lookup(azure_blob_file_system.value, "blobfuse_options")
        }
      }
      dynamic "azure_file_share" {
        for_each = lookup(mount.value, "azure_file_share") == null ? [] : ["azure_file_share"]
        content {
          account_key         = lookup(azure_file_share.value, "account_key")
          account_name        = lookup(azure_file_share.value, "account_name")
          azure_file_url      = lookup(azure_file_share.value, "azure_file_url")
          relative_mount_path = lookup(azure_file_share.value, "relative_mount_path")
          mount_options       = lookup(azure_file_share.value, "mount_options")
        }
      }
      dynamic "cifs_mount" {
        for_each = lookup(mount.value, "cifs_mount") == null ? [] : ["cifs_mount"]
        content {
          password            = lookup(cifs_mount.value, "password")
          relative_mount_path = lookup(cifs_mount.value, "relative_mount_path")
          source              = lookup(cifs_mount.value, "source")
          user_name           = lookup(cifs_mount.value, "user_name")
          mount_options       = lookup(cifs_mount.value, "mount_options")
        }
      }
      dynamic "nfs_mount" {
        for_each = lookup(mount.value, "nfs_mount") == null ? [] : ["nfs_mount"]
        content {
          relative_mount_path = lookup(nfs_mount.value, "relative_mount_path")
          source              = lookup(nfs_mount.value, "source")
          mount_options       = lookup(nfs_mount.value, "mount_options")
        }
      }
    }
  }

  dynamic "network_configuration" {
    for_each = lookup(var.batch_pool[count.index], "network_configuration") == null ? [] : ["network_configuration"]
    content {
      subnet_id                        = lookup(network_configuration.value, "subnet_id")
      dynamic_vnet_assignment_scope    = lookup(network_configuration.value, "dynamic_vnet_assignment_scope")
      public_ips                       = lookup(network_configuration.value, "public_ips")
      public_address_provisioning_type = lookup(network_configuration.value, "public_address_provisioning_type")
      dynamic "endpoint_configuration" {
        for_each = lookup(network_configuration.value, "endpoint_configuration") == null ? [] : ["endpoint_configuration"]
        content {
          backend_port        = lookup(endpoint_configuration.value, "backend_port")
          frontend_port_range = lookup(endpoint_configuration.value, "frontend_port_range")
          name                = lookup(endpoint_configuration.value, "name")
          protocol            = lookup(endpoint_configuration.value, "protocol")
          dynamic "network_security_group_rules" {
            for_each = lookup(endpoint_configuration.value, "network_security_group_rules") == null ? [] : ["network_security_group_rules"]
            content {
              access                = lookup(network_security_group_rules.value, "access")
              priority              = lookup(network_security_group_rules.value, "priority")
              source_address_prefix = lookup(network_security_group_rules.value, "source_address_prefix")
              source_port_ranges    = lookup(network_security_group_rules.value, "source_port_ranges")
            }
          }
        }
      }
    }
  }

  dynamic "node_placement" {
    for_each = lookup(var.batch_pool[count.index], "node_placement") == null ? [] : ["node_placement"]
    content {
      policy = lookup(node_placement.value, "policy")
    }
  }

  dynamic "task_scheduling_policy" {
    for_each = lookup(var.batch_pool[count.index], "task_scheduling_policy") == null ? [] : ["task_scheduling_policy"]
    content {
      node_fill_type = lookup(task_scheduling_policy.value, "node_fill_type")
    }
  }

  dynamic "user_accounts" {
    for_each = lookup(var.batch_pool[count.index], "user_accounts") == null ? [] : ["user_accounts"]
    content {
      elevation_level = lookup(user_accounts.value, "elevation_level")
      name            = sensitive(lookup(user_accounts.value, "name"))
      password        = sensitive(lookup(user_accounts.value, "password"))
      dynamic "linux_user_configuration" {
        for_each = lookup(user_accounts.value, "linux_user_configuration") == null ? [] : ["linux_user_configuration"]
        content {
          uid             = sensitive(lookup(linux_user_configuration.value, "uid"))
          gid             = sensitive(lookup(linux_user_configuration.value, "gid"))
          ssh_private_key = sensitive(lookup(linux_user_configuration.value, "ssh_private_key"))
        }
      }
      dynamic "windows_user_configuration" {
        for_each = lookup(user_accounts.value, "windows_user_configuration") == null ? [] : ["windows_user_configuration"]
        content {
          login_mode = lookup(windows_user_configuration.value, "login_mode")
        }
      }
    }
  }

  dynamic "windows" {
    for_each = lookup(var.batch_pool[count.index], "windows")
    content {
      enable_automatic_updates = lookup(windows.value, "enable_automatic_updates")
    }
  }
}