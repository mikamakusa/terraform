variable "tags" {
  type    = map(string)
  default = {}
}

variable "resource_group_name" {
  type    = string
  default = null
}

variable "storage_account_name" {
  type    = string
  default = null
}

variable "batch_account_name" {
  type    = string
  default = null
}

variable "user_assigned_identity_name" {
  type    = string
  default = null
}

variable "user_assigned_identity" {
  type = list(map(object({
    location          = string
    name              = string
    resource_group_id = number
    tags              = optional(map(string))
  })))
  default = []
}

variable "resource_group" {
  type = list(map(object({
    id       = number
    location = string
    name     = string
    tags     = optional(map(string))
  })))
  default = []
}

variable "storage_account" {
  type = list(map(object({
    id                       = number
    account_replication_type = string
    account_tier             = string
    location                 = string
    name                     = string
    resource_group_id        = number
  })))
  default = []
}

variable "batch_account" {
  type = list(map(object({
    id                                  = number
    name                                = string
    resource_group_id                   = number
    public_network_access_enabled       = optional(bool, false)
    pool_allocation_mode                = optional(string)
    storage_account_id                  = optional(number)
    storage_account_authentication_mode = optional(string)
    storage_account_node_identity       = optional(string)
    allowed_authentication_modes        = optional(list(string))
    tags                                = optional(map(string))
  })))
  default = []
}

variable "batch_application" {
  type = list(map(object({
    id                = number
    account_name      = string
    name              = string
    resource_group_id = number
    allow_updates     = bool
    default_version   = optional(string)
    display_name      = optional(string)
  })))
  default = []
}

variable "batch_certificate" {
  type = list(map(object({
    id                = number
    account_id        = number
    certificate       = string
    format            = string
    resource_group_id = number
    thumbprint        = string
    password          = optional(string)
  })))
  default = []
}

variable "batch_job" {
  type = list(map(object({
    id                            = number
    batch_pool_id                 = number
    name                          = string
    common_environment_properties = optional(map(string))
    display_name                  = optional(string)
    task_retry_maximum            = optional(number)
    priority                      = optional(number)
  })))
  default = []
}

variable "batch_pool" {
  type = list(map(object({
    id                             = number
    account_id                     = number
    name                           = string
    node_agent_sku_id              = string
    resource_group_id              = number
    vm_size                        = string
    stop_pending_resize_operation  = optional(bool, false)
    license_type                   = optional(string)
    max_tasks_per_node             = optional(number)
    display_name                   = optional(string)
    inter_node_communication       = optional(string)
    metadata                       = optional(map(string))
    os_disk_placement              = optional(string)
    target_node_communication_mode = optional(string)
    storage_image_reference = optional(list(object({
      publisher = optional(string)
      offer     = optional(string)
      sku       = optional(string)
      version   = optional(string)
      id        = optional(string)
    })), [])
    data_disks = optional(list(object({
      disk_size_gb         = optional(string)
      lun                  = optional(string)
      caching              = optional(string)
      storage_account_type = optional(string)
    })), [])
    disk_encryption = optional(list(object({
      disk_encryption_target = optional(string)
    })), [])
    extensions = optional(list(object({
      name                       = optional(string)
      publisher                  = optional(string)
      type                       = optional(string)
      type_handler_version       = optional(string)
      auto_upgrade_minor_version = optional(string)
      automatic_upgrade_enabled  = optional(string)
      settings_json              = optional(string)
      protected_settings         = optional(string)
      provision_after_extensions = optional(string)
    })), [])
    identity = optional(list(object({
      type        = string
      identity_id = string
    })), [])
    fixed_scale = optional(list(object({
      node_deallocation_method  = optional(string)
      target_dedicated_nodes    = optional(number)
      target_low_priority_nodes = optional(number)
      resize_timeout            = optional(string)
    })), [])
    auto_scale = optional(list(object({
      formula             = string
      evaluation_interval = optional(string)
    })), [])
    start_task = optional(list(object({
      command_line                  = string
      task_retry_maximum            = optional(number)
      wait_for_success              = optional(bool, false)
      common_environment_properties = optional(map(string))
      user_identity = optional(list(object({
        user_name = optional(string)
        auto_user = optional(list(object({
          elevation_level = optional(string)
          scope           = optional(string)
        })), [])
      })), [])
      resource_file = optional(list(object({
        auto_storage_container_name = optional(string)
        blob_prefix                 = optional(string)
        file_mode                   = optional(string)
        file_path                   = optional(string)
        http_url                    = optional(string)
        storage_container_url       = optional(string)
        user_assigned_identity_id   = optional(string)
      })), [])
      container = optional(list(object({
        image_name        = string
        run_options       = optional(string)
        working_directory = optional(string)
        registry = optional(list(object({
          registry_server           = string
          password                  = optional(string)
          user_assigned_identity_id = optional(string)
          user_name                 = optional(string)
        })), [])
      })), [])
    })), [])
    certificate = optional(list(object({
      id             = string
      store_location = string
      store_name     = optional(string)
      visibility     = optional(list(string))
    })), [])
    container_configuration = optional(list(object({
      type                  = optional(string)
      container_image_names = optional(list(string))
      container_registries = optional(object({
        registry_server           = optional(string)
        user_name                 = optional(string)
        password                  = optional(string)
        user_assigned_identity_id = optional(string)
      }))
    })), [])
    mount = optional(list(object({
      azure_blob_file_system = optional(list(object({
        account_name        = string
        container_name      = string
        relative_mount_path = string
        account_key         = optional(string)
        sas_key             = optional(string)
        identity_id         = optional(string)
        blobfuse_options    = optional(string)
      })), [])
      azure_file_share = optional(list(object({
        account_key         = string
        account_name        = string
        azure_file_url      = string
        relative_mount_path = string
        mount_options       = optional(string)
      })), [])
      cifs_mount = optional(list(object({
        password            = string
        relative_mount_path = string
        source              = string
        user_name           = string
        mount_options       = optional(string)
      })), [])
      nfs_mount = optional(list(object({
        relative_mount_path = string
        source              = string
        mount_options       = optional(string)
      })), [])
    })), [])
    network_configuration = optional(list(object({
      subnet_id                        = string
      dynamic_vnet_assignment_scope    = optional(string)
      public_ips                       = optional(list(string))
      public_address_provisioning_type = optional(string)
      endpoint_configuration = optional(list(object({
        backend_port        = number
        frontend_port_range = string
        name                = string
        protocol            = string
        network_security_group_rules = optional(list(object({
          access                = string
          priority              = number
          source_address_prefix = string
          source_port_ranges    = optional(list(string))
        })))
      })))
    })), [])
    node_placement = optional(list(object({
      policy = optional(string)
    })), [])
    task_scheduling_policy = optional(list(object({
      node_fill_type = optional(string)
    })), [])
    user_accounts = optional(list(object({
      elevation_level = string
      name            = string
      password        = optional(string)
      linux_user_configuration = optional(object({
        uid             = optional(number)
        gid             = optional(number)
        ssh_private_key = optional(string)
      }))
      windows_user_configuration = optional(object({
        login_mode = string
      }))
    })), [])
    windows = optional(list(object({
      enable_automatic_updates = optional(bool, false)
    })), [])
  })))
  default = []
}