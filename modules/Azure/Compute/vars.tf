variable "resource_group_name" {
  type    = string
  default = null
}

variable "tags" {
  type = map(string)
}

variable "keyvault_name" {
  type    = string
  default = null
}

variable "keyvault_key_name" {
  type    = string
  default = null
}

variable "image_gallery" {
  type    = string
  default = null
}

variable "storage_account" {
  type    = string
  default = null
}

variable "storage_account_container" {
  type    = string
  default = null
}

variable "blob_name" {
  type    = string
  default = null
}

variable "availability_set" {
  type = map(object({
    platform_fault_domain_count  = optional(number)
    platform_update_domain_count = optional(number)
    proximity_placement_group_id = optional(string)
    managed                      = optional(bool)
    tags                         = optional(map(string))
  }))
  default = null
}

variable "capacity_reservation" {
  type = map(object({
    sku = object({
      name     = string
      capacity = number
    })
    zone = optional(list(string))
    tags = optional(map(string))
  }))
  default = null
}

variable "dedicated_host" {
  type = map(object({
    platform_fault_domain       = number
    sku_name                    = string
    auto_replace_on_failure     = optional(bool)
    license_type                = optional(string)
    tags                        = optional(map(string))
    automatic_placement_enabled = optional(bool)
    zone                        = optional(string)
  }))
  default = null
}

variable "disk_access" {
  type = map(object({
    tags = optional(map(string))
  }))
}

variable "disk_encryption_set" {
  type = map(object({
    auto_key_rotation_enabled = optional(bool)
    encryption_type           = optional(string)
    federated_client_id       = optional(string)
    identity = optional(object({
      type         = optional(string)
      identity_ids = optional(list(string))
    }))
    tags = optional(map(string))
  }))
  default = null
}

variable "managed_disk" {
  type = map(object({
    storage_account_type             = string
    create_option                    = string
    tags                             = optional(map(string))
    source_uri                       = optional(string)
    disk_size_gb                     = optional(number)
    upload_size_bytes                = optional(number)
    source_resource_id               = optional(string)
    image_reference_id               = optional(string)
    disk_encryption_set_id           = optional(string)
    disk_iops_read_only              = optional(number)
    disk_iops_read_write             = optional(number)
    disk_mbps_read_only              = optional(number)
    disk_mbps_read_write             = optional(number)
    secure_vm_disk_encryption_set_id = optional(string)
    edge_zone                        = optional(string)
    hyper_v_generation               = optional(string)
    gallery_image_reference_id       = optional(string)
    logical_sector_size              = optional(number)
    os_type                          = optional(string)
    storage_account_id               = optional(string)
    tier                             = optional(string)
    max_shares                       = optional(number)
    trusted_launch_enabled           = optional(bool)
    security_type                    = optional(string)
    on_demand_bursting_enabled       = optional(bool)
    zone                             = optional(string)
    network_access_policy            = optional(string)
    disk_access_id                   = optional(string)
    public_network_access_enabled    = optional(bool)
    encryption_settings = optional(object({
      disk_encryption_key = optional(object({
        secret_url      = optional(string)
        source_vault_id = optional(string)
      }))
      key_encryption_key = optional(object({
        key_url         = optional(string)
        source_vault_id = optional(string)
      }))
    }))
    encryption_settings = optional(object({
      disk_encryption_key = optional(object({
        secret_url      = optional(string)
        source_vault_id = optional(string)
      }))
      key_encryption_key = optional(object({
        key_url         = optional(string)
        source_vault_id = optional(string)
      }))
    }))
  }))
  default = null
  validation {
    condition     = contains(["Standard_LRS", "StandardSSD_ZRS", "Premium_LRS", "PremiumV2_LRS", "Premium_ZRS", "StandardSSD_LRS", "UltraSSD_LRS"], var.managed_disk.storage_account_type)
    error_message = "Allowed values are : Standard_LRS, StandardSSD_ZRS, Premium_LRS, PremiumV2_LRS, Premium_ZRS, StandardSSD_LRS or UltraSSD_LRS."
  }
  validation {
    condition     = contains(["Import", "ImportSecure", "Empty", "Copy", "FromImage", "Restore", "Upload"], var.managed_disk.create_option)
    error_message = "Allowed values are : \"Import\", \"ImportSecure\", \"Empty\", \"Copy\", \"FromImage\", \"Restore\", \"Upload\"."
  }
}
