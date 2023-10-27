variable "resource_group_name" {
  type    = string
  default = null
}

variable "key_vault_name" {
  type    = string
  default = null
}

variable "user_assigned_identity_name" {
  type    = string
  default = null
}

variable "vault_secret_name" {
  type    = string
  default = null
}

variable "vault_key_name" {
  type    = string
  default = null
}

variable "role_definition_name" {
  type    = string
  default = null
}

variable "management_group_name" {
  type    = string
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
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

variable "user_assigned_identity" {
  type = list(map(object({
    location          = string
    name              = string
    resource_group_id = number
    tags              = optional(map(string))
  })))
  default = []
}

variable "key_vault" {
  type = list(map(object({
    id                              = number
    location                        = string
    name                            = string
    resource_group_id               = number
    sku_name                        = string
    enable_rbac_authorization       = optional(bool, false)
    enabled_for_deployment          = optional(bool, false)
    enabled_for_disk_encryption     = optional(bool, false)
    enabled_for_template_deployment = optional(bool, false)
    purge_protection_enabled        = optional(bool, false)
    public_network_access_enabled   = optional(bool, false)
    soft_delete_retention_days      = optional(number)
    tags                            = optional(map(string))
    contact = optional(list(object({
      email = string
      name  = optional(string)
      phone = optional(string)
    })), [])
    network_acls = optional(list(object({
      bypass                     = string
      default_action             = string
      ip_rules                   = optional(list(string))
      virtual_network_subnet_ids = optional(list(string))
    })), [])
    access_policy = optional(list(object({
      application_id          = optional(string)
      certificate_permissions = optional(list(string))
      key_permissions         = optional(list(string))
      secret_permissions      = optional(list(string))
      storage_permissions     = optional(list(string))
    })), [])
  })))
  default = []
}

variable "key_vault_access_policy" {
  type = list(map(object({
    id                      = number
    key_vault_id            = number
    application_id          = optional(string)
    certificate_permissions = optional(list(string))
    key_permissions         = optional(list(string))
    secret_permissions      = optional(list(string))
    storage_permissions     = optional(string)
  })))
  default = []
}

variable "key" {
  type = list(map(object({
    id              = number
    key_opts        = list(string)
    key_type        = string
    key_vault_id    = number
    name            = string
    key_size        = optional(number)
    curve           = optional(string)
    not_before_date = optional(string)
    expiration_date = optional(string)
    tags            = optional(map(string))
    rotation_policy = optional(list(object({
      expire_after         = optional(string)
      notify_before_expiry = optional(string)
      time_after_creation  = optional(string)
      time_before_expiry   = optional(string)
    })), [])
  })))
  default = []
}

variable "secrets" {
  type = list(map(object({
    id              = number
    key_vault_id    = number
    name            = string
    value           = string
    content_type    = string
    tags            = optional(list(string))
    not_before_date = optional(string)
    expiration_date = optional(string)
  })))
  default = []
}

variable "app_configuration" {
  type = list(map(object({
    id                         = number
    location                   = string
    name                       = string
    resource_group_id          = number
    local_auth_enabled         = optional(bool, false)
    public_network_access      = optional(string)
    purge_protection_enabled   = optional(bool, false)
    sku                        = optional(string)
    soft_delete_retention_days = optional(number)
    identity = optional(list(object({
      type         = string
      identity_ids = list(number)
    })), [])
    encryption = optional(list(object({
      key_vault_key_id = optional(number)
    })), [])
    replica = optional(list(object({
      location = string
      name     = string
    })), [])
  })))
  default = []
}

variable "role_assignment" {
  type = list(map(object({
    id                               = number
    name                             = optional(string)
    condition                        = optional(string)
    condition_version                = optional(string)
    description                      = optional(string)
    skip_service_principal_aad_check = optional(bool, false)
  })))
  default = []
}

variable "feature" {
  type = list(map(object({
    id                      = number
    configuration_store_id  = number
    name                    = string
    description             = optional(string)
    key                     = optional(string)
    label                   = optional(string)
    locked                  = optional(bool, false)
    percentage_filter_value = optional(number)
    tags                    = optional(map(string))
    targeting_filter = optional(list(object({
      default_rollout_percentage = number
      users                      = optional(list(string))
      groups = optional(list(object({
        name               = string
        rollout_percentage = number
      })), [])
    })), [])
    timewindow_filter = optional(list(object({
      start = optional(string)
      end   = optional(string)
    })), [])
  })))
  default = []
}

variable "configuration_key" {
  type = list(map(object({
    id                     = number
    configuration_store_id = number
    key                    = string
    content_type           = optional(string)
    label                  = optional(string)
    value                  = optional(string)
    locked                 = optional(bool, false)
    type                   = optional(string)
    vault_key_id           = optional(number)
    tags                   = optional(map(string))
  })))
  default = []
}